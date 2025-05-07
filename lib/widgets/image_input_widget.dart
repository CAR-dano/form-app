import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import flutter_svg
import 'package:form_app/statics/app_styles.dart';
import 'dart:io'; // Required for File
import 'package:image_picker/image_picker.dart';

class ImageInputWidget extends StatefulWidget {
  final String label;
  final ValueChanged<File?>? onImagePicked; // Callback to return the picked image file

  const ImageInputWidget({
    super.key,
    required this.label,
    this.onImagePicked, // Add to constructor
  });

  @override
  State<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends State<ImageInputWidget> {
  File? _storedImage; // To store the selected image file

  // Method to handle image picking
  Future<void> _takePicture() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: ImageSource.gallery); // Use gallery for picking from files

    if (pickedImage != null) {
      setState(() {
        _storedImage = File(pickedImage.path);
      });
      widget.onImagePicked?.call(_storedImage); // Call the callback with the image file
    }
  }

  // Method to view the selected image
  void _viewImage() {
    if (_storedImage != null) {
      _showImagePreview(context, _storedImage!);
    }
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
    setState(() {
      _storedImage = null;
    });
    widget.onImagePicked?.call(null); // Call the callback with null to indicate deletion
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(bottom: _storedImage == null ? 8.0 : 4.0), // Conditional bottom padding
          child: Text(
            widget.label,
            style: labelStyle, // Using the style from app_styles.dart
          ),
        ),
        GestureDetector(
          onTap: _storedImage == null ? _takePicture : null, // Only tap to pick if no image
          child: Container(
            width: double.infinity, // Make the container take full width
            padding: const EdgeInsets.symmetric(vertical: 12.0),
            decoration: BoxDecoration(
              color: _storedImage == null ? toggleOptionSelectedLengkapColor : Colors.transparent, // Use toggleOptionSelectedLengkapColor for button, transparent when image is shown
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: _storedImage == null
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
                        colorFilter: ColorFilter.mode(toggleOptionSelectedLengkapColor, BlendMode.srcIn), // Use toggleOptionSelectedLengkapColor
                      ),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          _storedImage!.path.split('/').last, // Display file name
                          style: inputTextStyling.copyWith(fontWeight: FontWeight.w300), // Using input text style
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: _viewImage, // Tap to view image
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
