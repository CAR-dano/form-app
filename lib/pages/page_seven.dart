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
  const PageSeven({super.key});

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
      key: const PageStorageKey<String>('pageSevenScrollKey'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageNumber(data: '7/9'),
          const SizedBox(height: 4),
          PageTitle(data: 'Foto Dokumen'),
          const SizedBox(height: 6.0),
          TambahanImageSelection(
            identifier: 'foto_dokumen',
            showNeedAttention: false,
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
