import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/toggle_option_widget.dart';
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Three
class KelengkapanPage extends ConsumerStatefulWidget { 
  const KelengkapanPage({
    super.key,
});

  @override
  ConsumerState<KelengkapanPage> createState() => _KelengkapanPageState(); // Create state
}

class _KelengkapanPageState extends ConsumerState<KelengkapanPage> with AutomaticKeepAliveClientMixin { // Add mixin
  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    final formData = ref.watch(formProvider); // Watch the form data
    final formNotifier = ref.read(formProvider.notifier); // Read the notifier

    // Basic structure, replace with actual content later
    return CustomScrollView(
      key: const PageStorageKey<String>('pageThreeScrollKey'),
      slivers: [
        const SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(data: 'Kelengkapan'),
              SizedBox(height: 6.0),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final optionData = _buildToggleOptions(formData, formNotifier)[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ToggleOption(
                  toggleValues: const ['Lengkap', 'Tidak'],
                  label: optionData['label'],
                  initialValue: optionData['initialValue'],
                  onChanged: optionData['onChanged'],
                ),
              );
            },
            childCount: _buildToggleOptions(formData, formNotifier).length,
          ),
        ),
        const SliverToBoxAdapter(
          child: Column(
            children: [
              SizedBox(height: 32.0),
              SizedBox(height: 24.0), 
              Footer(),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom + 90),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _buildToggleOptions(FormData formData, FormNotifier formNotifier) {
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

    return toggleOptionsData;
  }
}
