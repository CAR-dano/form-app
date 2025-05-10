import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import ConsumerWidget
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
// import 'package:form_app/pages/page_nine.dart'; // No longer directly navigating
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Eight
class PageEight extends ConsumerWidget { // Change to ConsumerWidget
  const PageEight({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) { // Add WidgetRef ref
    // Basic structure, replace with actual content later
    return SingleChildScrollView(
      key: const PageStorageKey<String>('pageEightScrollKey'), // Add PageStorageKey here
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
          const SizedBox(height: 32.0), // Optional spacing below the content
          // Footer
          Footer(),
        ],
      ),
    );
  }
}
