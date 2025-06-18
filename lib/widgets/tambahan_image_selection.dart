import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/form_confirmation.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/widgets/delete_confirmation_dialog.dart';
import 'package:form_app/utils/image_picker_util.dart'; // Import the new utility
import 'package:form_app/providers/image_processing_provider.dart'; // Import the new provider
import 'package:form_app/widgets/custom_message_overlay.dart';
import 'package:form_app/pages/multi_shot_camera_screen.dart';

class TambahanImageSelection extends ConsumerStatefulWidget {
  final String identifier;
  final bool showNeedAttention;
  final bool isMandatory;
  final ValueNotifier<bool>? formSubmitted;
  final String defaultLabel;

  const TambahanImageSelection({
    super.key,
    required this.identifier,
    this.showNeedAttention = true,
    this.isMandatory = false,
    this.formSubmitted,
    this.defaultLabel = '',
  });

  @override
  ConsumerState<TambahanImageSelection> createState() => _TambahanImageSelectionState();
}

class _TambahanImageSelectionState extends ConsumerState<TambahanImageSelection> {
  int _currentIndex = 0;
  final TextEditingController _labelController = TextEditingController();
  final GlobalKey<FormFieldState<String>> _labelFieldKey = GlobalKey<FormFieldState<String>>();
  bool _isNeedAttentionChecked = false; // New state variable

