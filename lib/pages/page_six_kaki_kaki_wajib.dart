import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/image_input_widget.dart'; // Keep import in case needed later
import 'dart:io'; // Keep import in case needed later
import 'package:form_app/models/image_data.dart'; // Keep import in case needed later
import 'package:form_app/providers/image_data_provider.dart'; // Keep import in case needed later
import 'package:form_app/pages/page_six_kaki_kaki_tambahan.dart'; // Import the next page

class PageSixKakiKakiWajib extends ConsumerWidget {
  const PageSixKakiKakiWajib({super.key});

  final List<String> imageInputLabels = const [
    'Cakram',
    'Kampas rem',
    'Celah Antara Roda dan Fender',
    'Ulir Ban',
    'Usia Ban',
    'Tie Rod',
    'Link Stabilizer',
    'Balljoint',
    'Shock Breaker',
    'As Roda Depan',
    'Kabel Ties',
    'Lower Arm',
    'Crossmember',
    'Chassis',
  ];

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
                  const SizedBox(height: 4),
                  PageTitle(data: 'Foto Kaki-kaki'),
                  const SizedBox(height: 6.0),
                  HeadingOne(text: 'Wajib'),
                  const SizedBox(height: 16.0),

                  // Wajib image inputs will go here later
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
                        MaterialPageRoute(builder: (context) => const PageSixKakiKakiTambahan()),
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
