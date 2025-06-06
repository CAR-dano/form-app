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
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 0;
  final TextEditingController _labelController = TextEditingController();
  final GlobalKey<FormFieldState<String>> _labelFieldKey = GlobalKey<FormFieldState<String>>();

  VoidCallback? _formSubmittedListener;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateControllersForCurrentIndex();
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
      // If the current image's label is the default, display an empty string in the text field.
      // Otherwise, display the actual label.
      final String displayedLabel = (currentImage.label == widget.defaultLabel) ? '' : currentImage.label;
      if (_labelController.text != displayedLabel) {
        _labelController.text = displayedLabel;
        _labelController.selection = TextSelection.fromPosition(TextPosition(offset: _labelController.text.length));
      }

      // Pre-cache next and previous images
      if (mounted) {
        // Pre-cache next image
        if (_currentIndex + 1 < images.length) {
          precacheImage(FileImage(File(images[_currentIndex + 1].imagePath)), context);
        }
        // Pre-cache previous image
        if (_currentIndex - 1 >= 0) {
          precacheImage(FileImage(File(images[_currentIndex - 1].imagePath)), context);
        }
      }
    } else {
      _labelController.clear(); // Clear if no images
    }
    if (widget.formSubmitted?.value ?? false) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) _labelFieldKey.currentState?.validate();
        });
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.gallery) {
      final List<XFile> imagesXFiles = await ImagePickerUtil.pickMultiImagesFromGallery();
      if (imagesXFiles.isNotEmpty && mounted) {
        List<TambahanImageData> newImagesData = [];
        for (var imageFileXFile in imagesXFiles) {
          ref.read(imageProcessingServiceProvider.notifier).taskStarted(); // Increment
          String? processedPath;
          try {
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
              // Pre-cache the newly added image
              if (mounted) {
                precacheImage(FileImage(File(processedPath)), context);
              }
            } else if (mounted && processedPath == null) {
              if (kDebugMode) print("Image processing failed for gallery image: ${imageFileXFile.name}");
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal memproses gambar: ${imageFileXFile.name}'))
              );
            }
          } catch (e) {
             if (mounted && kDebugMode) {
                if (kDebugMode) {
                  print("Error during multi-gallery image processing: $e");
                }
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Terjadi kesalahan memproses gambar: $e'))
                );
             }
          } finally {
            if (mounted) {
              ref.read(imageProcessingServiceProvider.notifier).taskFinished(); // Decrement
            }
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
    } else { // Camera
      final XFile? imageXFile = await _picker.pickImage(source: source);
      if (imageXFile != null && mounted) {
        ref.read(imageProcessingServiceProvider.notifier).taskStarted(); // Increment
        try {
          await ImagePickerUtil.saveImageToGallery(imageXFile);
          final String? processedPath = await ImagePickerUtil.processAndSaveImage(imageXFile);
          if (mounted && processedPath != null) {
            final newTambahanImage = TambahanImageData(
              imagePath: processedPath,
              label: widget.defaultLabel,
              needAttention: false,
              category: widget.identifier,
              isMandatory: widget.isMandatory,
            );
            ref.read(tambahanImageDataProvider(widget.identifier).notifier).addImage(newTambahanImage);
            // Pre-cache the newly added image
            if (mounted) {
              precacheImage(FileImage(File(processedPath)), context);
            }
            setState(() {
              _currentIndex = ref.read(tambahanImageDataProvider(widget.identifier)).length - 1;
              _updateControllersForCurrentIndex();
            });
          } else if (mounted && processedPath == null) {
            if (kDebugMode) print("Image processing failed for camera image.");
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gagal memproses gambar dari kamera.'))
            );
          }
        } catch (e) {
          if (mounted && kDebugMode) {
            if (kDebugMode) {
              print("Error during camera image processing in Tambahan: $e");
            }
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Terjadi kesalahan memproses gambar kamera: $e'))
            );
          }
        } finally {
          if (mounted) {
            ref.read(imageProcessingServiceProvider.notifier).taskFinished(); // Decrement
          }
        }
      }
    }
  }

  void _nextImage() {
    // Use widget.identifier for the provider
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
    // Use widget.identifier for the provider
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (images.isNotEmpty && _currentIndex < images.length) {
      // Use widget.identifier for the provider
      ref.read(tambahanImageDataProvider(widget.identifier).notifier).removeImageAtIndex(_currentIndex);
      setState(() {
        // Adjust current index after deletion
        final newLength = images.length - 1; // new length after potential removal
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
            Navigator.of(context).pop(); // Close the dialog
            _deleteCurrentImageConfirmed(); // Perform deletion
          },
          onCancel: () {
            Navigator.of(context).pop(); // Close the dialog
          },
        );
      },
    );
  }

  void _onLabelChanged(String newLabel) {
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
      // If the new label is empty, save the defaultLabel. Otherwise, save the newLabel.
      final String labelToSave = newLabel.trim().isEmpty ? widget.defaultLabel : newLabel;
      ref
          .read(tambahanImageDataProvider(widget.identifier).notifier)
          .updateImageAtIndex(_currentIndex, currentImage.copyWith(label: labelToSave));
    }
  }

  void _onNeedAttentionChanged(bool newAttentionStatus) {
     // Use widget.identifier for the provider
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
       // Use widget.identifier for the provider
      ref.read(tambahanImageDataProvider(widget.identifier).notifier).updateImageAtIndex(
          _currentIndex, currentImage.copyWith(needAttention: newAttentionStatus));
    }
  }

  String _getDisplayLabel(String? label) {
    return (label == widget.defaultLabel) ? '' : (label ?? '');
  }

  @override
  Widget build(BuildContext context) {
     // Use widget.identifier to watch the correct provider instance
    final tambahanImages = ref.watch(tambahanImageDataProvider(widget.identifier));
    final TambahanImageData? currentImage =
        tambahanImages.isNotEmpty && _currentIndex < tambahanImages.length
            ? tambahanImages[_currentIndex]
            : null;
    
    // This logic helps keep _currentIndex valid if images are deleted externally or list becomes empty
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
        // Synchronize label controller if currentImage changes, respecting the "empty if default" rule
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
                onTap: () => _pickImage(ImageSource.camera),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                  decoration: BoxDecoration(
                    color: toggleOptionSelectedLengkapColor,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SvgPicture.asset('assets/images/camera.svg', width: 30.0, height: 30.0, colorFilter: const ColorFilter.mode(buttonTextColor, BlendMode.srcIn)),
                      const SizedBox(width: 8),
                      Text('Kamera', style: labelStyle.copyWith(color: buttonTextColor, fontWeight: FontWeight.bold, height: 1.2)),
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
              const SizedBox(height: 16.0),
              LabeledTextField(
                // Use a dynamic key to force rebuild when currentImage changes
                key: ValueKey<String>('label_${currentImage?.id ?? "default_label_state"}'),
                label: 'Label',
                controller: _labelController, // Controller is managed now
                hintText: 'Misal : Aki tampak atas',
                onChanged: _onLabelChanged,
                // initialValue: currentImage?.label ?? '', // Controller handles initial value
              ),
              const SizedBox(height: 16.0),
              if (widget.showNeedAttention) // Conditionally render
                FormConfirmation(
                  // Use a dynamic key
                  key: ValueKey<String>('attention_${currentImage?.id ?? "default_attention_state"}'),
                  label: 'Perlu Perhatian',
                  initialValue: currentImage?.needAttention ?? false,
                  onChanged: _onNeedAttentionChanged,
                  fontWeight: FontWeight.w300,
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
                      elevation: 5, // Add elevation
                      shadowColor: buttonColor.withAlpha(102), // Add shadow color
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
                      elevation: 5, // Add elevation
                      shadowColor: buttonColor.withAlpha(102), // Add shadow color
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
