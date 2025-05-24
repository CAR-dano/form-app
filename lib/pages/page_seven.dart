import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/tambahan_image_selection.dart';
import 'package:form_app/providers/form_step_provider.dart';

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
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      key: const PageStorageKey<String>('pageSevenScrollKey'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageNumber(data: '14/26'),
          const SizedBox(height: 4),
          PageTitle(data: 'Foto Dokumen'),
          const SizedBox(height: 6.0),
          TambahanImageSelection(
            identifier: 'Foto Dokumen',
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
          Footer(),
        ],
      ),
    );
  }
}
