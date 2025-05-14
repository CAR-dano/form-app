import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import ConsumerWidget
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Eight
class PageEight extends ConsumerStatefulWidget { // Changed to ConsumerStatefulWidget
  const PageEight({super.key});

  @override
  ConsumerState<PageEight> createState() => _PageEightState();
}

class _PageEightState extends ConsumerState<PageEight> with AutomaticKeepAliveClientMixin { // Add mixin
  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    // ref is available directly in ConsumerStatefulWidget state classes
    // Basic structure, replace with actual content later
    return SingleChildScrollView(
      key: const PageStorageKey<String>('pageEightScrollKey'), // This key remains important
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageNumber(data: '8/9'),
          const SizedBox(height: 4),
          PageTitle(data: 'Page Eight Title'), // Placeholder Title
          const SizedBox(height: 6.0),
          const Center(child: Text('Masih On Progress')),
          const SizedBox(height: 32.0),
          NavigationButtonRow(
            onBackPressed: () => ref.read(formStepProvider.notifier).state--,
            onNextPressed: () => ref.read(formStepProvider.notifier).state++,
          ),
          const SizedBox(height: 24.0), // Optional spacing below the content
          // Footer
          Footer(),
        ],
      ),
    );
  }
}
