import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Import FormData
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveTwo extends ConsumerStatefulWidget {
  const PageFiveTwo({super.key});

  @override
  ConsumerState<PageFiveTwo> createState() => _PageFiveTwoState();
}

class _PageFiveTwoState extends ConsumerState<PageFiveTwo> with AutomaticKeepAliveClientMixin { // Add mixin
  late FocusScopeNode _focusScopeNode;

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    final formData = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);

    return PopScope(
      // Wrap with PopScope
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus(); // Unfocus when navigating back
        }
      },
      child: FocusScope(
        // Wrap with FocusScope
        node: _focusScopeNode,
        child: GestureDetector(
          // Wrap with GestureDetector
          onTap: () {
            _focusScopeNode.unfocus(); // Unfocus on tap outside text fields
          },
          child: SingleChildScrollView(
            key: const PageStorageKey<String>('pageFiveTwoScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '5/9'),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian (2)'),
                const SizedBox(height: 6.0),
                const HeadingOne(text: 'Hasil Inspeksi Mesin'),
                const SizedBox(height: 16.0),

                ..._buildToggleableNumberedButtonLists(formData, formNotifier),

                ExpandableTextField(
                  label: 'Catatan',
                  hintText: 'Masukkan catatan di sini',
                  initialLines: formData.mesinCatatanList,
                  onChangedList: (lines) {
                    formNotifier.updateMesinCatatanList(lines);
                  },
                ),
                const SizedBox(height: 32.0),

                NavigationButtonRow(
                  onBackPressed: () {
                    _focusScopeNode.unfocus();
                    ref.read(formStepProvider.notifier).state--;
                  },
                  onNextPressed: () {
                    _focusScopeNode.unfocus();
                    ref.read(formStepProvider.notifier).state++;
                  },
                ),
                const SizedBox(height: 24.0),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _buildToggleableNumberedButtonLists(FormData formData, FormNotifier formNotifier) {
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

    return toggleableNumberedButtonListData.map<Widget>((itemData) {
      return Padding(
        padding: const EdgeInsets.only(bottom: 16.0),
        child: ToggleableNumberedButtonList(
          label: itemData['label'],
          count: 10,
          selectedValue: itemData['selectedValue'] ?? -1,
          onItemSelected: itemData['onItemSelected'],
        ),
      );
    }).toList();
  }
}
