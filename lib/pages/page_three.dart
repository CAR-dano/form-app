import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/toggle_option_widget.dart';
import 'package:form_app/pages/page_four.dart';
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Three
class PageThree extends ConsumerWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final formData = ref.watch(formProvider); // Watch the form data
    final formNotifier = ref.read(formProvider.notifier); // Read the notifier

    // Basic structure, replace with actual content later
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '3/9'),
                const SizedBox(height: 4),
                PageTitle(data: 'Kelengkapan'),
                const SizedBox(height: 6.0),
                ToggleOption(
                  toggleValues: ['Lengkap', 'Tidak'],
                  label: 'Buku Service',
                  initialValue: formData.bukuService,
                  onChanged: (value) => formNotifier.updateBukuService(value),
                ),
                const SizedBox(height: 16.0),
                ToggleOption(
                  toggleValues: ['Lengkap', 'Tidak'],
                  label: 'Kunci Serep',
                  initialValue: formData.kunciSerep,
                  onChanged: (value) => formNotifier.updateKunciSerep(value),
                ),
                const SizedBox(height: 16.0),
                ToggleOption(
                  toggleValues: ['Lengkap', 'Tidak'],
                  label: 'Buku Manual',
                  initialValue: formData.bukuManual,
                  onChanged: (value) => formNotifier.updateBukuManual(value),
                ),
                const SizedBox(height: 16.0),
                ToggleOption(
                  label: 'Ban Serep',
                  toggleValues: ['Lengkap', 'Tidak'],
                  initialValue: formData.banSerep,
                  onChanged: (value) => formNotifier.updateBanSerep(value),
                ),
                const SizedBox(height: 16.0),
                ToggleOption(
                  label: 'BPKB',
                  toggleValues: ['Lengkap', 'Tidak'],
                  initialValue: formData.bpkb,
                  onChanged: (value) => formNotifier.updateBpkb(value),
                ),
                const SizedBox(height: 16.0),
                ToggleOption(
                  label: 'Dongkrak',
                  toggleValues: ['Lengkap', 'Tidak'],
                  initialValue: formData.dongkrak,
                  onChanged: (value) => formNotifier.updateDongkrak(value),
                ),
                const SizedBox(height: 16.0),
                ToggleOption(
                  label: 'Toolkit',
                  toggleValues: ['Lengkap', 'Tidak'],
                  initialValue: formData.toolkit,
                  onChanged: (value) => formNotifier.updateToolkit(value),
                ),
                const SizedBox(height: 16.0),
                ToggleOption(
                  label: 'No Rangka',
                  toggleValues: ['Lengkap', 'Tidak'],
                  initialValue: formData.noRangka,
                  onChanged: (value) => formNotifier.updateNoRangka(value),
                ),
                const SizedBox(height: 16.0),
                ToggleOption(
                  label: 'No Mesin',
                  toggleValues: ['Lengkap', 'Tidak'],
                  initialValue: formData.noMesin,
                  onChanged: (value) => formNotifier.updateNoMesin(value),
                ),
                const SizedBox(height: 32.0),
                NavigationButtonRow(
                  onBackPressed: () => Navigator.pop(context),
                  onNextPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PageFour()),
                    );
                  },
                ),
                SizedBox(height: 32.0), // Optional spacing below the content
                // Footer
                Footer(),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
