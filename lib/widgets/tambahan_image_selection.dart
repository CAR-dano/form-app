import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart'; // For getTemporaryDirectory
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/form_confirmation.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/widgets/delete_confirmation_dialog.dart'; // Import the new widget

class TambahanImageSelection extends ConsumerStatefulWidget {
  final String identifier; // Add identifier parameter

  final bool showNeedAttention;
  final bool isMandatory; // New parameter

  const TambahanImageSelection({
    super.key,
    required this.identifier,
    this.showNeedAttention = true, // Default to true
    this.isMandatory = false, // Default to false
  });

  @override
  ConsumerState<TambahanImageSelection> createState() => _TambahanImageSelectionState();
}

class _TambahanImageSelectionState extends ConsumerState<TambahanImageSelection> {
  final ImagePicker _picker = ImagePicker();
  int _currentIndex = 0;
  final TextEditingController _labelController = TextEditingController();

  Future<String?> _processAndSaveImage(XFile pickedFile) async {
    final File imageFile = File(pickedFile.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    img.Image? originalImage = img.decodeImage(Uint8List.fromList(imageBytes));

    if (originalImage == null) {
      if (kDebugMode) {
        print("Error: Could not decode image ${pickedFile.path}");
      }
      return null; // Indicate failure
    }

    double currentAspectRatio = originalImage.width / originalImage.height;
    double targetAspectRatio = 4.0 / 3.0;
    const double tolerance = 0.01; // Allow for small floating point inaccuracies

    int cropX = 0;
    int cropY = 0;
    int cropWidth = originalImage.width;
    int cropHeight = originalImage.height;
    bool needsCrop = false;

    if ((currentAspectRatio - targetAspectRatio).abs() > tolerance) {
        needsCrop = true;
        if (currentAspectRatio > targetAspectRatio) {
          // Image is wider than 4:3, crop width
          cropWidth = (originalImage.height * targetAspectRatio).round();
          cropX = ((originalImage.width - cropWidth) / 2).round();
        } else {
          // Image is taller than 4:3, crop height
          cropHeight = (originalImage.width / targetAspectRatio).round();
          cropY = ((originalImage.height - cropHeight) / 2).round();
        }
    }

    img.Image? processedImage = originalImage;
    if (needsCrop) {
      processedImage = img.copyCrop(originalImage, x: cropX, y: cropY, width: cropWidth, height: cropHeight);
    }

    // Resize if the image is too large
    const int maxWidth = 1200; // Target maximum width
    if (processedImage.width > maxWidth) {
      processedImage = img.copyResize(processedImage, width: maxWidth);
    }

    String finalImagePath = pickedFile.path;
    List<int> processedBytes;
    // Preserve original extension or default to jpg
    String extension = pickedFile.name.split('.').last.toLowerCase();
    if (extension == 'png') {
      processedBytes = img.encodePng(processedImage);
    } else if (extension == 'gif') {
      processedBytes = img.encodeGif(processedImage); // If you need to support GIF
    }
    else { // default to jpg for jpeg, jpg, or unknown
      processedBytes = img.encodeJpg(processedImage, quality: 70); // Adjust quality
      if (extension != 'jpg' && extension != 'jpeg') extension = 'jpg';
    }

    try {
      final directory = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      // Ensure unique filename if multiple images are processed quickly
      final String newFileName = '${timestamp}_${pickedFile.name.replaceAll(RegExp(r'\s+'), '_')}_processed.$extension';
      finalImagePath = '${directory.path}/$newFileName';
      final File newProcessedFile = File(finalImagePath);
      await newProcessedFile.writeAsBytes(processedBytes);
      if (kDebugMode) {
        print('Processed image saved to: $finalImagePath');
        final int fileSize = await newProcessedFile.length();
        print('Compressed file size: ${fileSize / 1024} KB');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saving processed image: $e");
      }
      return null; // Indicate failure
    }
    return finalImagePath;
  }

  @override
  void initState() {
    super.initState();
    // Initial update based on potentially loaded data for this specific identifier
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateControllersForCurrentIndex();
    });
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  void _updateControllersForCurrentIndex() {
    // Use widget.identifier to get the correct provider instance
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
      if (_labelController.text != currentImage.label) {
        _labelController.text = currentImage.label;
         // Ensure cursor is at the end after programmatic text change
        _labelController.selection = TextSelection.fromPosition(TextPosition(offset: _labelController.text.length));
      }
    } else {
      _labelController.clear();
    }
  }

  Future<void> _pickImage(ImageSource source) async {
    if (source == ImageSource.gallery) {
      final List<XFile> images = await _picker.pickMultiImage();
      if (images.isNotEmpty) {
        List<TambahanImageData> newImagesData = [];
        for (var imageFileXFile in images) {
          final String? processedPath = await _processAndSaveImage(imageFileXFile);
          if (processedPath != null) {
            final newTambahanImage = TambahanImageData(
              imagePath: processedPath, // Use processed path
              label: '', // Default label, user can edit
              needAttention: false,
              category: widget.identifier,
              isMandatory: widget.isMandatory,
            );
            newImagesData.add(newTambahanImage);
            // Use widget.identifier for the provider
            ref.read(tambahanImageDataProvider(widget.identifier).notifier).addImage(newTambahanImage);
          }
        }
        if (newImagesData.isNotEmpty) {
          setState(() {
            _currentIndex = ref.read(tambahanImageDataProvider(widget.identifier)).length - newImagesData.length;
            if (_currentIndex < 0) _currentIndex = 0;
            _updateControllersForCurrentIndex();
          });
        }
      }
    } else { // Camera
      final XFile? imageXFile = await _picker.pickImage(source: source);
      if (imageXFile != null) {
        final String? processedPath = await _processAndSaveImage(imageXFile);
        if (processedPath != null) {
          final newTambahanImage = TambahanImageData(
            imagePath: processedPath, // Use processed path
            label: '', 
            needAttention: false,
            category: widget.identifier,
            isMandatory: widget.isMandatory,
          );
          ref.read(tambahanImageDataProvider(widget.identifier).notifier).addImage(newTambahanImage);
          setState(() {
            _currentIndex = ref.read(tambahanImageDataProvider(widget.identifier)).length - 1;
            _updateControllersForCurrentIndex();
          });
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
    // Use widget.identifier for the provider
    final images = ref.read(tambahanImageDataProvider(widget.identifier));
    if (images.isNotEmpty && _currentIndex < images.length) {
      final currentImage = images[_currentIndex];
      // Use widget.identifier for the provider
      ref
          .read(tambahanImageDataProvider(widget.identifier).notifier)
          .updateImageAtIndex(_currentIndex, currentImage.copyWith(label: newLabel));
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
        // Synchronize label controller if currentImage changes
        final currentImageForController = currentImagesList.isNotEmpty && _currentIndex < currentImagesList.length
            ? currentImagesList[_currentIndex]
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
