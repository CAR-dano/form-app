import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_four.dart'; // Import PageFiveFour
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';


class PageFiveThree extends ConsumerStatefulWidget {
  const PageFiveThree({super.key});

  @override
  ConsumerState<PageFiveThree> createState() => _PageFiveThreeState();
}

class _PageFiveThreeState extends ConsumerState<PageFiveThree> {
  // State variables for ToggleableNumberedButtonList
  late int _stirSelectedIndex;
  late bool _stirIsEnabled;
  late int _remTonganSelectedIndex;
  late bool _remTonganIsEnabled;
  late int _pedalSelectedIndex;
  late bool _pedalIsEnabled;
  late int _switchWiperSelectedIndex;
  late bool _switchWiperIsEnabled;
  late int _lampuHazardSelectedIndex;
  late bool _lampuHazardIsEnabled;
  late int _panelDashboardSelectedIndex;
  late bool _panelDashboardIsEnabled;
  late int _pembukaKapMesinSelectedIndex;
  late bool _pembukaKapMesinIsEnabled;
  late int _pembukaBagasiSelectedIndex;
  late bool _pembukaBagasiIsEnabled;
  late int _jokDepanSelectedIndex;
  late bool _jokDepanIsEnabled;
  late int _aromaInteriorSelectedIndex;
  late bool _aromaInteriorIsEnabled;
  late int _handlePintuSelectedIndex;
  late bool _handlePintuIsEnabled;
  late int _consoleBoxSelectedIndex;
  late bool _consoleBoxIsEnabled;
  late int _spionTengahSelectedIndex;
  late bool _spionTengahIsEnabled;
  late int _tuasPersnelingSelectedIndex;
  late bool _tuasPersnelingIsEnabled;
  late int _jokBelakangSelectedIndex;
  late bool _jokBelakangIsEnabled;
  late int _panelIndikatorSelectedIndex;
  late bool _panelIndikatorIsEnabled;
  late int _switchLampuSelectedIndex;
  late bool _switchLampuIsEnabled;
  late int _karpetDasarSelectedIndex;
  late bool _karpetDasarIsEnabled;
  late int _klaksonSelectedIndex;
  late bool _klaksonIsEnabled;
  late int _sunVisorSelectedIndex;
  late bool _sunVisorIsEnabled;
  late int _tuasTangkiBensinSelectedIndex;
  late bool _tuasTangkiBensinIsEnabled;
  late int _sabukPengamanSelectedIndex;
  late bool _sabukPengamanIsEnabled;
  late int _trimInteriorSelectedIndex;
  late bool _trimInteriorIsEnabled;
  late int _plafonSelectedIndex;
  late bool _plafonIsEnabled;

  // State variable for ExpandableTextField
  late TextEditingController _interiorCatatanController;


