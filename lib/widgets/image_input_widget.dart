import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg
import 'package:form_app/statics/app_styles.dart';
import 'dart:io'; // Required for File
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import flutter_riverpod
import 'package:form_app/providers/image_data_provider.dart'; // Import image_data_provider
import 'package:form_app/models/image_data.dart'; // Import image_data model

class ImageInputWidget extends ConsumerStatefulWidget {
  final String label;
  final ValueChanged<File?>? onImagePicked;

  const ImageInputWidget({
    super.key,
    required this.label,
    this.onImagePicked, // Add to constructor
  });

  @override
  ConsumerState<ImageInputWidget> createState() => _ImageInputWidgetState(); // Change to ConsumerState
}

class _ImageInputWidgetState extends ConsumerState<ImageInputWidget> {

  // Method to handle image picking from camera
  Future<void> _takePictureFromCamera() async {
    // Clear focus before showing the image picker
    FocusScope.of(context).unfocus();

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.camera);

    if (pickedImage != null) {
      widget.onImagePicked?.call(
        File(pickedImage.path),
      ); // Call the callback with the image file
      // Update the image data provider
      ref
          .read(imageDataListProvider.notifier)
          .updateImageDataByLabel(widget.label, imagePath: pickedImage.path);
    }
  }

  // Method to handle image picking from gallery
  Future<void> _takePictureFromGallery() async {
    // Clear focus before showing the image picker
    FocusScope.of(context).unfocus();

    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      widget.onImagePicked?.call(
        File(pickedImage.path),
      ); // Call the callback with the image file
      // Update the image data provider
      ref
          .read(imageDataListProvider.notifier)
          .updateImageDataByLabel(widget.label, imagePath: pickedImage.path);
    }
  }

  // Method to view the selected image
  void _viewImage(File imageFile) {
    FocusScope.of(context).unfocus(); // Unfocus before showing the dialog
    _showImagePreview(context, imageFile);
  }

  // Method to show image preview in a dialog
  void _showImagePreview(BuildContext context, File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          content: ClipRRect( // Added ClipRRect to apply border radius
            borderRadius: BorderRadius.circular(8.0), // Added border radius
            child: Image.file(imageFile),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
                FocusScope.of(context).unfocus(); // Unfocus after closing the dialog
              },
            ),
          ],
        );
      },
    );
  }

  // Method to delete the selected image
  void _deleteImage() {
    widget.onImagePicked?.call(
      null,
    ); // Call the callback with null to indicate deletion
    // Update the image data provider
    ref
        .read(imageDataListProvider.notifier)
        .updateImageDataByLabel(
          widget.label,
          imagePath: '', // Set imagePath to empty string when deleted
        );
  }

  @override
  Widget build(BuildContext context) {
    // Watch the image data provider
    final imageDataList = ref.watch(imageDataListProvider);
    final imageData = imageDataList.firstWhere(
      (img) => img.label == widget.label,
      orElse:
          () => ImageData(
            label: widget.label,
            imagePath: '',
          ), // Provide a default if not found
    );

    final storedImage =
        imageData.imagePath.isNotEmpty ? File(imageData.imagePath) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: storedImage == null ? 4.0 : 2.0,
          ), // Conditional bottom padding
          child: Text(
            widget.label,
            style: labelStyle, // Using the style from app_styles.dart
          ),
        ),
        storedImage == null
            ? Row(
              // Removed parent Container decoration
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: _takePictureFromCamera, // Swapped onTap
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color:
                            toggleOptionSelectedTidakColor, // Pink background
                        borderRadius: BorderRadius.only(
                          topLeft: const Radius.circular(
                            8.0,
                          ), // Apply full radius to corners
                          bottomLeft: const Radius.circular(8.0),
                        ),
                        border: Border.all(
                          // Apply border to this container
                          color: toggleOptionSelectedTidakColor, // Pink border
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Dari Kamera', // Swapped text
                          style: toggleOptionTextStyle.copyWith(
                            color: buttonTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: GestureDetector(
                    onTap: _takePictureFromGallery, // Swapped onTap
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 12.0),
                      decoration: BoxDecoration(
                        color:
                            toggleOptionSelectedLengkapColor, // Light blue background
                        borderRadius: BorderRadius.only(
                          topRight: const Radius.circular(
                            8.0,
                          ), // Apply full radius to corners
                          bottomRight: const Radius.circular(8.0),
                        ),
                        border: Border.all(
                          // Apply border to this container
                          color:
                              toggleOptionSelectedLengkapColor, // Light blue border
                          width: 2.0,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          'Dari Galeri', // Swapped text
                          style: toggleOptionTextStyle.copyWith(
                            color: buttonTextColor,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )
            : Container(
              width: double.infinity, // Make the container take full width
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              decoration: BoxDecoration(
                color: Colors.transparent, // transparent when image is shown
                borderRadius: BorderRadius.circular(8.0), // Added border radius
              ),
              child: Row(
                children: [
                  SvgPicture.asset(
                    'assets/images/galeri.svg', // Gallery icon
                    width: 22,
                    height: 22,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      storedImage.path.split('/').last, // Display file name
                      style: inputTextStyling.copyWith(
                        fontWeight: FontWeight.w300,
                      ), // Using input text style
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap:
                        () => _viewImage(
                          storedImage,
                        ), // Tap to view image, pass the file
                    child: Text(
                      'Lihat Gambar',
                      style: TextStyle(
                        // Style for "Lihat Gambar"
                        color:
                            toggleOptionSelectedLengkapColor, // Use toggleOptionSelectedLengkapColor
                        decoration: TextDecoration.underline,
                        decorationColor:
                            toggleOptionSelectedLengkapColor, // Explicitly set underline color
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _deleteImage, // Tap to delete image
                    child: SvgPicture.asset(
                      'assets/images/trashcan.svg', // Trashcan icon
                      width: 26,
                      height: 26,
                      // Removed colorFilter to use default SVG color
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
