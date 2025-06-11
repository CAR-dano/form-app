import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart';
import 'package:form_app/providers/form_step_provider.dart';
import 'package:form_app/widgets/delete_all_tambahan_photos_button.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart'; // Import this

class PageSixGeneralTambahan extends ConsumerStatefulWidget {
  final ValueNotifier<bool> formSubmitted;

  const PageSixGeneralTambahan({
    super.key,
    required this.formSubmitted,
  });

  @override
  ConsumerState<PageSixGeneralTambahan> createState() => _PageSixGeneralTambahanState();
}

class _PageSixGeneralTambahanState extends ConsumerState<PageSixGeneralTambahan>{
  late FocusScopeNode _focusScopeNode;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    const String pageIdentifier = 'General Tambahan'; // Define identifier

    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus();
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: SingleChildScrollView(
          clipBehavior: Clip.none,
          key: const PageStorageKey<String>('pageSixGeneralTambahanScrollKey'),
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
                      const PageNumber(data: '8/26'),
                      if (hasImages) // Conditionally show the button
                        DeleteAllTambahanPhotosButton(
                          tambahanImageIdentifier: pageIdentifier,
                          dialogMessage: 'Yakin ingin menghapus semua foto tambahan General?',
                        ),
                    ],
                  );
                },
              ),
              const SizedBox(height: 4),
              const PageTitle(data: 'Foto General'),
              const SizedBox(height: 6.0),
              const HeadingOne(text: 'Tambahan'),
              const SizedBox(height: 16.0),
              TambahanImageSelection(
                identifier: pageIdentifier, // Use the defined identifier
                formSubmitted: widget.formSubmitted,
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
        ),
      ),
    );
  }
}
