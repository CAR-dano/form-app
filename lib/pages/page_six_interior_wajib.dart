import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/image_input_widget.dart'; // Keep import in case needed later
import 'dart:io'; // Keep import in case needed later
import 'package:form_app/models/image_data.dart'; // Keep import in case needed later
import 'package:form_app/providers/image_data_provider.dart'; // Keep import in case needed later
// import 'package:form_app/pages/page_six_interior_tambahan.dart'; // No longer directly navigating
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider

class PageSixInteriorWajib extends ConsumerStatefulWidget { // Changed to ConsumerStatefulWidget
  const PageSixInteriorWajib({super.key});

  final List<String> imageInputLabels = const [
    'Transmisi',
    'Pedal',
    'Dashboard Mobil',
    'Stir',
    'Jok',
    'Doortrim',
    'Karpet',
    'Plafon',
    'Tuas Wiper',
    'Tuas Lampu',
    'Safety Belt',
    'Lantai Mobil',
  ];

  @override
  ConsumerState<PageSixInteriorWajib> createState() => _PageSixInteriorWajibState();
}

class _PageSixInteriorWajibState extends ConsumerState<PageSixInteriorWajib> with AutomaticKeepAliveClientMixin { // Add mixin
  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  void _handleImagePicked(String label, File? imageFile) { // ref is available via this.ref
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
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    // ref is available directly in ConsumerStatefulWidget state classes
    return SingleChildScrollView(
      key: const PageStorageKey<String>('pageSixInteriorWajibScrollKey'), // This key remains important
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageNumber(data: '6/9'),
          const SizedBox(height: 4),
          PageTitle(data: 'Foto Interior'),
          const SizedBox(height: 6.0),
          HeadingOne(text: 'Wajib'),
          const SizedBox(height: 16.0),
      
          // Wajib image inputs will go here later
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
          NavigationButtonRow(
            onBackPressed: () => ref.read(formStepProvider.notifier).state--,
            onNextPressed: () => ref.read(formStepProvider.notifier).state++,
          ),
          const SizedBox(height: 32.0),
          Footer(),
        ],
      ),
    );
  }
}
