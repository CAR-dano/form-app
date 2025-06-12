import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/image_input_widget.dart';
import 'dart:io';
import 'package:form_app/models/image_data.dart';
import 'package:form_app/providers/image_data_provider.dart';

class PageSixEksteriorWajib extends ConsumerStatefulWidget { // Changed to ConsumerStatefulWidget
  const PageSixEksteriorWajib({super.key});

  final List<String> imageInputLabels = const [
    'Cat Samping Kanan dan Kiri (Pintu Mobil)',
    'Pilar Pintu Depan',
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

  @override
  ConsumerState<PageSixEksteriorWajib> createState() => _PageSixEksteriorWajibState();
}

class _PageSixEksteriorWajibState extends ConsumerState<PageSixEksteriorWajib> with AutomaticKeepAliveClientMixin { // Add mixin
  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  void _handleImagePicked(String label, File? imageFile) { // ref is available via this.ref
    final imageDataListNotifier = ref.read(imageDataListProvider.notifier);

    if (imageFile != null) {
      int existingIndex = ref.read(imageDataListProvider).indexWhere((img) => img.label == label);

      if (existingIndex != -1) {
        imageDataListNotifier.updateImageDataByLabel(label, imagePath: imageFile.path);
      } else {
        imageDataListNotifier.addImageData(ImageData(
          label: label,
          imagePath: imageFile.path,
          needAttention: false,
          category: 'Eksterior Wajib', // New field
          isMandatory: true, // New field
        ));
      }
    } else {
       imageDataListNotifier.removeImageDataByLabel(label);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    // ref is available directly in ConsumerStatefulWidget state classes
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      key: const PageStorageKey<String>('pageSixEksteriorWajibScrollKey'), // This key remains important
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageNumber(data: '3/26'),
          const SizedBox(height: 4),
          PageTitle(data: 'Foto Eksterior'),
          const SizedBox(height: 6.0),
          HeadingOne(text: 'Wajib'),
          const SizedBox(height: 16.0),
      
          ...widget.imageInputLabels.map((label) => Padding( // Access imageInputLabels via widget.
            padding: const EdgeInsets.only(bottom: 16.0),
            child: ImageInputWidget(
              label: label,
              onImagePicked: (imageFile) {
                _handleImagePicked(label, imageFile); // Call state's method
              },
            ),
          )),
      
          const SizedBox(height: 32.0),
          const SizedBox(height: 24.0),
          Footer(),
        ],
      ),
    );
  }
}
