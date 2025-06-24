import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/image_input_widget.dart';
import 'dart:io';
import 'package:form_app/models/image_data.dart';
import 'package:form_app/providers/image_data_provider.dart';

class PageSixGeneralWajib extends ConsumerStatefulWidget { // Changed to ConsumerStatefulWidget
  const PageSixGeneralWajib({
    super.key,
  });

  final List<String> imageInputLabels = const [ // This can stay here or move to state if preferred
    'Tampak Depan',
    'Tampak Samping Kanan',
    'Tampak Samping Kiri',
    'Tampak Belakang',
  ];

  @override
  ConsumerState<PageSixGeneralWajib> createState() => _PageSixGeneralWajibState();
}

class _PageSixGeneralWajibState extends ConsumerState<PageSixGeneralWajib> with AutomaticKeepAliveClientMixin { // Add mixin
  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  // Moved _handleImagePicked into the State class
  void _handleImagePicked(String label, File? imageFile) { // ref is available via this.ref
    final imageDataListNotifier = ref.read(imageDataListProvider.notifier);

    if (imageFile != null) {
      int existingIndex = ref
          .read(imageDataListProvider)
          .indexWhere((img) => img.label == label);

      if (existingIndex != -1) {
        imageDataListNotifier.updateImageDataByLabel(
          label,
          imagePath: imageFile.path,
        );
      } else {
        imageDataListNotifier.addImageData(
          ImageData(
            label: label,
            imagePath: imageFile.path,
            needAttention: false,
            category: 'General Wajib', // New field
            isMandatory: true, // New field
          ),
        );
      }
    } else {
      imageDataListNotifier.removeImageDataByLabel(label);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    return Column(
      children: [
        SingleChildScrollView(
          clipBehavior: Clip.none,
          key: const PageStorageKey<String>('pageSixGeneralWajibScrollKey'), // This key remains important
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(data: 'Foto General'),
              const SizedBox(height: 6.0),
              HeadingOne(text: 'Wajib'),
              const SizedBox(height: 16.0),

              ...widget.imageInputLabels.map( // Access imageInputLabels via widget.
                (label) => Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: ImageInputWidget(
                    label: label,
                    onImagePicked: (imageFile) {
                      _handleImagePicked(label, imageFile); // Call state's method
                    },
                  ),
                ),
              ),

              // const SizedBox(height: 32.0),
            ],
          ),
        ),
        Spacer(),
        Footer(),
      ],
    );
  }
}
