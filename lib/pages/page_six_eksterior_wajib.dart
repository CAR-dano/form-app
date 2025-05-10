import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/image_input_widget.dart';
import 'dart:io';
import 'package:form_app/models/image_data.dart';
import 'package:form_app/providers/image_data_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider

class PageSixEksteriorWajib extends ConsumerWidget {
  const PageSixEksteriorWajib({super.key});

  final List<String> imageInputLabels = const [
    'Cat Samping Kanan dan Kiri (Pintu Mobil)',
    'Pilar Pintu Tengah Depan',
    'Pilar Pintu Tengah Belakang',
    'Karet Pada Pilar',
    'Celah Bagasi',
    'Sealer Bagasi',
    'Pilar Bagasi',
    'Karet Bagasi',
    'Baut Bagasi',
    'Kolong Bagasi',
    'Asap Kendaraan Jika Ngobos',
    'Bumper',
    'Fender',
    'Handle Pintu',
    'Quarter',
    'Lisplang',
    'Lampu',
    'Foglamp',
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
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '6/9'),
                const SizedBox(height: 4),
                PageTitle(data: 'Foto Eksterior'),
                const SizedBox(height: 6.0),
                HeadingOne(text: 'Wajib'),
                const SizedBox(height: 16.0),
    
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
                  onBackPressed: () => ref.read(formStepProvider.notifier).state--,
                  onNextPressed: () => ref.read(formStepProvider.notifier).state++,
                ),
                const SizedBox(height: 32.0),
                Footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
