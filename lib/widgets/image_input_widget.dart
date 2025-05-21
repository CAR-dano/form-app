import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/statics/app_styles.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/image_data_provider.dart';
import 'package:form_app/models/image_data.dart';

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
  Future<void> _takePictureFromCamera() async {
    FocusScope.of(context).unfocus();
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      widget.onImagePicked?.call(File(pickedImage.path));
      ref
          .read(imageDataListProvider.notifier)
          .updateImageDataByLabel(widget.label, imagePath: pickedImage.path);
    }
  }

  Future<void> _takePictureFromGallery() async {
    FocusScope.of(context).unfocus();
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      widget.onImagePicked?.call(File(pickedImage.path));
      ref
          .read(imageDataListProvider.notifier)
          .updateImageDataByLabel(widget.label, imagePath: pickedImage.path);
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
        return SafeArea( // Ensure content is within safe area
          child: Center( // Center the dialog content
            child: SizedBox( // Constrain the width of the dialog content
              width: MediaQuery.of(context).size.width * 0.9, // Take up 90% of screen width
              child: AlertDialog( // Use AlertDialog for styling and structure
                backgroundColor: Colors.white,
                insetPadding: EdgeInsets.zero, // Remove default inset padding
                contentPadding: EdgeInsets.zero, // Remove default content padding
                content: Padding( // Add padding around the image
                  padding: const EdgeInsets.all(16.0), // Adjust padding as needed
                  child: Stack( // Use Stack to layer image and icon
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: AspectRatio( // Enforce 4:3 aspect ratio
                          aspectRatio: 4 / 3,
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.cover, // Crop image to cover the aspect ratio
                          ),
                        ),
                      ),
                      Positioned( // Position the row of icons
                        top: 8.0, // Adjust position as needed
                        right: 8.0, // Adjust position as needed
                        child: Row( // Arrange icons horizontally
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(); // Close dialog before deleting
                                _deleteImage(); // Call delete function
                              },
                              child: SvgPicture.asset( // Use SvgPicture directly
                                'assets/images/trashcan.svg', // Trashcan icon
                                width: 26.0, // Set icon size to 26.0
                                height: 26.0, // Set icon size to 26.0
                                // Removed colorFilter to use default SVG color
                              ),
                            ),
                            const SizedBox(width: 8.0), // Add spacing between icons
                            GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop(); // Close dialog
                              },
                              child: Container( // Blue box for checkmark
                                width: 26.0, // Same size as trashcan
                                height: 26.0, // Same size as trashcan
                                decoration: BoxDecoration(
                                  color: toggleOptionSelectedLengkapColor, // Blue background
                                  borderRadius: BorderRadius.circular(8.0), // Rounded corners
                                ),
                                child: Center( // Center the checkmark icon
                                  child: SvgPicture.asset(
                                    'assets/images/check.svg', // Checkmark icon
                                    width: 16.0, // Adjust icon size within the box
                                    height: 16.0, // Adjust icon size within the box
                                    colorFilter: ColorFilter.mode(Colors.white, BlendMode.srcIn), // White icon color
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  void _deleteImage() {
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
                      onTap: _deleteImage,
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
