import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
// Keep import in case needed later
// Keep import in case needed later
// Keep import in case needed later
// Keep import in case needed later
// import 'package:form_app/pages/page_seven.dart'; // No longer directly navigating
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider

class PageSixAlatAlatTambahan extends ConsumerStatefulWidget { // Changed to ConsumerStatefulWidget
  const PageSixAlatAlatTambahan({super.key});

  @override
  ConsumerState<PageSixAlatAlatTambahan> createState() => _PageSixAlatAlatTambahanState();
}

class _PageSixAlatAlatTambahanState extends ConsumerState<PageSixAlatAlatTambahan> with AutomaticKeepAliveClientMixin { // Add mixin
  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    // ref is available directly in ConsumerStatefulWidget state classes
    return SingleChildScrollView(
      key: const PageStorageKey<String>('pageSixAlatAlatTambahanScrollKey'), // This key remains important
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageNumber(data: '6/9'),
          const SizedBox(height: 4),
          PageTitle(data: 'Foto Alat-alat'),
          const SizedBox(height: 6.0),
          HeadingOne(text: 'Tambahan'),
          const SizedBox(height: 16.0),
      
          // Tambahan image inputs will go here later
      
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