  @override
  void initState() {
    super.initState();
    final formData = ref.read(formProvider);
    // Initialize state variables from formProvider
    _stirSelectedIndex = formData.stirSelectedIndex ?? 0;
    _stirIsEnabled = formData.stirIsEnabled ?? true;
    _remTonganSelectedIndex = formData.remTonganSelectedIndex ?? 0;
    _remTonganIsEnabled = formData.remTonganIsEnabled ?? true;
    _pedalSelectedIndex = formData.pedalSelectedIndex ?? 0;
    _pedalIsEnabled = formData.pedalIsEnabled ?? true;
    _switchWiperSelectedIndex = formData.switchWiperSelectedIndex ?? 0;
    _switchWiperIsEnabled = formData.switchWiperIsEnabled ?? true;
    _lampuHazardSelectedIndex = formData.lampuHazardSelectedIndex ?? 0;
    _lampuHazardIsEnabled = formData.lampuHazardIsEnabled ?? true;
    _panelDashboardSelectedIndex = formData.panelDashboardSelectedIndex ?? 0;
    _panelDashboardIsEnabled = formData.panelDashboardIsEnabled ?? true;
    _pembukaKapMesinSelectedIndex = formData.pembukaKapMesinSelectedIndex ?? 0;
    _pembukaKapMesinIsEnabled = formData.pembukaKapMesinIsEnabled ?? true;
    _pembukaBagasiSelectedIndex = formData.pembukaBagasiSelectedIndex ?? 0;
    _pembukaBagasiIsEnabled = formData.pembukaBagasiIsEnabled ?? true;
    _jokDepanSelectedIndex = formData.jokDepanSelectedIndex ?? 0;
    _jokDepanIsEnabled = formData.jokDepanIsEnabled ?? true;
    _aromaInteriorSelectedIndex = formData.aromaInteriorSelectedIndex ?? 0;
    _aromaInteriorIsEnabled = formData.aromaInteriorIsEnabled ?? true;
    _handlePintuSelectedIndex = formData.handlePintuSelectedIndex ?? 0;
    _handlePintuIsEnabled = formData.handlePintuIsEnabled ?? true;
    _consoleBoxSelectedIndex = formData.consoleBoxSelectedIndex ?? 0;
    _consoleBoxIsEnabled = formData.consoleBoxIsEnabled ?? true;
    _spionTengahSelectedIndex = formData.spionTengahSelectedIndex ?? 0;
    _spionTengahIsEnabled = formData.spionTengahIsEnabled ?? true;
    _tuasPersnelingSelectedIndex = formData.tuasPersnelingSelectedIndex ?? 0;
    _tuasPersnelingIsEnabled = formData.tuasPersnelingIsEnabled ?? true;
    _jokBelakangSelectedIndex = formData.jokBelakangSelectedIndex ?? 0;
    _jokBelakangIsEnabled = formData.jokBelakangIsEnabled ?? true;
    _panelIndikatorSelectedIndex = formData.panelIndikatorSelectedIndex ?? 0;
    _panelIndikatorIsEnabled = formData.panelIndikatorIsEnabled ?? true;
    _switchLampuSelectedIndex = formData.switchLampuSelectedIndex ?? 0;
    _switchLampuIsEnabled = formData.switchLampuIsEnabled ?? true;
    _karpetDasarSelectedIndex = formData.karpetDasarSelectedIndex ?? 0;
    _karpetDasarIsEnabled = formData.karpetDasarIsEnabled ?? true;
    _klaksonSelectedIndex = formData.klaksonSelectedIndex ?? 0;
    _klaksonIsEnabled = formData.klaksonIsEnabled ?? true;
    _sunVisorSelectedIndex = formData.sunVisorSelectedIndex ?? 0;
    _sunVisorIsEnabled = formData.sunVisorIsEnabled ?? true;
    _tuasTangkiBensinSelectedIndex = formData.tuasTangkiBensinSelectedIndex ?? 0;
    _tuasTangkiBensinIsEnabled = formData.tuasTangkiBensinIsEnabled ?? true;
    _sabukPengamanSelectedIndex = formData.sabukPengamanSelectedIndex ?? 0;
    _sabukPengamanIsEnabled = formData.sabukPengamanIsEnabled ?? true;
    _trimInteriorSelectedIndex = formData.trimInteriorSelectedIndex ?? 0;
    _trimInteriorIsEnabled = formData.trimInteriorIsEnabled ?? true;
    _plafonSelectedIndex = formData.plafonSelectedIndex ?? 0;
    _plafonIsEnabled = formData.plafonIsEnabled ?? true;

    _interiorCatatanController = TextEditingController(text: formData.interiorCatatan ?? '');
  }

  @override
  void dispose() {
    _interiorCatatanController.dispose();
    super.dispose();
  }

