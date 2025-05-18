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
        _currentImageIndex = 0; // Reset index when new images are picked
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
                color: Colors.grey.withAlpha((255 * 0.3).round()), // Reduced opacity
                spreadRadius: 3, // Increased spread
                blurRadius: 8, // Increased blur
                offset: const Offset(0, 4), // Slightly adjusted offset
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image display section
              GestureDetector(
                onTap: _pickImages,
                child: Container(
                  width: double.infinity,
                  height: 200, // Adjust height as needed
                  decoration: BoxDecoration(
                    image: _selectedImages.isEmpty
                        ? const DecorationImage(
                            image: AssetImage('assets/images/checker.png'),
                            fit: BoxFit.cover,
                          )
                        : null,
                    color: _selectedImages.isNotEmpty ? Colors.grey[300] : null, // Placeholder color when images are selected
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: _selectedImages.isEmpty
                      ? Center(
                          child: ElevatedButton(
                            onPressed: _pickImages,
                            style: baseButtonStyle.copyWith(
                              backgroundColor: WidgetStateProperty.all(toggleOptionSelectedLengkapColor),
                            ),
                            child: Text(
                              'Upload Foto',
                              style: buttonTextStyle,
                            ),
                          ),
                        )
                      : Image.file(
                          File(_selectedImages[_currentImageIndex].path),
                          fit: BoxFit.cover,
                        ),
                ),
              ),
              const SizedBox(height: 16.0),
              // Labeled Text Field for Label
              LabeledTextField(
                label: 'Label',
                controller: _labelController,
                hintText: 'Misal : Aki tampak atas',
              ),
              const SizedBox(height: 16.0),
              // Checkbox
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
        const SizedBox(height: 40.0), // Space between the box and navigation
        // Image Navigation
        if (_selectedImages.isNotEmpty)
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Previous Button
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
                    backgroundColor: buttonColor, // Orange color
                    shadowColor: buttonColor.withAlpha(102), // Orange shadow
                    alignment: Alignment.center, // Center the icon
                  ),
                  child: const Icon(Icons.arrow_back_ios, size: 20, color: buttonTextColor),
                ),
              ),
              const SizedBox(width: 70.0), // Space between button and text
              // Index Indicator
              SizedBox(
                width: 60.0, // Fixed width to prevent shifting
                child: Text(
                  '${_currentImageIndex + 1}/${_selectedImages.length}',
                  style: imageIndexTextStyle,
                  textAlign: TextAlign.center, // Center the text within the SizedBox
                ),
              ),
              const SizedBox(width: 70.0), // Space between text and button
              // Next Button
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
                    backgroundColor: buttonColor, // Orange color
                    shadowColor: buttonColor.withAlpha(102), // Orange shadow
                  ),
                  child: const Icon(Icons.arrow_forward_ios, size: 20, color: buttonTextColor),
                ),
              ),
            ],
          ),
        const SizedBox(height: 24.0), // Space between the box and navigation
        // Navigation Buttons (Assuming NavigationButtonRow is a separate widget)
        // You would likely pass appropriate callbacks to this widget
        // NavigationButtonRow(
        //   onPrevious: () {
        //     // Handle previous button tap
        //   },
        //   onNext: () {
        //     // Handle next button tap
        //   },
        // ),
      ],
    );
  }
}
