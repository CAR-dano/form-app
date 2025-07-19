import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Import FormData
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PenilaianMesinPage extends ConsumerStatefulWidget {
  const PenilaianMesinPage({
    super.key,
  });

  @override
  ConsumerState<PenilaianMesinPage> createState() => _PenilaianMesinPage();
}

class _PenilaianMesinPage extends ConsumerState<PenilaianMesinPage> with AutomaticKeepAliveClientMixin {

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final formData = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final List<Map<String, dynamic>> listData = _buildToggleableNumberedButtonLists(formData, formNotifier);

    return CustomScrollView(
      key: const PageStorageKey<String>('pageFiveTwoScrollKey'),
      slivers: [
        const SliverToBoxAdapter(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageTitle(data: 'Penilaian (2)'),
              SizedBox(height: 6.0),
              HeadingOne(text: 'Hasil Inspeksi Mesin'),
              SizedBox(height: 16.0),
            ],
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              final itemData = listData[index];
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
            childCount: listData.length,
          ),
        ),
        SliverToBoxAdapter(
          child: Column(
            children: [
              ExpandableTextField(
                label: 'Catatan',
                hintText: 'Masukkan catatan di sini',
                initialLines: formData.mesinCatatanList,
                onChangedList: (lines) {
                  formNotifier.updateMesinCatatanList(lines);
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
        'label': 'Getaran Mesin',
        'selectedValue': formData.getaranMesinSelectedValue,
        'onItemSelected': (value) => formNotifier.updateGetaranMesinSelectedValue(value),
      },
      {
        'label': 'Suara Mesin',
        'selectedValue': formData.suaraMesinSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSuaraMesinSelectedValue(value),
      },
      {
        'label': 'Transmisi',
        'selectedValue': formData.transmisiSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTransmisiSelectedValue(value),
      },
      {
        'label': 'Pompa Power Steering',
        'selectedValue': formData.pompaPowerSteeringSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePompaPowerSteeringSelectedValue(value),
      },
      {
        'label': 'Cover Timing Chain',
        'selectedValue': formData.coverTimingChainSelectedValue,
        'onItemSelected': (value) => formNotifier.updateCoverTimingChainSelectedValue(value),
      },
      {
        'label': 'Oli Power Steering',
        'selectedValue': formData.oliPowerSteeringSelectedValue,
        'onItemSelected': (value) => formNotifier.updateOliPowerSteeringSelectedValue(value),
      },
      {
        'label': 'Accu',
        'selectedValue': formData.accuSelectedValue,
        'onItemSelected': (value) => formNotifier.updateAccuSelectedValue(value),
      },
      {
        'label': 'Kompressor AC',
        'selectedValue': formData.kompressorAcSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKompressorAcSelectedValue(value),
      },
      {
        'label': 'Fan',
        'selectedValue': formData.fanSelectedValue,
        'onItemSelected': (value) => formNotifier.updateFanSelectedValue(value),
      },
      {
        'label': 'Selang',
        'selectedValue': formData.selangSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSelangSelectedValue(value),
      },
      {
        'label': 'Karter Oli',
        'selectedValue': formData.karterOliSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKarterOliSelectedValue(value),
      },
      {
        'label': 'Oil Rem',
        'selectedValue': formData.oilRemSelectedValue,
        'onItemSelected': (value) => formNotifier.updateOilRemSelectedValue(value),
      },
      {
        'label': 'Kabel',
        'selectedValue': formData.kabelSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKabelSelectedValue(value),
      },
      {
        'label': 'Kondensor',
        'selectedValue': formData.kondensorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKondensorSelectedValue(value),
      },
      {
        'label': 'Radiator',
        'selectedValue': formData.radiatorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateRadiatorSelectedValue(value),
      },
      {
        'label': 'Cylinder Head',
        'selectedValue': formData.cylinderHeadSelectedValue,
        'onItemSelected': (value) => formNotifier.updateCylinderHeadSelectedValue(value),
      },
      {
        'label': 'Oli Mesin',
        'selectedValue': formData.oliMesinSelectedValue,
        'onItemSelected': (value) => formNotifier.updateOliMesinSelectedValue(value),
      },
      {
        'label': 'Air Radiator',
        'selectedValue': formData.airRadiatorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateAirRadiatorSelectedValue(value),
      },
      {
        'label': 'Cover Klep',
        'selectedValue': formData.coverKlepSelectedValue,
        'onItemSelected': (value) => formNotifier.updateCoverKlepSelectedValue(value),
      },
      {
        'label': 'Alternator',
        'selectedValue': formData.alternatorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateAlternatorSelectedValue(value),
      },
      {
        'label': 'Water Pump',
        'selectedValue': formData.waterPumpSelectedValue,
        'onItemSelected': (value) => formNotifier.updateWaterPumpSelectedValue(value),
      },
      {
        'label': 'Belt',
        'selectedValue': formData.beltSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBeltSelectedValue(value),
      },
      {
        'label': 'Oli Transmisi',
        'selectedValue': formData.oliTransmisiSelectedValue,
        'onItemSelected': (value) => formNotifier.updateOliTransmisiSelectedValue(value),
      },
      {
        'label': 'Cylinder Block',
        'selectedValue': formData.cylinderBlockSelectedValue,
        'onItemSelected': (value) => formNotifier.updateCylinderBlockSelectedValue(value),
      },
      {
        'label': 'Bushing Besar',
        'selectedValue': formData.bushingBesarSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBushingBesarSelectedValue(value),
      },
      {
        'label': 'Bushing Kecil',
        'selectedValue': formData.bushingKecilSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBushingKecilSelectedValue(value),
      },
      {
        'label': 'Tutup Radiator',
        'selectedValue': formData.tutupRadiatorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTutupRadiatorSelectedValue(value),
      },
    ];

    return toggleableNumberedButtonListData;
  }
}