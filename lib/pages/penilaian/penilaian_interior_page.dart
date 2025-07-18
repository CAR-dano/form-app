import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';


class PenilaianInteriorPage extends ConsumerStatefulWidget {
  const PenilaianInteriorPage({
    super.key,
  });

  @override
  ConsumerState<PenilaianInteriorPage> createState() => _PenilaianInteriorPage();
}

class _PenilaianInteriorPage extends ConsumerState<PenilaianInteriorPage> with AutomaticKeepAliveClientMixin { // Add mixin
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
          child: CustomScrollView(
            key: const PageStorageKey<String>('pageFiveThreeScrollKey'),
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(data: 'Penilaian (3)'),
                    SizedBox(height: 6.0),
                    HeadingOne(text: 'Hasil Inspeksi Interior'),
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
                      initialLines: formData.interiorCatatanList,
                      onChangedList: (lines) {
                        formNotifier.updateInteriorCatatanList(lines);
                      },
                    ),
                    const SizedBox(height: 32.0),
                    const SizedBox(height: 24.0), // Optional spacing below the content
                    // Footer
                    const Footer(),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom + 90),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildToggleableNumberedButtonLists(FormData formData, FormNotifier formNotifier) {
    final List<Map<String, dynamic>> toggleableNumberedButtonListData = [
      {
        'label': 'Stir',
        'selectedValue': formData.stirSelectedValue,
        'onItemSelected': (value) => formNotifier.updateStirSelectedValue(value),
      },
      {
        'label': 'Rem Tangan',
        'selectedValue': formData.remTanganSelectedValue,
        'onItemSelected': (value) => formNotifier.updateRemTanganSelectedValue(value),
      },
      {
        'label': 'Pedal',
        'selectedValue': formData.pedalSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePedalSelectedValue(value),
      },
      {
        'label': 'Switch Wiper',
        'selectedValue': formData.switchWiperSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSwitchWiperSelectedValue(value),
      },
      {
        'label': 'Lampu Hazard',
        'selectedValue': formData.lampuHazardSelectedValue,
        'onItemSelected': (value) => formNotifier.updateLampuHazardSelectedValue(value),
      },
      {
        'label': 'Panel Dashboard',
        'selectedValue': formData.panelDashboardSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePanelDashboardSelectedValue(value),
      },
      {
        'label': 'Pembuka Kap Mesin',
        'selectedValue': formData.pembukaKapMesinSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePembukaKapMesinSelectedValue(value),
      },
      {
        'label': 'Pembuka Bagasi',
        'selectedValue': formData.pembukaBagasiSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePembukaBagasiSelectedValue(value),
      },
      {
        'label': 'Jok Depan',
        'selectedValue': formData.jokDepanSelectedValue,
        'onItemSelected': (value) => formNotifier.updateJokDepanSelectedValue(value),
      },
      {
        'label': 'Aroma Interior',
        'selectedValue': formData.aromaInteriorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateAromaInteriorSelectedValue(value),
      },
      {
        'label': 'Handle Pintu',
        'selectedValue': formData.handlePintuSelectedValue,
        'onItemSelected': (value) => formNotifier.updateHandlePintuSelectedValue(value),
      },
      {
        'label': 'Console Box',
        'selectedValue': formData.consoleBoxSelectedValue,
        'onItemSelected': (value) => formNotifier.updateConsoleBoxSelectedValue(value),
      },
      {
        'label': 'Spion Tengah',
        'selectedValue': formData.spionTengahSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSpionTengahSelectedValue(value),
      },
      {
        'label': 'Tuas Persneling',
        'selectedValue': formData.tuasPersnelingSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTuasPersnelingSelectedValue(value),
      },
      {
        'label': 'Jok Belakang',
        'selectedValue': formData.jokBelakangSelectedValue,
        'onItemSelected': (value) => formNotifier.updateJokBelakangSelectedValue(value),
      },
      {
        'label': 'Panel Indikator',
        'selectedValue': formData.panelIndikatorSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePanelIndikatorSelectedValue(value),
      },
      {
        'label': 'Switch Lampu',
        'selectedValue': formData.switchLampuSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSwitchLampuSelectedValue(value),
      },
      {
        'label': 'Karpet Dasar',
        'selectedValue': formData.karpetDasarSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKarpetDasarSelectedValue(value),
      },
      {
        'label': 'Klakson',
        'selectedValue': formData.klaksonSelectedValue,
        'onItemSelected': (value) => formNotifier.updateKlaksonSelectedValue(value),
      },
      {
        'label': 'Sun Visor',
        'selectedValue': formData.sunVisorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSunVisorSelectedValue(value),
      },
      {
        'label': 'Tuas Tangki Bensin',
        'selectedValue': formData.tuasTangkiBensinSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTuasTangkiBensinSelectedValue(value),
      },
      {
        'label': 'Sabuk Pengaman',
        'selectedValue': formData.sabukPengamanSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSabukPengamanSelectedValue(value),
      },
      {
        'label': 'Trim Interior',
        'selectedValue': formData.trimInteriorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTrimInteriorSelectedValue(value),
      },
      {
        'label': 'Plafon',
        'selectedValue': formData.plafonSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePlafonSelectedValue(value),
      },
    ];

    return toggleableNumberedButtonListData;
  }
}
