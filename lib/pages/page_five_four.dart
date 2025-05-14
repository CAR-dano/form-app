import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
// import 'package:form_app/pages/page_five_five.dart'; // No longer directly navigating
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
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
            key: const PageStorageKey<String>('pageFiveFourScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '5/9'),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian (4)'),
                const SizedBox(height: 6.0),
                const HeadingOne(text: 'Hasil Inspeksi Eksterior'),
                const SizedBox(height: 16.0),
                
                // ToggleableNumberedButtonList widgets
                ToggleableNumberedButtonList(
                  label: 'Bumper Depan',
                  count: 10,
                  selectedValue: formData.bumperDepanSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateBumperDepanSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Kap Mesin',
                  count: 10,
                  selectedValue: formData.kapMesinSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKapMesinSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Lampu Utama',
                  count: 10,
                  selectedValue: formData.lampuUtamaSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateLampuUtamaSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Panel Atap',
                  count: 10,
                  selectedValue: formData.panelAtapSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePanelAtapSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Grill',
                  count: 10,
                  selectedValue: formData.grillSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateGrillSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Lampu Foglamp',
                  count: 10,
                  selectedValue: formData.lampuFoglampSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateLampuFoglampSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Kaca Bening',
                  count: 10,
                  selectedValue: formData.kacaBeningSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKacaBeningSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Wiper Belakang',
                  count: 10,
                  selectedValue: formData.wiperBelakangSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateWiperBelakangSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Bumper Belakang',
                  count: 10,
                  selectedValue: formData.bumperBelakangSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateBumperBelakangSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Lampu Belakang',
                  count: 10,
                  selectedValue: formData.lampuBelakangSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateLampuBelakangSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Trunklid',
                  count: 10,
                  selectedValue: formData.trunklidSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTrunklidSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Kaca Depan',
                  count: 10,
                  selectedValue: formData.kacaDepanSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKacaDepanSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Fender Kanan',
                  count: 10,
                  selectedValue: formData.fenderKananSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateFenderKananSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Quarter Panel Kanan',
                  count: 10,
                  selectedValue: formData.quarterPanelKananSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateQuarterPanelKananSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Pintu Belakang Kanan',
                  count: 10,
                  selectedValue: formData.pintuBelakangKananSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePintuBelakangKananSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Spion Kanan',
                  count: 10,
                  selectedValue: formData.spionKananSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSpionKananSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Lisplang Kanan',
                  count: 10,
                  selectedValue: formData.lisplangKananSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateLisplangKananSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Side Skirt Kanan',
                  count: 10,
                  selectedValue: formData.sideSkirtKananSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSideSkirtKananSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Daun Wiper',
                  count: 10,
                  selectedValue: formData.daunWiperSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateDaunWiperSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Pintu Belakang',
                  count: 10,
                  selectedValue: formData.pintuBelakangSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePintuBelakangSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Fender Kiri',
                  count: 10,
                  selectedValue: formData.fenderKiriSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateFenderKiriSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Quarter Panel Kiri',
                  count: 10,
                  selectedValue: formData.quarterPanelKiriSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateQuarterPanelKiriSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Pintu Depan',
                  count: 10,
                  selectedValue: formData.pintuDepanSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePintuDepanSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Kaca Jendela Kanan',
                  count: 10,
                  selectedValue: formData.kacaJendelaKananSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKacaJendelaKananSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Pintu Belakang Kiri',
                  count: 10,
                  selectedValue: formData.pintuBelakangKiriSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePintuBelakangKiriSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Spion Kiri',
                  count: 10,
                  selectedValue: formData.spionKiriSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSpionKiriSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Pintu Depan Kiri',
                  count: 10,
                  selectedValue: formData.pintuDepanKiriSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePintuDepanKiriSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Kaca Jendela Kiri',
                  count: 10,
                  selectedValue: formData.kacaJendelaKiriSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKacaJendelaKiriSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Lisplang Kiri',
                  count: 10,
                  selectedValue: formData.lisplangKiriSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateLisplangKiriSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Side Skirt Kiri',
                  count: 10,
                  selectedValue: formData.sideSkirtKiriSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSideSkirtKiriSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                
                // ExpandableTextField
                ExpandableTextField(
                  label: 'Catatan',
                  hintText: 'Masukkan catatan di sini',
                  initialLines: formData.eksteriorCatatanList,
                  onChangedList: (lines) {
                    formNotifier.updateEksteriorCatatanList(lines);
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
                const SizedBox(height: 24.0), // Optional spacing below the content
                // Footer
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
