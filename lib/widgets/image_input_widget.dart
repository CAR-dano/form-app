import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/statics/app_styles.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/image_data_provider.dart';
import 'package:form_app/models/image_data.dart';
import 'package:form_app/widgets/delete_confirmation_dialog.dart'; // Import the new widget
import 'package:form_app/widgets/image_preview_dialog.dart'; // Import the new image preview dialog
import 'package:gal/gal.dart';

class ImageInputWidget extends ConsumerStatefulWidget {
  final String label;
  final ValueChanged<File?>? onImagePicked;

  const ImageInputWidget({
    super.key,
    required this.label,
    this.onImagePicked,
  });

  @override
  ConsumerState<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends ConsumerState<ImageInputWidget> {
  Future<String?> _processAndSaveImage(XFile pickedFile) async {
    final File imageFile = File(pickedFile.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    img.Image? originalImage = img.decodeImage(Uint8List.fromList(imageBytes));

    if (originalImage == null) {
      if (kDebugMode) {
        print("Error: Could not decode image ${pickedFile.path}");
      }
      return null;
    }

    double currentAspectRatio = originalImage.width / originalImage.height;
    double targetAspectRatio = 4.0 / 3.0;
    const double tolerance = 0.01;
    bool needsCrop = false;

    int cropX = 0;
    int cropY = 0;
    int cropWidth = originalImage.width;
    int cropHeight = originalImage.height;

    if ((currentAspectRatio - targetAspectRatio).abs() > tolerance) {
        needsCrop = true;
        if (currentAspectRatio > targetAspectRatio) {
          cropWidth = (originalImage.height * targetAspectRatio).round();
          cropX = ((originalImage.width - cropWidth) / 2).round();
        } else {
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
    String extension = pickedFile.name.split('.').last.toLowerCase();
    if (extension == 'png') {
      processedBytes = img.encodePng(processedImage);
    } else if (extension == 'gif') {
        processedBytes = img.encodeGif(processedImage);
    } else {
      processedBytes = img.encodeJpg(processedImage, quality: 70);
      if (extension != 'jpg' && extension != 'jpeg') extension = 'jpg';
    }

    try {
      final directory = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
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
      return null;
    }
    return finalImagePath;
  }

  Future<void> _takePictureFromCamera() async {
    FocusScope.of(context).unfocus();
    final picker = ImagePicker();
    final pickedImageXFile = await picker.pickImage(source: ImageSource.camera);

    if (pickedImageXFile != null) {
      // --- Save to Gallery BEFORE processing ---
      try {
        // Optional: Request permission first if you haven't done it elsewhere
        bool hasAccess = await Gal.hasAccess();
        if (!hasAccess) {
          final accessGranted = await Gal.requestAccess();
          if (!accessGranted) {
            if (kDebugMode) {
              print('Gallery access denied by user.');
            }
            // Optionally show a message to the user
            // return; // Or proceed without saving to gallery
          }
        }

        if (kDebugMode) {
          print('Attempting to save original camera image to gallery: ${pickedImageXFile.path}');
        }
        await Gal.putImage(pickedImageXFile.path); // Save the original image
        if (kDebugMode) {
          print('Image successfully saved to gallery via Gal package.');
        }
        if(mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gambar disimpan ke galeri.'), duration: Duration(seconds: 2)),
          );
        }
      } catch (e) {
        if (kDebugMode) {
          print('Error saving image to gallery using Gal: $e');
          if (e is GalException) {
            print('GalException type: ${e.type}');
          }
        }
        // Optionally, inform the user that gallery save failed
      }
      // --- End Save to Gallery ---

      final String? processedPath = await _processAndSaveImage(pickedImageXFile);
      if (processedPath != null) {
        widget.onImagePicked?.call(File(processedPath)); // Call with the new File object
        ref
            .read(imageDataListProvider.notifier)
            .updateImageDataByLabel(widget.label, imagePath: processedPath);
      }
    }
  }

  Future<void> _takePictureFromGallery() async {
    FocusScope.of(context).unfocus();
    final picker = ImagePicker();
    final pickedImageXFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImageXFile != null) {
       final String? processedPath = await _processAndSaveImage(pickedImageXFile);
      if (processedPath != null) {
        widget.onImagePicked?.call(File(processedPath)); // Call with the new File object
        ref
            .read(imageDataListProvider.notifier)
            .updateImageDataByLabel(widget.label, imagePath: processedPath);
      }
    }
  }

  void _viewImage(File imageFile) {
    FocusScope.of(context).unfocus();
    _showImagePreview(context, imageFile);
  }

  void _showImagePreview(BuildContext context, File imageFile) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return ImagePreviewDialog(
          imageFile: imageFile,
          onDeleteConfirmed: _deleteImageConfirmed,
        );
      },
    );
  }

  void _deleteImageConfirmed() {
    widget.onImagePicked?.call(null);
    ref
        .read(imageDataListProvider.notifier)
        .updateImageDataByLabel(widget.label, imagePath: '');
  }

  @override
  Widget build(BuildContext context) {
    final imageDataList = ref.watch(imageDataListProvider);
    final imageData = imageDataList.firstWhere(
      (img) => img.label == widget.label,
      orElse: () => ImageData(
        label: widget.label,
        imagePath: '',
        needAttention: false,
        category: '', // Default value
        isMandatory: true, // Default value
      ),
    );

    final storedImage =
        imageData.imagePath.isNotEmpty ? File(imageData.imagePath) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: storedImage == null ? 4.0 : 2.0,
          ),
          child: Text(
            widget.label,
            style: labelStyle,
          ),
        ),
        storedImage == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _takePictureFromCamera,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0), // Inlined padding
                        decoration: BoxDecoration(
                          color: toggleOptionSelectedLengkapColor,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: toggleOptionSelectedLengkapColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/camera.svg',
                              width: 30.0, // Inlined icon size
                              height: 30.0, // Inlined icon size
                              colorFilter: ColorFilter.mode(buttonTextColor, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Kamera',
                              style: labelStyle.copyWith(
                                color: buttonTextColor,
                                fontWeight: FontWeight.bold,
                                height: 1.2, // Inlined text line height
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: _takePictureFromGallery,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0), // Inlined padding
                        decoration: BoxDecoration(
                          color: toggleOptionSelectedLengkapColor,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: toggleOptionSelectedLengkapColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/gallery-white.svg',
                              width: 30.0, // Inlined icon size
                              height: 30.0, // Inlined icon size
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Galeri',
                              style: labelStyle.copyWith(
                                color: buttonTextColor,
                                fontWeight: FontWeight.bold,
                                height: 1.2, // Inlined text line height
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/galeri.svg',
                      width: 22.0, // Inlined icon size
                      height: 22.0, // Inlined icon size
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        storedImage.path.split('/').last,
                        style: inputTextStyling.copyWith(
                          fontWeight: FontWeight.w300,
                          height: 1.2, // Inlined text line height
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _viewImage(storedImage),
                      child: Text(
                        'Lihat Gambar',
                        style: TextStyle(
                          color: toggleOptionSelectedLengkapColor,
                          decoration: TextDecoration.underline,
                          decorationColor: toggleOptionSelectedLengkapColor,
                          decorationThickness: 1.5,
                          height: 1.2, // Inlined text line height
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteConfirmationDialog(
                              message: 'Apakah anda yakin ingin menghapus gambar tersebut?',
                              onConfirm: () {
                                Navigator.of(context).pop(); // Close the confirmation dialog
                                _deleteImageConfirmed(); // Perform deletion
                              },
                              onCancel: () {
                                Navigator.of(context).pop(); // Close the confirmation dialog
                              },
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/images/trashcan.svg',
                        width: 26.0, // Inlined icon size (or 20.0 if you prefer trashcan slightly larger)
                        height: 26.0, // Inlined icon size
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
