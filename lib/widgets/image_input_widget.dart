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
          await ImageCaptureAndProcessingUtil.saveImageToGallery(pickedImageXFile);
        }
        return pickedImageXFile;
      },
      onSuccess: (processedPath) async {
        widget.onImagePicked?.call(File(processedPath));
        ref
            .read(imageDataListProvider.notifier)
            .updateImageDataByLabel(widget.label, imagePath: processedPath);
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
            .updateImageDataByLabel(widget.label, imagePath: processedPath);
      },
      setLoadingState: (isLoading) {
        setState(() {
          _isLoadingGallery = isLoading;
        });
      },
      errorMessage: 'Terjadi kesalahan saat memproses gambar galeri',
    );
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
    if (!mounted) return;
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
                                    colorFilter: ColorFilter.mode(buttonTextColor, BlendMode.srcIn),
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
                      child: Text(
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
