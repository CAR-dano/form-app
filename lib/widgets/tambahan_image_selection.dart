import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/form_confirmation.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';

class TambahanImageSelection extends ConsumerStatefulWidget {
  const TambahanImageSelection({super.key});

  @override
  ConsumerState<TambahanImageSelection> createState() => _TambahanImageSelectionState();
}

class _TambahanImageSelectionState extends ConsumerState<TambahanImageSelection> {
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 0;
  final TextEditingController _labelController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _updateControllersForCurrentIndex();
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _updateControllersForCurrentIndex() {
    final images = ref.read(tambahanImageDataProvider);
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
      if (_labelController.text != currentImage.label) {
        _labelController.text = currentImage.label;
      }
    } else {
      _labelController.clear();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.gallery) {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        for (var imageFile in images) {
          final newTambahanImage = TambahanImageData(
            imagePath: imageFile.path,
            label: '',
            needAttention: false,
          );
          ref.read(tambahanImageDataProvider.notifier).addImage(newTambahanImage);
        }
        setState(() {
          _currentIndex = ref.read(tambahanImageDataProvider).length - images.length;
          if (_currentIndex < 0) _currentIndex = 0;
           _updateControllersForCurrentIndex();
        });
      }
    } else {
      final XFile? image = await _picker.pickImage(source: source);
      if (image != null) {
        final newTambahanImage = TambahanImageData(
          imagePath: image.path,
          label: '',
          needAttention: false,
        );
        ref.read(tambahanImageDataProvider.notifier).addImage(newTambahanImage);
        setState(() {
          _currentIndex = ref.read(tambahanImageDataProvider).length - 1;
          _updateControllersForCurrentIndex();
        });
      }
    }
  }

  void _nextImage() {
    final images = ref.read(tambahanImageDataProvider);
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

  void _deleteCurrentImage() {
    final images = ref.read(tambahanImageDataProvider);
    if (images.isNotEmpty && _currentIndex < images.length) {
      ref.read(tambahanImageDataProvider.notifier).removeImageAtIndex(_currentIndex);
      setState(() {
        if (_currentIndex >= images.length - 1) {
          _currentIndex = (images.length - 2).clamp(0, (images.length - 2));
           if (images.length -1 == 0) _currentIndex = 0;
        }
        _updateControllersForCurrentIndex();
      });
    }
  }

  void _onLabelChanged(String newLabel) {
    final images = ref.read(tambahanImageDataProvider);
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
      ref
          .read(tambahanImageDataProvider.notifier)
          .updateImageAtIndex(_currentIndex, currentImage.copyWith(label: newLabel));
    }
  }

  void _onNeedAttentionChanged(bool newAttentionStatus) {
    final images = ref.read(tambahanImageDataProvider);
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
      ref.read(tambahanImageDataProvider.notifier).updateImageAtIndex(
          _currentIndex, currentImage.copyWith(needAttention: newAttentionStatus));
    }
  }

  @override
  Widget build(BuildContext context) {
    final tambahanImages = ref.watch(tambahanImageDataProvider);
    final TambahanImageData? currentImage =
        tambahanImages.isNotEmpty && _currentIndex < tambahanImages.length
            ? tambahanImages[_currentIndex]
            : null;
    
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        if (tambahanImages.isNotEmpty && _currentIndex >= tambahanImages.length) {
          setState(() {
            _currentIndex = (tambahanImages.length - 1).clamp(0, tambahanImages.length -1);
            _updateControllersForCurrentIndex();
          });
        } else if (tambahanImages.isEmpty && _currentIndex != 0) {
           setState(() {
            _currentIndex = 0;
            _updateControllersForCurrentIndex();
          });
        }
        final currentImageForController = tambahanImages.isNotEmpty && _currentIndex < tambahanImages.length
            ? tambahanImages[_currentIndex]
            : null;
        if (currentImageForController != null && _labelController.text != currentImageForController.label) {
           _labelController.text = currentImageForController.label;
           _labelController.selection = TextSelection.fromPosition(TextPosition(offset: _labelController.text.length));
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
                  Container(
                    width: double.infinity,
                    height: 200,
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
                  if (currentImage != null)
                    Positioned(
                      top: 8.0,
                      right: 8.0,
                      child: GestureDetector( // Simplified delete button
                        onTap: _deleteCurrentImage,
                        child: SvgPicture.asset(
                          'assets/images/trashcan.svg',
                          width: 26.0, // As per your example
                          height: 26.0, // As per your example
                          // No colorFilter to use default SVG color, or add one if needed
                        ),
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 16.0),
              LabeledTextField(
                key: ValueKey<String>('label_${currentImage?.id ?? "default_label_state"}'),
                label: 'Label',
                controller: _labelController,
                hintText: 'Misal : Aki tampak atas',
                onChanged: _onLabelChanged,
                initialValue: currentImage?.label ?? '',
              ),
              const SizedBox(height: 16.0),
              FormConfirmation(
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