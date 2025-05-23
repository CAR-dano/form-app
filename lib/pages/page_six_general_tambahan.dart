import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart'; // Import the new widget
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider

class PageSixGeneralTambahan extends ConsumerStatefulWidget {
  final ValueNotifier<bool> formSubmitted;

  const PageSixGeneralTambahan({
    super.key,
    required this.formSubmitted,
  });

  @override
  ConsumerState<PageSixGeneralTambahan> createState() => _PageSixGeneralTambahanState();
}

class _PageSixGeneralTambahanState extends ConsumerState<PageSixGeneralTambahan>
    with AutomaticKeepAliveClientMixin {
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
  bool get wantKeepAlive => true; // Override wantKeepAlive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    // ref is available directly in ConsumerStatefulWidget state classes
    return PopScope(
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus(); // Unfocus when navigating back
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: SingleChildScrollView(
          key: const PageStorageKey<String>(
            'pageSixGeneralTambahanScrollKey',
          ), // This key remains important
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageNumber(data: '8/26'),
              const SizedBox(height: 4),
              PageTitle(data: 'Foto General'),
              const SizedBox(height: 6.0),
              HeadingOne(text: 'Tambahan'),
              const SizedBox(height: 16.0),

              // Tambahan image selection widget
              TambahanImageSelection(
                identifier: 'General Tambahan',
                formSubmitted: widget.formSubmitted,
              ),

              const SizedBox(height: 32.0),
              NavigationButtonRow(
                onBackPressed:
                    () => ref.read(formStepProvider.notifier).state--,
                onNextPressed:
                    () => ref.read(formStepProvider.notifier).state++,
              ),
              const SizedBox(height: 24.0),
              Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
