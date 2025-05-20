import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:form_app/statics/app_styles.dart'; // Assuming app_styles contains necessary styles
import 'package:form_app/widgets/labeled_text_field.dart'; // Assuming LabeledTextField exists
import 'package:form_app/widgets/form_confirmation.dart';

class TambahanImageSelection extends StatefulWidget {
  const TambahanImageSelection({super.key});

  @override
  State<TambahanImageSelection> createState() => _TambahanImageSelectionState();
}

class _TambahanImageSelectionState extends State<TambahanImageSelection> {
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];
  final TextEditingController _labelController = TextEditingController();
  bool _perluPerhatian = false;
  int _currentImageIndex = 0;

  Future<void> _pickImages() async {
    final List<XFile> images = await _picker.pickMultiImage();
    if (images.isNotEmpty) {
      setState(() {
        _selectedImages = images;
        _currentImageIndex = 0;
      });
    }
  }

  void _nextImage() {
    if (_currentImageIndex < _selectedImages.length - 1) {
      setState(() {
        _currentImageIndex++;
      });
    }
  }

  void _previousImage() {
    if (_currentImageIndex > 0) {
      setState(() {
        _currentImageIndex--;
      });
    }
  }

  @override
  void dispose() {
    _labelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  width: double.infinity,
                  height: 200,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.0),
                    image: _selectedImages.isEmpty
                        ? const DecorationImage(
                            image: AssetImage('assets/images/checker.png'), // Ensure this asset exists
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: _selectedImages.isNotEmpty ? Colors.grey[300] : Colors.grey[200],
                  ),
                  child: _selectedImages.isEmpty
                      ? Center(
                          child: ElevatedButton(
                            onPressed: _pickImages,
                            style: baseButtonStyle.copyWith( // Assuming baseButtonStyle is from your app_styles
                              backgroundColor: WidgetStateProperty.all(toggleOptionSelectedLengkapColor), // Assuming toggleOptionSelectedLengkapColor is from your app_styles
                            ),
                            child: Text(
                              'Upload Foto',
                              style: buttonTextStyle, // Assuming buttonTextStyle is from your app_styles
                            ),
                          ),
                        )
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(8.0),
                          child: Image.file(
                            File(_selectedImages[_currentImageIndex].path),
                            fit: BoxFit.cover,
                          ),
                        ),
                ),
              ),
              const SizedBox(height: 16.0),
              LabeledTextField(
                label: 'Label',
                controller: _labelController,
                hintText: 'Misal : Aki tampak atas',
              ),
              const SizedBox(height: 16.0),
              FormConfirmation(
                label: 'Perlu Perhatian',
                initialValue: _perluPerhatian,
                onChanged: (newValue) {
                  setState(() {
                    _perluPerhatian = newValue;
                  });
                },
                fontWeight: FontWeight.w300,
              ),
            ],
          ),
        ),
        const SizedBox(height: 40.0),
        if (_selectedImages.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                width: 36,
                height: 36,
                child: ElevatedButton(
                  onPressed: _previousImage,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: buttonColor, // Assuming buttonColor is from your app_styles
                    shadowColor: buttonColor.withAlpha(102), // Assuming buttonColor is from your app_styles
                    elevation: 5, // Added elevation for shadow to appear
                    alignment: Alignment.center,
                  ),
                  // Using Icons.arrow_back_ios_new for better centering
                  child: const Icon(Icons.arrow_back_ios_new, size: 18, color: buttonTextColor), // Assuming buttonTextColor is from your app_styles
                ),
              ),
              const SizedBox(width: 70.0),
              SizedBox(
                width: 60.0,
                child: Text(
                  '${_currentImageIndex + 1}/${_selectedImages.length}',
                  style: imageIndexTextStyle, // Assuming imageIndexTextStyle is from your app_styles
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(width: 70.0),
              SizedBox(
                width: 36,
                height: 36,
                child: ElevatedButton(
                  onPressed: _nextImage,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    backgroundColor: buttonColor, // Assuming buttonColor is from your app_styles
                    shadowColor: buttonColor.withAlpha(102), // Assuming buttonColor is from your app_styles
                    elevation: 5, // Added elevation for shadow to appear
                    alignment: Alignment.center,
                  ),
                  // Using Icons.arrow_forward_ios_new for better centering
                  child: const Icon(Icons.arrow_forward_ios, size: 18, color: buttonTextColor), // Assuming buttonTextColor is from your app_styles
                ),
              ),
            ],
          ),
        const SizedBox(height: 24.0),
        // NavigationButtonRow (if you have one)
      ],
    );
  }
}