import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/toggle_option_widget.dart';
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Three
class PageThree extends ConsumerStatefulWidget { // Changed to ConsumerStatefulWidget
  const PageThree({super.key});

  @override
  ConsumerState<PageThree> createState() => _PageThreeState(); // Create state
}

class _PageThreeState extends ConsumerState<PageThree> {
  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(formProvider); // Watch the form data
    final formNotifier = ref.read(formProvider.notifier); // Read the notifier

    // Basic structure, replace with actual content later
    return SingleChildScrollView(
      clipBehavior: Clip.none,
      key: const PageStorageKey<String>('pageThreeScrollKey'), // This key remains important
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          PageNumber(data: '16/26'),
          const SizedBox(height: 4),
          PageTitle(data: 'Kelengkapan'),
          const SizedBox(height: 6.0),

          ..._buildToggleOptions(formData, formNotifier),

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

  List<Widget> _buildToggleOptions(FormData formData, FormNotifier formNotifier) {
    final List<Map<String, dynamic>> toggleOptionsData = [
      {
        'label': 'Buku Service',
        'initialValue': formData.bukuService,
        'onChanged': (value) => formNotifier.updateBukuService(value),
      },
      {
        'label': 'Kunci Serep',
        'initialValue': formData.kunciSerep,
        'onChanged': (value) => formNotifier.updateKunciSerep(value),
      },
      {
        'label': 'Buku Manual',
        'initialValue': formData.bukuManual,
        'onChanged': (value) => formNotifier.updateBukuManual(value),
      },
      {
        'label': 'Ban Serep',
        'initialValue': formData.banSerep,
        'onChanged': (value) => formNotifier.updateBanSerep(value),
      },
      {
        'label': 'BPKB',
        'initialValue': formData.bpkb,
        'onChanged': (value) => formNotifier.updateBpkb(value),
      },
      {
        'label': 'Dongkrak',
        'initialValue': formData.dongkrak,
        'onChanged': (value) => formNotifier.updateDongkrak(value),
      },
      {
        'label': 'Toolkit',
        'initialValue': formData.toolkit,
        'onChanged': (value) => formNotifier.updateToolkit(value),
      },
      {
        'label': 'No Rangka',
        'initialValue': formData.noRangka,
        'onChanged': (value) => formNotifier.updateNoRangka(value),
      },
      {
        'label': 'No Mesin',
        'initialValue': formData.noMesin,
        'onChanged': (value) => formNotifier.updateNoMesin(value),
      },
    ];

    return toggleOptionsData.map<Widget>((optionData) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ToggleOption(
          toggleValues: const ['Lengkap', 'Tidak'],
          label: optionData['label'],
          initialValue: optionData['initialValue'],
          onChanged: optionData['onChanged'],
        ),
      );
    }).toList();
  }
}
