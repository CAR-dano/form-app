import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Import FormData
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveFour extends ConsumerStatefulWidget {
  const PageFiveFour({super.key});

  @override
  ConsumerState<PageFiveFour> createState() => _PageFiveFourState();
}

class _PageFiveFourState extends ConsumerState<PageFiveFour> with AutomaticKeepAliveClientMixin { // Add mixin
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
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus();
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: GestureDetector(
          onTap: () {
            _focusScopeNode.unfocus();
          },
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            key: const PageStorageKey<String>('pageFiveFourScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '21/26'),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian (4)'),
                const SizedBox(height: 6.0),
                const HeadingOne(text: 'Hasil Inspeksi Eksterior'),
                const SizedBox(height: 16.0),

                ..._buildToggleableNumberedButtonLists(formData, formNotifier),

                ExpandableTextField(
                  label: 'Catatan',
                  hintText: 'Masukkan catatan di sini',
                  initialLines: formData.eksteriorCatatanList,
                  onChangedList: (lines) {
                    formNotifier.updateEksteriorCatatanList(lines);
                  },
                ),
                const SizedBox(height: 32.0),
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
        'label': 'Bumper Depan',
        'selectedValue': formData.bumperDepanSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBumperDepanSelectedValue(value),
      },
      {
        'label': 'Kap Mesin',
        'selectedValue': formData.kapMesinSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKapMesinSelectedValue(value),
      },
      {
        'label': 'Lampu Utama',
        'selectedValue': formData.lampuUtamaSelectedValue,
        'onItemSelected': (value) => formNotifier.updateLampuUtamaSelectedValue(value),
      },
      {
        'label': 'Panel Atap',
        'selectedValue': formData.panelAtapSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePanelAtapSelectedValue(value),
      },
      {
        'label': 'Grill',
        'selectedValue': formData.grillSelectedValue,
        'onItemSelected': (value) => formNotifier.updateGrillSelectedValue(value),
      },
      {
        'label': 'Lampu Foglamp',
        'selectedValue': formData.lampuFoglampSelectedValue,
        'onItemSelected': (value) => formNotifier.updateLampuFoglampSelectedValue(value),
      },
      {
        'label': 'Kaca Bening',
        'selectedValue': formData.kacaBeningSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKacaBeningSelectedValue(value),
      },
      {
        'label': 'Wiper Belakang',
        'selectedValue': formData.wiperBelakangSelectedValue,
        'onItemSelected': (value) => formNotifier.updateWiperBelakangSelectedValue(value),
      },
      {
        'label': 'Bumper Belakang',
        'selectedValue': formData.bumperBelakangSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBumperBelakangSelectedValue(value),
      },
      {
        'label': 'Lampu Belakang',
        'selectedValue': formData.lampuBelakangSelectedValue,
        'onItemSelected': (value) => formNotifier.updateLampuBelakangSelectedValue(value),
      },
      {
        'label': 'Trunklid',
        'selectedValue': formData.trunklidSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTrunklidSelectedValue(value),
      },
      {
        'label': 'Kaca Depan',
        'selectedValue': formData.kacaDepanSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKacaDepanSelectedValue(value),
      },
      {
        'label': 'Fender Kanan',
        'selectedValue': formData.fenderKananSelectedValue,
        'onItemSelected': (value) => formNotifier.updateFenderKananSelectedValue(value),
      },
      {
        'label': 'Quarter Panel Kanan',
        'selectedValue': formData.quarterPanelKananSelectedValue,
        'onItemSelected': (value) => formNotifier.updateQuarterPanelKananSelectedValue(value),
      },
      {
        'label': 'Pintu Belakang Kanan',
        'selectedValue': formData.pintuBelakangKananSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePintuBelakangKananSelectedValue(value),
      },
      {
        'label': 'Spion Kanan',
        'selectedValue': formData.spionKananSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSpionKananSelectedValue(value),
      },
      {
        'label': 'Lisplang Kanan',
        'selectedValue': formData.lisplangKananSelectedValue,
        'onItemSelected': (value) => formNotifier.updateLisplangKananSelectedValue(value),
      },
      {
        'label': 'Side Skirt Kanan',
        'selectedValue': formData.sideSkirtKananSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSideSkirtKananSelectedValue(value),
      },
      {
        'label': 'Daun Wiper',
        'selectedValue': formData.daunWiperSelectedValue,
        'onItemSelected': (value) => formNotifier.updateDaunWiperSelectedValue(value),
      },
      {
        'label': 'Pintu Belakang',
        'selectedValue': formData.pintuBelakangSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePintuBelakangSelectedValue(value),
      },
      {
        'label': 'Fender Kiri',
        'selectedValue': formData.fenderKiriSelectedValue,
        'onItemSelected': (value) => formNotifier.updateFenderKiriSelectedValue(value),
      },
      {
        'label': 'Quarter Panel Kiri',
        'selectedValue': formData.quarterPanelKiriSelectedValue,
        'onItemSelected': (value) => formNotifier.updateQuarterPanelKiriSelectedValue(value),
      },
      {
        'label': 'Pintu Depan',
        'selectedValue': formData.pintuDepanSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePintuDepanSelectedValue(value),
      },
      {
        'label': 'Kaca Jendela Kanan',
        'selectedValue': formData.kacaJendelaKananSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKacaJendelaKananSelectedValue(value),
      },
      {
        'label': 'Pintu Belakang Kiri',
        'selectedValue': formData.pintuBelakangKiriSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePintuBelakangKiriSelectedValue(value),
      },
      {
        'label': 'Spion Kiri',
        'selectedValue': formData.spionKiriSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSpionKiriSelectedValue(value),
      },
      {
        'label': 'Pintu Depan Kiri',
        'selectedValue': formData.pintuDepanKiriSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePintuDepanKiriSelectedValue(value),
      },
      {
        'label': 'Kaca Jendela Kiri',
        'selectedValue': formData.kacaJendelaKiriSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKacaJendelaKiriSelectedValue(value),
      },
      {
        'label': 'Lisplang Kiri',
        'selectedValue': formData.lisplangKiriSelectedValue,
        'onItemSelected': (value) => formNotifier.updateLisplangKiriSelectedValue(value),
      },
      {
        'label': 'Side Skirt Kiri',
        'selectedValue': formData.sideSkirtKiriSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSideSkirtKiriSelectedValue(value),
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
