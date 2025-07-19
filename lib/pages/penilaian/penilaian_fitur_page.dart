import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PenilaianFiturPage extends ConsumerStatefulWidget {
  const PenilaianFiturPage({
    super.key,
  });

  @override
  ConsumerState<PenilaianFiturPage> createState() => _PenilaianFiturPageState();
}

class _PenilaianFiturPageState extends ConsumerState<PenilaianFiturPage> with AutomaticKeepAliveClientMixin { // Add mixin

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    final formData = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);

    return CustomScrollView(
      key: const PageStorageKey<String>('pageFiveOneScrollKey'),
      slivers: [
        const SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(data: 'Penilaian (1)'),
              SizedBox(height: 6.0),
              HeadingOne(text: 'Fitur'),
              SizedBox(height: 16.0),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final itemData = _buildToggleableNumberedButtonLists(formData, formNotifier)[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: ToggleableNumberedButtonList(
                  label: itemData['label'],
                  count: 10,
                  selectedValue: itemData['selectedValue'] ?? -1,
                  onItemSelected: itemData['onItemSelected'],
                ),
              );
            },
            childCount: _buildToggleableNumberedButtonLists(formData, formNotifier).length,
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              ExpandableTextField(
                label: 'Catatan',
                hintText: 'Masukkan catatan di sini',
                initialLines: formData.fiturCatatanList,
                onChangedList: (lines) {
                  formNotifier.updateFiturCatatanList(lines);
                },
              ),
              const SizedBox(height: 32.0),
              const SizedBox(height: 24.0),
              const Footer(),
            ],
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom + 90),
        ),
      ],
    );
  }

  List<Map<String, dynamic>> _buildToggleableNumberedButtonLists(FormData formData, FormNotifier formNotifier) {
    final List<Map<String, dynamic>> toggleableNumberedButtonListData = [
      {
        'label': 'Airbag',
        'selectedValue': formData.airbagSelectedValue,
        'onItemSelected': (value) => formNotifier.updateAirbagSelectedValue(value),
      },
      {
        'label': 'Sistem Audio',
        'selectedValue': formData.sistemAudioSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSistemAudioSelectedValue(value),
      },
      {
        'label': 'Power Window',
        'selectedValue': formData.powerWindowSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePowerWindowSelectedValue(value),
      },
      {
        'label': 'Sistem AC',
        'selectedValue': formData.sistemAcSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSistemAcSelectedValue(value),
      },
      {
        'label': 'Central Lock',
        'selectedValue': formData.centralLockSelectedValue,
        'onItemSelected': (value) => formNotifier.updateCentralLockSelectedValue(value),
      },
      {
        'label': 'Electric Mirror',
        'selectedValue': formData.electricMirrorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateElectricMirrorSelectedValue(value),
      },
      {
        'label': 'Rem ABS',
        'selectedValue': formData.remAbsSelectedValue,
        'onItemSelected': (value) => formNotifier.updateRemAbsSelectedValue(value),
      },
    ];

    return toggleableNumberedButtonListData;
  }
}
