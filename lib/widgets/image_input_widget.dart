import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg
import 'package:form_app/statics/app_styles.dart';
import 'dart:io'; // Required for File
import 'package:image_picker/image_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import flutter_riverpod
import 'package:form_app/providers/image_data_provider.dart'; // Import image_data_provider
import 'package:form_app/models/image_data.dart'; // Import image_data model

class ImageInputWidget extends ConsumerStatefulWidget { // Change to ConsumerStatefulWidget
  final String label;
  final ValueChanged<File?>? onImagePicked; // Callback to return the picked image file

  const ImageInputWidget({
    super.key,
    required this.label,
    this.onImagePicked, // Add to constructor
  });

  @override
  ConsumerState<ImageInputWidget> createState() => _ImageInputWidgetState(); // Change to ConsumerState
}

class _ImageInputWidgetState extends ConsumerState<ImageInputWidget> { // Change to ConsumerState

  // Method to handle image picking
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery); // Use gallery for picking from files

    if (pickedImage != null) {
      widget.onImagePicked?.call(File(pickedImage.path)); // Call the callback with the image file
      // Update the image data provider
      ref.read(imageDataListProvider.notifier).updateImageDataByLabel(
        widget.label,
        imagePath: pickedImage.path,
      );
    }
  }

  // Method to view the selected image
  void _viewImage(File imageFile) {
    _showImagePreview(context, imageFile);
  }

  // Method to show image preview in a dialog
  void _showImagePreview(BuildContext context, File imageFile) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Colors.white, // Set background color to white
          content: Image.file(imageFile),
          actions: <Widget>[
            TextButton(
              child: const Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Method to delete the selected image
  void _deleteImage() {
    widget.onImagePicked?.call(null); // Call the callback with null to indicate deletion
    // Update the image data provider
    ref.read(imageDataListProvider.notifier).updateImageDataByLabel(
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
      orElse: () => ImageData(label: widget.label, imagePath: ''), // Provide a default if not found
    );

    final storedImage = imageData.imagePath.isNotEmpty ? File(imageData.imagePath) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: storedImage == null ? 4.0 : 2.0), // Conditional bottom padding
          child: Text(
            widget.label,
            style: labelStyle, // Using the style from app_styles.dart
          ),
        ),
        GestureDetector(
          onTap: storedImage == null ? _takePicture : null, // Only tap to pick if no image
          child: Container(
            width: double.infinity, // Make the container take full width
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: storedImage == null ? toggleOptionSelectedLengkapColor : Colors.transparent, // Use toggleOptionSelectedLengkapColor for button, transparent when image is shown
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: storedImage == null
                ? Center(
                    child: Text(
                      'Ambil Gambar',
                      style: toggleOptionTextStyle.copyWith(color: buttonTextColor), // Use buttonTextColor from app_styles.dart
                    ),
                  )
                : Row(
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
                          style: inputTextStyling.copyWith(fontWeight: FontWeight.w300), // Using input text style
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => _viewImage(storedImage), // Tap to view image, pass the file
                        child: Text(
                          'Lihat Gambar',
                          style: TextStyle( // Style for "Lihat Gambar"
                            color: toggleOptionSelectedLengkapColor, // Use toggleOptionSelectedLengkapColor
                            decoration: TextDecoration.underline,
                            decorationColor: toggleOptionSelectedLengkapColor, // Explicitly set underline color
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
        ),
      ],
    );
  }
}
