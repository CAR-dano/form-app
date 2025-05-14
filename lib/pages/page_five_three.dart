import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
// import 'package:form_app/pages/page_five_four.dart'; // No longer directly navigating
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';


class PageFiveThree extends ConsumerStatefulWidget {
  const PageFiveThree({super.key});

  @override
  ConsumerState<PageFiveThree> createState() => _PageFiveThreeState();
}

class _PageFiveThreeState extends ConsumerState<PageFiveThree> with AutomaticKeepAliveClientMixin { // Add mixin
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
            key: const PageStorageKey<String>('pageFiveThreeScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '5/9'),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian (3)'),
                const SizedBox(height: 6.0),
                const HeadingOne(text: 'Hasil Inspeksi Interior'),
                const SizedBox(height: 16.0),
                      
                // ToggleableNumberedButtonList widgets
                ToggleableNumberedButtonList(
                  label: 'Stir',
                  count: 10,
                  selectedValue: formData.stirSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateStirSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Rem Tangan',
                  count: 10,
                  selectedValue: formData.remTanganSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateRemTanganSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Pedal',
                  count: 10,
                  selectedValue: formData.pedalSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePedalSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Switch Wiper',
                  count: 10,
                  selectedValue: formData.switchWiperSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSwitchWiperSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Lampu Hazard',
                  count: 10,
                  selectedValue: formData.lampuHazardSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateLampuHazardSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Panel Dashboard',
                  count: 10,
                  selectedValue: formData.panelDashboardSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePanelDashboardSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Pembuka Kap Mesin',
                  count: 10,
                  selectedValue: formData.pembukaKapMesinSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePembukaKapMesinSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Pembuka Bagasi',
                  count: 10,
                  selectedValue: formData.pembukaBagasiSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePembukaBagasiSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Jok Depan',
                  count: 10,
                  selectedValue: formData.jokDepanSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateJokDepanSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Aroma Interior',
                  count: 10,
                  selectedValue: formData.aromaInteriorSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateAromaInteriorSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Handle Pintu',
                  count: 10,
                  selectedValue: formData.handlePintuSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateHandlePintuSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Console Box',
                  count: 10,
                  selectedValue: formData.consoleBoxSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateConsoleBoxSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Spion Tengah',
                  count: 10,
                  selectedValue: formData.spionTengahSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSpionTengahSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Tuas Persneling',
                  count: 10,
                  selectedValue: formData.tuasPersnelingSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTuasPersnelingSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Jok Belakang',
                  count: 10,
                  selectedValue: formData.jokBelakangSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateJokBelakangSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Panel Indikator',
                  count: 10,
                  selectedValue: formData.panelIndikatorSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePanelIndikatorSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Switch Lampu',
                  count: 10,
                  selectedValue: formData.switchLampuSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSwitchLampuSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Karpet Dasar',
                  count: 10,
                  selectedValue: formData.karpetDasarSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKarpetDasarSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Klakson',
                  count: 10,
                  selectedValue: formData.klaksonSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateKlaksonSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Sun Visor',
                  count: 10,
                  selectedValue: formData.sunVisorSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSunVisorSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Tuas Tangki Bensin',
                  count: 10,
                  selectedValue: formData.tuasTangkiBensinSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTuasTangkiBensinSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Sabuk Pengaman',
                  count: 10,
                  selectedValue: formData.sabukPengamanSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSabukPengamanSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Trim Interior',
                  count: 10,
                  selectedValue: formData.trimInteriorSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTrimInteriorSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Plafon',
                  count: 10,
                  selectedValue: formData.plafonSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePlafonSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                      
                // ExpandableTextField
                ExpandableTextField(
                  label: 'Catatan',
                  hintText: 'Masukkan catatan di sini',
                  initialLines: formData.interiorCatatanList,
                  onChangedList: (lines) {
                    formNotifier.updateInteriorCatatanList(lines);
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