  VoidCallback? _formSubmittedListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateControllersForCurrentIndex();
      // Initialize _isNeedAttentionChecked based on current image data
      final images = ref.read(tambahanImageDataProvider(widget.identifier));
      if (images.isNotEmpty && _currentIndex < images.length) {
        _isNeedAttentionChecked = images[_currentIndex].needAttention;
      }
    });

    if (widget.formSubmitted != null) {
      _formSubmittedListener = () {
        if (mounted && widget.formSubmitted!.value) {
          _labelFieldKey.currentState?.validate();
        }
      };
      widget.formSubmitted!.addListener(_formSubmittedListener!);
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    if (widget.formSubmitted != null && _formSubmittedListener != null) {
      widget.formSubmitted!.removeListener(_formSubmittedListener!);
    }
    super.dispose();
  }

  void _updateControllersForCurrentIndex() {
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
      final String displayedLabel = (currentImage.label == widget.defaultLabel) ? '' : currentImage.label;
      if (_labelController.text != displayedLabel) {
        _labelController.text = displayedLabel;
        _labelController.selection = TextSelection.fromPosition(TextPosition(offset: _labelController.text.length));
      }
      // Update _isNeedAttentionChecked when current image changes
      _isNeedAttentionChecked = currentImage.needAttention;

      if (mounted) {
        if (_currentIndex + 1 < images.length) {
          precacheImage(FileImage(File(images[_currentIndex + 1].imagePath)), context);
        }
        if (_currentIndex - 1 >= 0) {
          precacheImage(FileImage(File(images[_currentIndex - 1].imagePath)), context);
        }
      }
    } else {
      _labelController.clear();
      _isNeedAttentionChecked = false; // No image, so no attention needed
    }
    if (widget.formSubmitted?.value ?? false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _labelFieldKey.currentState?.validate();
        });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    // --- NEW LOGIC FOR CAMERA ---
    if (source == ImageSource.camera) {
      if (!mounted) return;
      FocusScope.of(context).unfocus();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MultiShotCameraScreen(
            imageIdentifier: widget.identifier,
            defaultLabel: widget.defaultLabel,
          ),
        ),
      );
      return; // Exit the function here
    }

    // --- EXISTING LOGIC FOR GALLERY ---
    if (source == ImageSource.gallery) {
      final List<XFile> imagesXFiles = await ImagePickerUtil.pickMultiImagesFromGallery();
      if (imagesXFiles.isNotEmpty && mounted) {
        ref.read(imageProcessingServiceProvider.notifier).taskStarted(widget.identifier);
        List<TambahanImageData> newImagesData = [];
        try {
          for (var imageFileXFile in imagesXFiles) {
            String? processedPath;
            processedPath = await ImagePickerUtil.processAndSaveImage(imageFileXFile);
            if (mounted && processedPath != null) {
              final newTambahanImage = TambahanImageData(
                imagePath: processedPath,
                label: widget.defaultLabel,
                needAttention: false,
                category: widget.identifier,
                isMandatory: widget.isMandatory,
              );
              newImagesData.add(newTambahanImage);
              ref.read(tambahanImageDataProvider(widget.identifier).notifier).addImage(newTambahanImage);
              if (mounted) {
                precacheImage(FileImage(File(processedPath)), context);
              }
            } else if (mounted && processedPath == null) {
              if (kDebugMode) print("Image processing failed for gallery image: ${imageFileXFile.name}");
              CustomMessageOverlay(context).show(message: 'Gagal memproses gambar: ${imageFileXFile.name}', backgroundColor: errorBorderColor, icon: Icons.photo_library);
            }
          }
        } catch (e) {
           if (mounted && kDebugMode) {
              if (kDebugMode) {
                print("Error during multi-gallery image processing: $e");
              }
              CustomMessageOverlay(context).show(message: 'Terjadi kesalahan memproses gambar: $e', backgroundColor: errorBorderColor, icon: Icons.error);
           }
        } finally {
          if (mounted) {
            ref.read(imageProcessingServiceProvider.notifier).taskFinished(widget.identifier);
          }
        }

        if (newImagesData.isNotEmpty && mounted) {
          setState(() {
            _currentIndex = ref.read(tambahanImageDataProvider(widget.identifier)).length - newImagesData.length;
            if (_currentIndex < 0) _currentIndex = 0;
            _updateControllersForCurrentIndex();
          });
        }
      }
    }
  }

  void _nextImage() {
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (_currentIndex < images.length - 1) {
      setState(() {
        _currentIndex++;
        _updateControllersForCurrentIndex();
      });
    }
  }

  void _previousImage() {
    if (_currentIndex > 0) {
      setState(() {
        _currentIndex--;
        _updateControllersForCurrentIndex();
      });
    }
  }

  void _deleteCurrentImageConfirmed() {
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (images.isNotEmpty && _currentIndex < images.length) {
      ref.read(tambahanImageDataProvider(widget.identifier).notifier).removeImageAtIndex(_currentIndex);
      setState(() {
        final newLength = images.length - 1;
        if (newLength == 0) {
          _currentIndex = 0;
        } else if (_currentIndex >= newLength) {
          _currentIndex = newLength -1;
        }
        _updateControllersForCurrentIndex();
      });
    }
  }

  void _showDeleteConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return DeleteConfirmationDialog(
          message: 'Apakah anda yakin ingin menghapus gambar tersebut?',
          onConfirm: () {
            Navigator.of(context).pop();
            _deleteCurrentImageConfirmed();
          },
          onCancel: () {
            Navigator.of(context).pop();
          },
        );
      },
    );
  }

  void _onLabelChanged(String newLabel) {
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
      final String labelToSave = newLabel.trim().isEmpty ? widget.defaultLabel : newLabel;
      ref
          .read(tambahanImageDataProvider(widget.identifier).notifier)
          .updateImageAtIndex(_currentIndex, currentImage.copyWith(label: labelToSave));
    }
  }

  void _onNeedAttentionChanged(bool newAttentionStatus) {
    setState(() {
      _isNeedAttentionChecked = newAttentionStatus;
    });
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
      ref.read(tambahanImageDataProvider(widget.identifier).notifier).updateImageAtIndex(
          _currentIndex, currentImage.copyWith(needAttention: newAttentionStatus));
    }
  }

  String _getDisplayLabel(String? label) {
    return (label == widget.defaultLabel) ? '' : (label ?? '');
  }

  @override
  Widget build(BuildContext context) {
    final tambahanImages = ref.watch(tambahanImageDataProvider(widget.identifier));
    final isProcessingImage = ref.watch(imageProcessingServiceProvider.select((s) => (s[widget.identifier] ?? 0) > 0));

    final TambahanImageData? currentImage =
        tambahanImages.isNotEmpty && _currentIndex < tambahanImages.length
            ? tambahanImages[_currentIndex]
            : null;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final currentImagesList = ref.read(tambahanImageDataProvider(widget.identifier));
        if (currentImagesList.isNotEmpty && _currentIndex >= currentImagesList.length) {
          setState(() {
            _currentIndex = (currentImagesList.length - 1).clamp(0, currentImagesList.length -1);
            _updateControllersForCurrentIndex();
          });
        } else if (currentImagesList.isEmpty && _currentIndex != 0) {
           setState(() {
            _currentIndex = 0;
            _updateControllersForCurrentIndex();
          });
        }
        final currentImageForController = currentImagesList.isNotEmpty && _currentIndex < currentImagesList.length
            ? currentImagesList[_currentIndex]
            : null;

        if (currentImageForController != null) {
          final String displayedLabel = _getDisplayLabel(currentImageForController.label);
          if (_labelController.text != displayedLabel) {
            _labelController.text = displayedLabel;
            _labelController.selection = TextSelection.fromPosition(TextPosition(offset: _labelController.text.length));
          }
        } else if (currentImageForController == null && _labelController.text.isNotEmpty) {
            _labelController.clear();
        }
      }
    });

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  _pickImage(ImageSource.camera);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: toggleOptionSelectedLengkapColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/camera.svg',
                          width: 30.0,
                          height: 30.0,
                          colorFilter: const ColorFilter.mode(
                              buttonTextColor, BlendMode.srcIn)),
                      const SizedBox(width: 8),
                      Text('Kamera',
                          style: labelStyle.copyWith(
                              color: buttonTextColor,
                              fontWeight: FontWeight.bold,
                              height: 1.2)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: GestureDetector(
                onTap: () => _pickImage(ImageSource.gallery),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: toggleOptionSelectedLengkapColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/gallery-white.svg', width: 30.0, height: 30.0),
                      const SizedBox(width: 8),
                      Text('Galeri', style: labelStyle.copyWith(color: buttonTextColor, fontWeight: FontWeight.bold, height: 1.2)),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        if (isProcessingImage)
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: LinearProgressIndicator(
              borderRadius: BorderRadius.circular(8.0),
              backgroundColor: Colors.grey[300],
              valueColor: AlwaysStoppedAnimation<Color>(toggleOptionSelectedLengkapColor),
              minHeight: 5.0,
            ),
          ),
        const SizedBox(height: 16.0),
        Container(
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withAlpha((255 * 0.3).round()),
                spreadRadius: 3,
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8.0),
                        image: currentImage == null
                            ? const DecorationImage(image: AssetImage('assets/images/checker.png'), fit: BoxFit.cover)
                            : null,
                        color: currentImage != null ? Colors.grey[300] : Colors.grey[200],
                      ),
                      child: currentImage == null
                          ? const SizedBox.shrink()
                          : ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.file(File(currentImage.imagePath), fit: BoxFit.cover),
                            ),
                    ),
                  ),
                  if (currentImage != null)
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: GestureDetector(
                        onTap: _showDeleteConfirmationDialog,
                        child: SvgPicture.asset(
                          'assets/images/trashcan.svg',
                          width: 40.0,
                          height: 40.0,
                        ),
                      ),
                    ),
                ],
              ),
              if (widget.showNeedAttention) const SizedBox(height: 16.0),
              if (widget.showNeedAttention)
                FormConfirmation(
                  key: ValueKey<String>('attention_${currentImage?.id ?? "default_attention_state"}'),
                  label: 'Perlu Perhatian',
                  initialValue: currentImage?.needAttention ?? false,
                  onChanged: _onNeedAttentionChanged,
                  fontWeight: FontWeight.w300,
                ),
              AnimatedSize(
                duration: const Duration(milliseconds: 300),
                curve: Curves.fastOutSlowIn,
                child: AnimatedOpacity(
                  opacity: (_isNeedAttentionChecked || !widget.showNeedAttention) ? 1.0 : 0.0, // Adjusted condition
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn,
                  child: (_isNeedAttentionChecked || !widget.showNeedAttention) // Adjusted condition
                      ? Column(
                          children: [
                            const SizedBox(height: 16.0),
                            LabeledTextField(
                              key: ValueKey<String>('label_${currentImage?.id ?? "default_label_state"}'),
                              label: 'Label',
                              controller: _labelController,
                              hintText: 'Misal : Aki tampak atas',
                              onChanged: _onLabelChanged,
                            ),
                          ],
                        )
                      : const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 20.0),
        if (tambahanImages.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SizedBox(
                  width: 36,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: _currentIndex > 0 ? _previousImage : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      backgroundColor: buttonColor,
                      disabledBackgroundColor: Colors.grey[300],
                      elevation: 5,
                      shadowColor: buttonColor.withAlpha(102),
                    ),
                    child: const Icon(Icons.arrow_back_ios_new, size: 18, color: buttonTextColor),
                  ),
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Text(
                      '${_currentIndex + 1}/${tambahanImages.length}',
                      style: imageIndexTextStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(
                  width: 36,
                  height: 36,
                  child: ElevatedButton(
                    onPressed: _currentIndex < tambahanImages.length - 1 ? _nextImage : null,
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
                      backgroundColor: buttonColor,
                      disabledBackgroundColor: Colors.grey[300],
                      elevation: 5,
                      shadowColor: buttonColor.withAlpha(102),
                    ),
                    child: const Icon(Icons.arrow_forward_ios, size: 18, color: buttonTextColor),
                  ),
                ),
              ],
            ),
          ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