  // Callback methods for ToggleableNumberedButtonList
  void _onStirItemSelected(int index) {
    setState(() {
      _stirSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateStirSelectedIndex(index);
  }

  void _onStirEnabledChanged(bool enabled) {
    setState(() {
      _stirIsEnabled = enabled;
      if (!enabled) {
        _stirSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateStirIsEnabled(enabled);
    ref.read(formProvider.notifier).updateStirSelectedIndex(_stirSelectedIndex);
  }

  void _onRemTonganItemSelected(int index) {
    setState(() {
      _remTonganSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateRemTonganSelectedIndex(index);
  }

  void _onRemTonganEnabledChanged(bool enabled) {
    setState(() {
      _remTonganIsEnabled = enabled;
      if (!enabled) {
        _remTonganSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateRemTonganIsEnabled(enabled);
    ref.read(formProvider.notifier).updateRemTonganSelectedIndex(_remTonganSelectedIndex);
  }

  void _onPedalItemSelected(int index) {
    setState(() {
      _pedalSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePedalSelectedIndex(index);
  }

  void _onPedalEnabledChanged(bool enabled) {
    setState(() {
      _pedalIsEnabled = enabled;
      if (!enabled) {
        _pedalSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePedalIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePedalSelectedIndex(_pedalSelectedIndex);
  }

  void _onSwitchWiperItemSelected(int index) {
    setState(() {
      _switchWiperSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSwitchWiperSelectedIndex(index);
  }

  void _onSwitchWiperEnabledChanged(bool enabled) {
    setState(() {
      _switchWiperIsEnabled = enabled;
      if (!enabled) {
        _switchWiperSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateSwitchWiperIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSwitchWiperSelectedIndex(_switchWiperSelectedIndex);
  }

  void _onLampuHazardItemSelected(int index) {
    setState(() {
      _lampuHazardSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateLampuHazardSelectedIndex(index);
  }

  void _onLampuHazardEnabledChanged(bool enabled) {
    setState(() {
      _lampuHazardIsEnabled = enabled;
      if (!enabled) {
        _lampuHazardSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateLampuHazardIsEnabled(enabled);
    ref.read(formProvider.notifier).updateLampuHazardSelectedIndex(_lampuHazardSelectedIndex);
  }

  void _onPanelDashboardItemSelected(int index) {
    setState(() {
      _panelDashboardSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePanelDashboardSelectedIndex(index);
  }

  void _onPanelDashboardEnabledChanged(bool enabled) {
    setState(() {
      _panelDashboardIsEnabled = enabled;
      if (!enabled) {
        _panelDashboardSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePanelDashboardIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePanelDashboardSelectedIndex(_panelDashboardSelectedIndex);
  }

  void _onPembukaKapMesinItemSelected(int index) {
    setState(() {
      _pembukaKapMesinSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePembukaKapMesinSelectedIndex(index);
  }

  void _onPembukaKapMesinEnabledChanged(bool enabled) {
    setState(() {
      _pembukaKapMesinIsEnabled = enabled;
      if (!enabled) {
        _pembukaKapMesinSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePembukaKapMesinIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePembukaKapMesinSelectedIndex(_pembukaKapMesinSelectedIndex);
  }

  void _onPembukaBagasiItemSelected(int index) {
    setState(() {
      _pembukaBagasiSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePembukaBagasiSelectedIndex(index);
  }

  void _onPembukaBagasiEnabledChanged(bool enabled) {
    setState(() {
      _pembukaBagasiIsEnabled = enabled;
      if (!enabled) {
        _pembukaBagasiSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePembukaBagasiIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePembukaBagasiSelectedIndex(_pembukaBagasiSelectedIndex);
  }

  void _onJokDepanItemSelected(int index) {
    setState(() {
      _jokDepanSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateJokDepanSelectedIndex(index);
  }

  void _onJokDepanEnabledChanged(bool enabled) {
    setState(() {
      _jokDepanIsEnabled = enabled;
      if (!enabled) {
        _jokDepanSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateJokDepanIsEnabled(enabled);
    ref.read(formProvider.notifier).updateJokDepanSelectedIndex(_jokDepanSelectedIndex);
  }

  void _onAromaInteriorItemSelected(int index) {
    setState(() {
      _aromaInteriorSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateAromaInteriorSelectedIndex(index);
  }

  void _onAromaInteriorEnabledChanged(bool enabled) {
    setState(() {
      _aromaInteriorIsEnabled = enabled;
      if (!enabled) {
        _aromaInteriorSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateAromaInteriorIsEnabled(enabled);
    ref.read(formProvider.notifier).updateAromaInteriorSelectedIndex(_aromaInteriorSelectedIndex);
  }

  void _onHandlePintuItemSelected(int index) {
    setState(() {
      _handlePintuSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateHandlePintuSelectedIndex(index);
  }

  void _onHandlePintuEnabledChanged(bool enabled) {
    setState(() {
      _handlePintuIsEnabled = enabled;
      if (!enabled) {
        _handlePintuSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateHandlePintuIsEnabled(enabled);
    ref.read(formProvider.notifier).updateHandlePintuSelectedIndex(_handlePintuSelectedIndex);
  }

  void _onConsoleBoxItemSelected(int index) {
    setState(() {
      _consoleBoxSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateConsoleBoxSelectedIndex(index);
  }

  void _onConsoleBoxEnabledChanged(bool enabled) {
    setState(() {
      _consoleBoxIsEnabled = enabled;
      if (!enabled) {
        _consoleBoxSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateConsoleBoxIsEnabled(enabled);
    ref.read(formProvider.notifier).updateConsoleBoxSelectedIndex(_consoleBoxSelectedIndex);
  }

  void _onSpionTengahItemSelected(int index) {
    setState(() {
      _spionTengahSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSpionTengahSelectedIndex(index);
  }

  void _onSpionTengahEnabledChanged(bool enabled) {
    setState(() {
      _spionTengahIsEnabled = enabled;
      if (!enabled) {
        _spionTengahSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateSpionTengahIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSpionTengahSelectedIndex(_spionTengahSelectedIndex);
  }

  void _onTuasPersnelingItemSelected(int index) {
    setState(() {
      _tuasPersnelingSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateTuasPersnelingSelectedIndex(index);
  }

  void _onTuasPersnelingEnabledChanged(bool enabled) {
    setState(() {
      _tuasPersnelingIsEnabled = enabled;
      if (!enabled) {
        _tuasPersnelingSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateTuasPersnelingIsEnabled(enabled);
    ref.read(formProvider.notifier).updateTuasPersnelingSelectedIndex(_tuasPersnelingSelectedIndex);
  }

  void _onJokBelakangItemSelected(int index) {
    setState(() {
      _jokBelakangSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateJokBelakangSelectedIndex(index);
  }

  void _onJokBelakangEnabledChanged(bool enabled) {
    setState(() {
      _jokBelakangIsEnabled = enabled;
      if (!enabled) {
        _jokBelakangSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateJokBelakangIsEnabled(enabled);
    ref.read(formProvider.notifier).updateJokBelakangSelectedIndex(_jokBelakangSelectedIndex);
  }

  void _onPanelIndikatorItemSelected(int index) {
    setState(() {
      _panelIndikatorSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePanelIndikatorSelectedIndex(index);
  }

  void _onPanelIndikatorEnabledChanged(bool enabled) {
    setState(() {
      _panelIndikatorIsEnabled = enabled;
      if (!enabled) {
        _panelIndikatorSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePanelIndikatorIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePanelIndikatorSelectedIndex(_panelIndikatorSelectedIndex);
  }

  void _onSwitchLampuItemSelected(int index) {
    setState(() {
      _switchLampuSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSwitchLampuSelectedIndex(index);
  }

  void _onSwitchLampuEnabledChanged(bool enabled) {
    setState(() {
      _switchLampuIsEnabled = enabled;
      if (!enabled) {
        _switchLampuSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateSwitchLampuIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSwitchLampuSelectedIndex(_switchLampuSelectedIndex);
  }

  void _onKarpetDasarItemSelected(int index) {
    setState(() {
      _karpetDasarSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateKarpetDasarSelectedIndex(index);
  }

  void _onKarpetDasarEnabledChanged(bool enabled) {
    setState(() {
      _karpetDasarIsEnabled = enabled;
      if (!enabled) {
        _karpetDasarSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateKarpetDasarIsEnabled(enabled);
    ref.read(formProvider.notifier).updateKarpetDasarSelectedIndex(_karpetDasarSelectedIndex);
  }

  void _onKlaksonItemSelected(int index) {
    setState(() {
      _klaksonSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateKlaksonSelectedIndex(index);
  }

  void _onKlaksonEnabledChanged(bool enabled) {
    setState(() {
      _klaksonIsEnabled = enabled;
      if (!enabled) {
        _klaksonSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateKlaksonIsEnabled(enabled);
    ref.read(formProvider.notifier).updateKlaksonSelectedIndex(_klaksonSelectedIndex);
  }

  void _onSunVisorItemSelected(int index) {
    setState(() {
      _sunVisorSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSunVisorSelectedIndex(index);
  }

  void _onSunVisorEnabledChanged(bool enabled) {
    setState(() {
      _sunVisorIsEnabled = enabled;
      if (!enabled) {
        _sunVisorSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateSunVisorIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSunVisorSelectedIndex(_sunVisorSelectedIndex);
  }

  void _onTuasTangkiBensinItemSelected(int index) {
    setState(() {
      _tuasTangkiBensinSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateTuasTangkiBensinSelectedIndex(index);
  }

  void _onTuasTangkiBensinEnabledChanged(bool enabled) {
    setState(() {
      _tuasTangkiBensinIsEnabled = enabled;
      if (!enabled) {
        _tuasTangkiBensinSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateTuasTangkiBensinIsEnabled(enabled);
    ref.read(formProvider.notifier).updateTuasTangkiBensinSelectedIndex(_tuasTangkiBensinSelectedIndex);
  }

  void _onSabukPengamanItemSelected(int index) {
    setState(() {
      _sabukPengamanSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSabukPengamanSelectedIndex(index);
  }

  void _onSabukPengamanEnabledChanged(bool enabled) {
    setState(() {
      _sabukPengamanIsEnabled = enabled;
      if (!enabled) {
        _sabukPengamanSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateSabukPengamanIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSabukPengamanSelectedIndex(_sabukPengamanSelectedIndex);
  }

  void _onTrimInteriorItemSelected(int index) {
    setState(() {
      _trimInteriorSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateTrimInteriorSelectedIndex(index);
  }

  void _onTrimInteriorEnabledChanged(bool enabled) {
    setState(() {
      _trimInteriorIsEnabled = enabled;
      if (!enabled) {
        _trimInteriorSelectedIndex = 0;
      }
      });
    ref.read(formProvider.notifier).updateTrimInteriorIsEnabled(enabled);
    ref.read(formProvider.notifier).updateTrimInteriorSelectedIndex(_trimInteriorSelectedIndex);
  }

  void _onPlafonItemSelected(int index) {
    setState(() {
      _plafonSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePlafonSelectedIndex(index);
  }

  void _onPlafonEnabledChanged(bool enabled) {
    setState(() {
      _plafonIsEnabled = enabled;
      if (!enabled) {
        _plafonSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePlafonIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePlafonSelectedIndex(_plafonSelectedIndex);
  }

  // Callback method for ExpandableTextField
  void _onInteriorCatatanChanged(List<String> lines) {
    ref.read(formProvider.notifier).updateInteriorCatatan(lines.join('\n'));
  }


  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '5/9'),
                  const SizedBox(height: 8.0),
                  PageTitle(data: 'Penilaian (3)'),
                  const SizedBox(height: 24.0),
                  const HeadingOne(text: 'Hasil Inspeksi Interior'),
                  const SizedBox(height: 16.0),

                  // ToggleableNumberedButtonList widgets
                  ToggleableNumberedButtonList(
                    label: 'Stir',
                    count: 10,
                    selectedIndex: _stirSelectedIndex,
                    onItemSelected: _onStirItemSelected,
                    initialEnabled: _stirIsEnabled,
                    onEnabledChanged: _onStirEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Rem Tangan',
                    count: 10,
                    selectedIndex: _remTonganSelectedIndex,
                    onItemSelected: _onRemTonganItemSelected,
                    initialEnabled: _remTonganIsEnabled,
                    onEnabledChanged: _onRemTonganEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Pedal',
                    count: 10,
                    selectedIndex: _pedalSelectedIndex,
                    onItemSelected: _onPedalItemSelected,
                    initialEnabled: _pedalIsEnabled,
                    onEnabledChanged: _onPedalEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Switch Wiper',
                    count: 10,
                    selectedIndex: _switchWiperSelectedIndex,
                    onItemSelected: _onSwitchWiperItemSelected,
                    initialEnabled: _switchWiperIsEnabled,
                    onEnabledChanged: _onSwitchWiperEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Lampu Hazard',
                    count: 10,
                    selectedIndex: _lampuHazardSelectedIndex,
                    onItemSelected: _onLampuHazardItemSelected,
                    initialEnabled: _lampuHazardIsEnabled,
                    onEnabledChanged: _onLampuHazardEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Panel Dashboard',
                    count: 10,
                    selectedIndex: _panelDashboardSelectedIndex,
                    onItemSelected: _onPanelDashboardItemSelected,
                    initialEnabled: _panelDashboardIsEnabled,
                    onEnabledChanged: _onPanelDashboardEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Pembuka Kap Mesin',
                    count: 10,
                    selectedIndex: _pembukaKapMesinSelectedIndex,
                    onItemSelected: _onPembukaKapMesinItemSelected,
                    initialEnabled: _pembukaKapMesinIsEnabled,
                    onEnabledChanged: _onPembukaKapMesinEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Pembuka Bagasi',
                    count: 10,
                    selectedIndex: _pembukaBagasiSelectedIndex,
                    onItemSelected: _onPembukaBagasiItemSelected,
                    initialEnabled: _pembukaBagasiIsEnabled,
                    onEnabledChanged: _onPembukaBagasiEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Jok Depan',
                    count: 10,
                    selectedIndex: _jokDepanSelectedIndex,
                    onItemSelected: _onJokDepanItemSelected,
                    initialEnabled: _jokDepanIsEnabled,
                    onEnabledChanged: _onJokDepanEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Aroma Interior',
                    count: 10,
                    selectedIndex: _aromaInteriorSelectedIndex,
                    onItemSelected: _onAromaInteriorItemSelected,
                    initialEnabled: _aromaInteriorIsEnabled,
                    onEnabledChanged: _onAromaInteriorEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Handle Pintu',
                    count: 10,
                    selectedIndex: _handlePintuSelectedIndex,
                    onItemSelected: _onHandlePintuItemSelected,
                    initialEnabled: _handlePintuIsEnabled,
                    onEnabledChanged: _onHandlePintuEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Console Box',
                    count: 10,
                    selectedIndex: _consoleBoxSelectedIndex,
                    onItemSelected: _onConsoleBoxItemSelected,
                    initialEnabled: _consoleBoxIsEnabled,
                    onEnabledChanged: _onConsoleBoxEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Spion Tengah',
                    count: 10,
                    selectedIndex: _spionTengahSelectedIndex,
                    onItemSelected: _onSpionTengahItemSelected,
                    initialEnabled: _spionTengahIsEnabled,
                    onEnabledChanged: _onSpionTengahEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Tuas Persneling',
                    count: 10,
                    selectedIndex: _tuasPersnelingSelectedIndex,
                    onItemSelected: _onTuasPersnelingItemSelected,
                    initialEnabled: _tuasPersnelingIsEnabled,
                    onEnabledChanged: _onTuasPersnelingEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Jok Belakang',
                    count: 10,
                    selectedIndex: _jokBelakangSelectedIndex,
                    onItemSelected: _onJokBelakangItemSelected,
                    initialEnabled: _jokBelakangIsEnabled,
                    onEnabledChanged: _onJokBelakangEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Panel Indikator',
                    count: 10,
                    selectedIndex: _panelIndikatorSelectedIndex,
                    onItemSelected: _onPanelIndikatorItemSelected,
                    initialEnabled: _panelIndikatorIsEnabled,
                    onEnabledChanged: _onPanelIndikatorEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Switch Lampu',
                    count: 10,
                    selectedIndex: _switchLampuSelectedIndex,
                    onItemSelected: _onSwitchLampuItemSelected,
                    initialEnabled: _switchLampuIsEnabled,
                    onEnabledChanged: _onSwitchLampuEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Karpet Dasar',
                    count: 10,
                    selectedIndex: _karpetDasarSelectedIndex,
                    onItemSelected: _onKarpetDasarItemSelected,
                    initialEnabled: _karpetDasarIsEnabled,
                    onEnabledChanged: _onKarpetDasarEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Klakson',
                    count: 10,
                    selectedIndex: _klaksonSelectedIndex,
                    onItemSelected: _onKlaksonItemSelected,
                    initialEnabled: _klaksonIsEnabled,
                    onEnabledChanged: _onKlaksonEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Sun Visor',
                    count: 10,
                    selectedIndex: _sunVisorSelectedIndex,
                    onItemSelected: _onSunVisorItemSelected,
                    initialEnabled: _sunVisorIsEnabled,
                    onEnabledChanged: _onSunVisorEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Tuas Tangki Bensin',
                    count: 10,
                    selectedIndex: _tuasTangkiBensinSelectedIndex,
                    onItemSelected: _onTuasTangkiBensinItemSelected,
                    initialEnabled: _tuasTangkiBensinIsEnabled,
                    onEnabledChanged: _onTuasTangkiBensinEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Sabuk Pengaman',
                    count: 10,
                    selectedIndex: _sabukPengamanSelectedIndex,
                    onItemSelected: _onSabukPengamanItemSelected,
                    initialEnabled: _sabukPengamanIsEnabled,
                    onEnabledChanged: _onSabukPengamanEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Trim Interior',
                    count: 10,
                    selectedIndex: _trimInteriorSelectedIndex,
                    onItemSelected: _onTrimInteriorItemSelected,
                    initialEnabled: _trimInteriorIsEnabled,
                    onEnabledChanged: _onTrimInteriorEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Plafon',
                    count: 10,
                    selectedIndex: _plafonSelectedIndex,
                    onItemSelected: _onPlafonItemSelected,
                    initialEnabled: _plafonIsEnabled,
                    onEnabledChanged: _onPlafonEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),

                  // ExpandableTextField
                  ExpandableTextField(
                    label: 'Catatan',
                    hintText: 'Masukkan catatan di sini',
                    controller: _interiorCatatanController,
                    onChangedList: _onInteriorCatatanChanged,
                  ),
                  const SizedBox(height: 32.0),

                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageFiveFour()),
                      );
                    },
                  ),
                  const SizedBox(height: 32.0), // Optional spacing below the content
                  // Footer
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
