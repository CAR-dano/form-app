import 'package:flutter/material.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_seven.dart'; // Import PageSeven
import 'package:form_app/widgets/image_input_widget.dart'; // Import ImageInputWidget
import 'dart:io'; // Import File
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import flutter_riverpod
import 'package:form_app/models/image_data.dart'; // Import ImageData
import 'package:form_app/providers/image_data_provider.dart'; // Import ImageDataProvider

class PageSix extends ConsumerWidget {
  const PageSix({super.key});

  // List of labels for the ImageInputWidgets
  final List<String> imageInputLabels = const [
    'OBD Scanner',
    'Sinar UV',
    'Paint Thickness',
    'Cek Aki',
    'Tire Thickness',
    'Endoscope (Jika Perlu)',
  ];

  // Method to handle image picked callback
  void _handleImagePicked(String label, File? imageFile, WidgetRef ref) {
    final imageDataListNotifier = ref.read(imageDataListProvider.notifier); // Access image data provider

    if (imageFile != null) {
      // Find if an ImageData with the same label exists
      int existingIndex = ref.read(imageDataListProvider).indexWhere((img) => img.label == label);

      if (existingIndex != -1) {
        // Update existing ImageData
        imageDataListNotifier.updateImageDataByLabel(label, imagePath: imageFile.path);
      } else {
        // Add new ImageData
        imageDataListNotifier.addImageData(ImageData(label: label, imagePath: imageFile.path));
      }
    } else {
       // If imageFile is null, remove the ImageData with the corresponding label
      imageDataListNotifier.removeImageDataByLabel(label);
    }
    print('Image picked for $label: ${imageFile?.path}');
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return CommonLayout(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '6/9'),
                  const SizedBox(height: 8.0),
                  PageTitle(data: 'Foto Alat-alat'),
                  const SizedBox(height: 24.0),
                  HeadingOne(text: 'Wajib'),
                  const SizedBox(height: 16.0),
              
                  // Add ImageInputWidgets dynamically
                  ...imageInputLabels.map((label) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0), // Spacing between widgets
                    child: ImageInputWidget(
                      label: label,
                      onImagePicked: (imageFile) {
                        _handleImagePicked(label, imageFile, ref); // Pass ref
                      },
                    ),
                  )).toList(),
              
                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                      // TODO: Pass the _pickedImages data to the next page or form data
                      final imageDataList = ref.read(imageDataListProvider); // Access image data list
                      print('Picked Images: $imageDataList');
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageSeven()),
                      );
                    },
                  ),
                  const SizedBox(height: 32.0),
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
