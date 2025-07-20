import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Import FormData
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PenilaianTestDrive extends ConsumerStatefulWidget {
  const PenilaianTestDrive({
    super.key,
  });

  @override
  ConsumerState<PenilaianTestDrive> createState() => _PenilaianTestDriveState();
}

class _PenilaianTestDriveState extends ConsumerState<PenilaianTestDrive> with AutomaticKeepAliveClientMixin { // Add mixin

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    final formData = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);

    return CustomScrollView(
      key: const PageStorageKey<String>('pageFiveSixScrollKey'),
      slivers: [
        const SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(data: 'Penilaian (6)'),
              SizedBox(height: 6.0),
              HeadingOne(text: 'Test Drive'),
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
                initialLines: formData.testDriveCatatanList,
                onChangedList: (lines) {
                  formNotifier.updateTestDriveCatatanList(lines);
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
        'label': 'Bunyi/Getaran',
        'selectedValue': formData.bunyiGetaranSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBunyiGetaranSelectedValue(value),
      },
      {
        'label': 'Performa Stir',
        'selectedValue': formData.performaStirSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePerformaStirSelectedValue(value),
      },
      {
        'label': 'Perpindahan Transmisi',
        'selectedValue': formData.perpindahanTransmisiSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePerpindahanTransmisiSelectedValue(value),
      },
      {
        'label': 'Stir Balance',
        'selectedValue': formData.stirBalanceSelectedValue,
        'onItemSelected': (value) => formNotifier.updateStirBalanceSelectedValue(value),
      },
      {
        'label': 'Performa Suspensi',
        'selectedValue': formData.performaSuspensiSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePerformaSuspensiSelectedValue(value),
      },
      {
        'label': 'Performa Kopling',
        'selectedValue': formData.performaKoplingSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePerformaKoplingSelectedValue(value),
      },
      {
        'label': 'RPM',
        'selectedValue': formData.rpmSelectedValue,
        'onItemSelected': (value) => formNotifier.updateRpmSelectedValue(value),
      },
    ];

    return toggleableNumberedButtonListData;
  }
}
