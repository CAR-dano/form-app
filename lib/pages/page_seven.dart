import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart';
import 'package:form_app/providers/form_step_provider.dart';
import 'package:form_app/widgets/delete_all_tambahan_photos_button.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart'; // Import this

// Foto Dokumen Page (formerly Page Seven)
class PageSeven extends ConsumerStatefulWidget { 
  final ValueNotifier<bool> formSubmitted;
  final String defaultLabel;

  const PageSeven({
    super.key,
    required this.formSubmitted,
    required this.defaultLabel,
  });

  @override
  ConsumerState<PageSeven> createState() => _PageSevenState();
}

class _PageSevenState extends ConsumerState<PageSeven> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    const String pageIdentifier = 'Foto Dokumen'; // Define identifier

    return SingleChildScrollView(
      clipBehavior: Clip.none,
      key: const PageStorageKey<String>('pageSevenScrollKey'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer(
            builder: (context, ref, child) {
              final images = ref.watch(tambahanImageDataProvider(pageIdentifier));
              final bool hasImages = images.length > 1;
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center, // Align items vertically
                children: [
                  const PageNumber(data: '14/26'),
                  if (hasImages) // Conditionally show the button
                    DeleteAllTambahanPhotosButton(
                      tambahanImageIdentifier: pageIdentifier,
                      dialogMessage: 'Yakin ingin menghapus semua Foto Dokumen?',
                    ),
                ],
              );
            },
          ),
          const SizedBox(height: 4),
          const PageTitle(data: 'Foto Dokumen'),
          const SizedBox(height: 6.0),
          TambahanImageSelection(
            identifier: pageIdentifier, // Use the defined identifier
            showNeedAttention: false,
            isMandatory: true, // Set isMandatory to true for Page Seven
            formSubmitted: widget.formSubmitted,
            defaultLabel: widget.defaultLabel, // Pass the defaultLabel
          ),
      
          const SizedBox(height: 32.0),
          NavigationButtonRow(
            onBackPressed: () => ref.read(formStepProvider.notifier).state--,
            onNextPressed: () => ref.read(formStepProvider.notifier).state++,
          ),
          const SizedBox(height: 24.0),
          const Footer(),
        ],
      ),
    );
  }
}
