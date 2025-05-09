import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import flutter_riverpod
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/image_input_widget.dart'; // Import ImageInputWidget
import 'dart:io'; // Import File
import 'package:form_app/models/image_data.dart'; // Import ImageData
import 'package:form_app/providers/image_data_provider.dart'; // Import ImageDataProvider
import 'package:form_app/pages/page_eight.dart'; // Import PageEight

// Foto Dokumen Page (formerly Page Seven)
class PageSeven extends ConsumerWidget { // Change to ConsumerWidget
  const PageSeven({super.key});

  // Image input labels will go here later
  final List<String> imageInputLabels = const [];

  void _handleImagePicked(String label, File? imageFile, WidgetRef ref) {
    final imageDataListNotifier = ref.read(imageDataListProvider.notifier);

    if (imageFile != null) {
      int existingIndex = ref.read(imageDataListProvider).indexWhere((img) => img.label == label);

      if (existingIndex != -1) {
        imageDataListNotifier.updateImageDataByLabel(label, imagePath: imageFile.path);
      } else {
        imageDataListNotifier.addImageData(ImageData(label: label, imagePath: imageFile.path));
      }
    } else {
       imageDataListNotifier.removeImageDataByLabel(label);
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Add WidgetRef ref
    return CommonLayout(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '7/9'),
                  const SizedBox(height: 4),
                  PageTitle(data: 'Foto Dokumen'), // Update Title
                  const SizedBox(height: 6.0),

                  // Image inputs will go here later
                   ...imageInputLabels.map((label) => Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: ImageInputWidget(
                      label: label,
                      onImagePicked: (imageFile) {
                        _handleImagePicked(label, imageFile, ref);
                      },
                    ),
                  )),

                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                       Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageEight()),
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
