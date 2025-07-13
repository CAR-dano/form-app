import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/statics/app_styles.dart';
import 'dart:io';
// For kDebugMode
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/image_data_provider.dart';
import 'package:form_app/models/image_data.dart';
import 'package:form_app/widgets/delete_confirmation_dialog.dart';
import 'package:form_app/widgets/image_preview_dialog.dart';
import 'package:form_app/utils/image_capture_and_processing_util.dart';
import 'package:form_app/utils/image_form_handler.dart'; // Import the new helper
import 'package:form_app/providers/image_processing_provider.dart'; // Import for processing state
import 'package:form_app/providers/message_overlay_provider.dart'; // Import for messages
import 'package:firebase_crashlytics/firebase_crashlytics.dart'; // Import Crashlytics

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
  bool _isLoadingCamera = false;
  bool _isLoadingGallery = false;

  Future<void> _takePictureFromCamera() async {
    await ImageFormHandler.processAndHandleImageUpload(
      context: context,
      ref: ref,
      identifier: widget.label,
      pickImageFunction: () async {
        final picker = ImagePicker();
        final pickedImageXFile = await picker.pickImage(source: ImageSource.camera);
        if (pickedImageXFile != null) {
          await ImageCaptureAndProcessingUtil.saveImageToGallery(pickedImageXFile, album: 'Palapa Inspeksi');
        }
        return pickedImageXFile;
      },
      onSuccess: (processedPath) async {
        widget.onImagePicked?.call(File(processedPath));
        ref
            .read(imageDataListProvider.notifier)
            .updateImageDataByLabel(widget.label, imagePath: processedPath, rotationAngle: 0); // Initialize rotation to 0
      },
      setLoadingState: (isLoading) {
        setState(() {
          _isLoadingCamera = isLoading;
        });
      },
      errorMessage: 'Terjadi kesalahan saat memproses gambar kamera',
    );
  }

  Future<void> _takePictureFromGallery() async {
    await ImageFormHandler.processAndHandleImageUpload(
      context: context,
      ref: ref,
      identifier: widget.label,
      pickImageFunction: () => ImageCaptureAndProcessingUtil.pickImageFromGallery(),
      onSuccess: (processedPath) async {
        widget.onImagePicked?.call(File(processedPath));
        ref
            .read(imageDataListProvider.notifier)
            .updateImageDataByLabel(widget.label, imagePath: processedPath, rotationAngle: 0); // Initialize rotation to 0
      },
      setLoadingState: (isLoading) {
        setState(() {
          _isLoadingGallery = isLoading;
        });
      },
      errorMessage: 'Terjadi kesalahan saat memproses gambar galeri',
    );
  }

  Future<void> _viewImage(File imageFile) async {
    FocusScope.of(context).unfocus();
    try {
      final bool? wasDeleted = await _showImagePreview(context);

      if (wasDeleted == true) {
        _deleteImageConfirmed();
      }
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: 'Error viewing image', fatal: false);
      if (mounted) {
        ref.read(customMessageOverlayProvider).show(
          context: context,
          message: 'Error melihat gambar: $e',
          color: Colors.red,
          icon: Icons.error,
        );
      }
    }
  }

  Future<void> _rotateImage() async {
    final imageData = ref.read(imageDataListProvider).firstWhere(
      (img) => img.label == widget.label,
      orElse: () => ImageData(
        label: widget.label,
        imagePath: '',
        needAttention: false,
        category: '',
        isMandatory: true,
      ),
    );

    if (imageData.imagePath.isEmpty) {
      return; // No image to rotate
    }

    final originalRawPath = imageData.originalRawPath;
    final currentRotation = imageData.rotationAngle;
    final newRotation = (currentRotation + 90) % 360;

    // Use widget.label as the identifier for image processing state
    ref.read(imageProcessingServiceProvider.notifier).taskStarted(widget.label);

    try {
      final XFile pickedFile = XFile(originalRawPath);
      final String? newProcessedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(
        pickedFile,
        rotationAngle: newRotation,
      );

      if (newProcessedPath != null) {
        ref.read(imageDataListProvider.notifier).updateImageDataByLabel(
              widget.label,
              imagePath: newProcessedPath,
              rotationAngle: newRotation,
              originalRawPath: originalRawPath, // Ensure originalRawPath is preserved
            );
      } else {
        if (mounted) {
          ref.read(customMessageOverlayProvider).show(
            context: context,
            message: 'Gagal memutar gambar.',
            color: Colors.red,
            icon: Icons.error,
          );
        }
      }
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: 'Error rotating image', fatal: false);
      if (mounted) {
        ref.read(customMessageOverlayProvider).show(
          context: context,
          message: 'Error memutar gambar: $e',
          color: Colors.red,
          icon: Icons.error,
        );
      }
    } finally {
      // Use widget.label as the identifier for image processing state
      ref.read(imageProcessingServiceProvider.notifier).taskFinished(widget.label);
    }
  }

  Future<bool?> _showImagePreview(BuildContext context) {
    return showGeneralDialog<bool>( // Specify the return type here
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return ImagePreviewDialog(
          onRotate: _rotateImage, // Keep this if you need it
          imageIdentifier: widget.label,
        );
      },
    );
  }

  void _deleteImageConfirmed() {
    if (!mounted) return;
    widget.onImagePicked?.call(null);
    ref
        .read(imageDataListProvider.notifier)
        .updateImageDataByLabel(widget.label, imagePath: '', rotationAngle: 0); // Reset rotation on delete
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
        category: '', 
        isMandatory: true,
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
                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0), 
                        decoration: BoxDecoration(
                          color: toggleOptionSelectedLengkapColor,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: toggleOptionSelectedLengkapColor,
                            width: 1.0,
                          ),
                        ),
                        child: _isLoadingCamera
                            ? const Center(
                                child: SizedBox(
                                  height: 30.0, // Match icon size
                                  width: 30.0,  // Match icon size
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3.0,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/camera.svg',
                                    width: 30.0, 
                                    height: 30.0, 
                                    colorFilter: const ColorFilter.mode(buttonTextColor, BlendMode.srcIn),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Kamera',
                                    style: labelStyle.copyWith(
                                      color: buttonTextColor,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2, 
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
                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0), 
                        decoration: BoxDecoration(
                          color: toggleOptionSelectedLengkapColor,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: toggleOptionSelectedLengkapColor,
                            width: 1.0,
                          ),
                        ),
                        child: _isLoadingGallery
                            ? const Center(
                                child: SizedBox(
                                  height: 30.0, // Match icon size
                                  width: 30.0,  // Match icon size
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 3.0,
                                  ),
                                ),
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  SvgPicture.asset(
                                    'assets/images/gallery-white.svg',
                                    width: 30.0, 
                                    height: 30.0, 
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    'Galeri',
                                    style: labelStyle.copyWith(
                                      color: buttonTextColor,
                                      fontWeight: FontWeight.bold,
                                      height: 1.2, 
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
                      width: 22.0, 
                      height: 22.0, 
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        storedImage.path.split('/').last,
                        style: inputTextStyling.copyWith(
                          fontWeight: FontWeight.w300,
                          height: 1.2, 
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _viewImage(storedImage),
                      child: const Text(
                        'Lihat Gambar',
                        style: TextStyle(
                          color: toggleOptionSelectedLengkapColor,
                          decoration: TextDecoration.underline,
                          decorationColor: toggleOptionSelectedLengkapColor,
                          decorationThickness: 1.5,
                          height: 1.2, 
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
                                Navigator.of(context).pop(); 
                                _deleteImageConfirmed(); 
                              },
                              onCancel: () {
                                Navigator.of(context).pop(); 
                              },
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/images/trashcan.svg',
                        width: 26.0, 
                        height: 26.0, 
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
