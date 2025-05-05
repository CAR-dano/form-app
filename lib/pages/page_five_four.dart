import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_five.dart'; // Import PageFiveFive
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';


class PageFiveFour extends ConsumerStatefulWidget {
  const PageFiveFour({super.key});

  @override
  ConsumerState<PageFiveFour> createState() => _PageFiveFourState();
}

class _PageFiveFourState extends ConsumerState<PageFiveFour> {
  // State variables for ToggleableNumberedButtonList
  late int _bumperDepanSelectedIndex;
  late bool _bumperDepanIsEnabled;
  late int _kapMesinSelectedIndex;
  late bool _kapMesinIsEnabled;
  late int _lampuUtamaSelectedIndex;
  late bool _lampuUtamaIsEnabled;
  late int _panelAtapSelectedIndex;
  late bool _panelAtapIsEnabled;
  late int _grillSelectedIndex;
  late bool _grillIsEnabled;
  late int _lampuFoglampSelectedIndex;
  late bool _lampuFoglampIsEnabled;
  late int _kacaBeningSelectedIndex;
  late bool _kacaBeningIsEnabled;
  late int _wiperBelakangSelectedIndex;
  late bool _wiperBelakangIsEnabled;
  late int _bumperBelakangSelectedIndex;
  late bool _bumperBelakangIsEnabled;
  late int _lampuBelakangSelectedIndex;
  late bool _lampuBelakangIsEnabled;
  late int _trunklidSelectedIndex;
  late bool _trunklidIsEnabled;
  late int _kacaDepanSelectedIndex;
  late bool _kacaDepanIsEnabled;
  late int _fenderKananSelectedIndex;
  late bool _fenderKananIsEnabled;
  late int _quarterPanelKananSelectedIndex;
  late bool _quarterPanelKananIsEnabled;
  late int _pintuBelakangKananSelectedIndex;
  late bool _pintuBelakangKananIsEnabled;
  late int _spionKananSelectedIndex;
  late bool _spionKananIsEnabled;
  late int _lisplangKananSelectedIndex;
  late bool _lisplangKananIsEnabled;
  late int _sideSkirtKananSelectedIndex;
  late bool _sideSkirtKananIsEnabled;
  late int _daunWiperSelectedIndex;
  late bool _daunWiperIsEnabled;
  late int _pintuBelakangSelectedIndex;
  late bool _pintuBelakangIsEnabled;
  late int _fenderKiriSelectedIndex;
  late bool _fenderKiriIsEnabled;
  late int _quarterPanelKiriSelectedIndex;
  late bool _quarterPanelKiriIsEnabled;
  late int _pintuDepanSelectedIndex;
  late bool _pintuDepanIsEnabled;
  late int _kacaJendelaKananSelectedIndex;
  late bool _kacaJendelaKananIsEnabled;
  late int _pintuBelakangKiriSelectedIndex;
  late bool _pintuBelakangKiriIsEnabled;
  late int _spionKiriSelectedIndex;
  late bool _spionKiriIsEnabled;
  late int _pintuDepanKiriSelectedIndex;
  late bool _pintuDepanKiriIsEnabled;
  late int _kacaJendelaKiriSelectedIndex;
  late bool _kacaJendelaKiriIsEnabled;
  late int _lisplangKiriSelectedIndex;
  late bool _lisplangKiriIsEnabled;
  late int _sideSkirtKiriSelectedIndex;
  late bool _sideSkirtKiriIsEnabled;

  // State variable for ExpandableTextField
  late TextEditingController _eksteriorCatatanController;


  @override
  void initState() {
    super.initState();
    final formData = ref.read(formProvider);
    // Initialize state variables from formProvider
    _bumperDepanSelectedIndex = formData.bumperDepanSelectedIndex ?? 0;
    _bumperDepanIsEnabled = formData.bumperDepanIsEnabled ?? true;
    _kapMesinSelectedIndex = formData.kapMesinSelectedIndex ?? 0;
    _kapMesinIsEnabled = formData.kapMesinIsEnabled ?? true;
    _lampuUtamaSelectedIndex = formData.lampuUtamaSelectedIndex ?? 0;
    _lampuUtamaIsEnabled = formData.lampuUtamaIsEnabled ?? true;
    _panelAtapSelectedIndex = formData.panelAtapSelectedIndex ?? 0;
    _panelAtapIsEnabled = formData.panelAtapIsEnabled ?? true;
    _grillSelectedIndex = formData.grillSelectedIndex ?? 0;
    _grillIsEnabled = formData.grillIsEnabled ?? true;
    _lampuFoglampSelectedIndex = formData.lampuFoglampSelectedIndex ?? 0;
    _lampuFoglampIsEnabled = formData.lampuFoglampIsEnabled ?? true;
    _kacaBeningSelectedIndex = formData.kacaBeningSelectedIndex ?? 0;
    _kacaBeningIsEnabled = formData.kacaBeningIsEnabled ?? true;
    _wiperBelakangSelectedIndex = formData.wiperBelakangSelectedIndex ?? 0;
    _wiperBelakangIsEnabled = formData.wiperBelakangIsEnabled ?? true;
    _bumperBelakangSelectedIndex = formData.bumperBelakangSelectedIndex ?? 0;
    _bumperBelakangIsEnabled = formData.bumperBelakangIsEnabled ?? true;
    _lampuBelakangSelectedIndex = formData.lampuBelakangSelectedIndex ?? 0;
    _lampuBelakangIsEnabled = formData.lampuBelakangIsEnabled ?? true;
    _trunklidSelectedIndex = formData.trunklidSelectedIndex ?? 0;
    _trunklidIsEnabled = formData.trunklidIsEnabled ?? true;
    _kacaDepanSelectedIndex = formData.kacaDepanSelectedIndex ?? 0;
    _kacaDepanIsEnabled = formData.kacaDepanIsEnabled ?? true;
    _fenderKananSelectedIndex = formData.fenderKananSelectedIndex ?? 0;
    _fenderKananIsEnabled = formData.fenderKananIsEnabled ?? true;
    _quarterPanelKananSelectedIndex = formData.quarterPanelKananSelectedIndex ?? 0;
    _quarterPanelKananIsEnabled = formData.quarterPanelKananIsEnabled ?? true;
    _pintuBelakangKananSelectedIndex = formData.pintuBelakangKananSelectedIndex ?? 0;
    _pintuBelakangKananIsEnabled = formData.pintuBelakangKananIsEnabled ?? true;
    _spionKananSelectedIndex = formData.spionKananSelectedIndex ?? 0;
    _spionKananIsEnabled = formData.spionKananIsEnabled ?? true;
    _lisplangKananSelectedIndex = formData.lisplangKananSelectedIndex ?? 0;
    _lisplangKananIsEnabled = formData.lisplangKananIsEnabled ?? true;
    _sideSkirtKananSelectedIndex = formData.sideSkirtKananSelectedIndex ?? 0;
    _sideSkirtKananIsEnabled = formData.sideSkirtKananIsEnabled ?? true;
    _daunWiperSelectedIndex = formData.daunWiperSelectedIndex ?? 0;
    _daunWiperIsEnabled = formData.daunWiperIsEnabled ?? true;
    _pintuBelakangSelectedIndex = formData.pintuBelakangSelectedIndex ?? 0;
    _pintuBelakangIsEnabled = formData.pintuBelakangIsEnabled ?? true;
    _fenderKiriSelectedIndex = formData.fenderKiriSelectedIndex ?? 0;
    _fenderKiriIsEnabled = formData.fenderKiriIsEnabled ?? true;
    _quarterPanelKiriSelectedIndex = formData.quarterPanelKiriSelectedIndex ?? 0;
    _quarterPanelKiriIsEnabled = formData.quarterPanelKiriIsEnabled ?? true;
    _pintuDepanSelectedIndex = formData.pintuDepanSelectedIndex ?? 0;
    _pintuDepanIsEnabled = formData.pintuDepanIsEnabled ?? true;
    _kacaJendelaKananSelectedIndex = formData.kacaJendelaKananSelectedIndex ?? 0;
    _kacaJendelaKananIsEnabled = formData.kacaJendelaKananIsEnabled ?? true;
    _pintuBelakangKiriSelectedIndex = formData.pintuBelakangKiriSelectedIndex ?? 0;
    _pintuBelakangKiriIsEnabled = formData.pintuBelakangKiriIsEnabled ?? true;
    _spionKiriSelectedIndex = formData.spionKiriSelectedIndex ?? 0;
    _spionKiriIsEnabled = formData.spionKiriIsEnabled ?? true;
    _pintuDepanKiriSelectedIndex = formData.pintuDepanKiriSelectedIndex ?? 0;
    _pintuDepanKiriIsEnabled = formData.pintuDepanKiriIsEnabled ?? true;
    _kacaJendelaKiriSelectedIndex = formData.kacaJendelaKiriSelectedIndex ?? 0;
    _kacaJendelaKiriIsEnabled = formData.kacaJendelaKiriIsEnabled ?? true;
    _lisplangKiriSelectedIndex = formData.lisplangKiriSelectedIndex ?? 0;
    _lisplangKiriIsEnabled = formData.lisplangKiriIsEnabled ?? true;
    _sideSkirtKiriSelectedIndex = formData.sideSkirtKiriSelectedIndex ?? 0;
    _sideSkirtKiriIsEnabled = formData.sideSkirtKiriIsEnabled ?? true;

    _eksteriorCatatanController = TextEditingController(text: formData.eksteriorCatatan ?? '');
  }

  @override
  void dispose() {
    _eksteriorCatatanController.dispose();
    super.dispose();
  }

  // Callback methods for ToggleableNumberedButtonList
  void _onBumperDepanItemSelected(int index) {
    setState(() {
      _bumperDepanSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateBumperDepanSelectedIndex(index);
  }

  void _onBumperDepanEnabledChanged(bool enabled) {
    setState(() {
      _bumperDepanIsEnabled = enabled;
      if (!enabled) {
        _bumperDepanSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateBumperDepanIsEnabled(enabled);
    ref.read(formProvider.notifier).updateBumperDepanSelectedIndex(_bumperDepanSelectedIndex);
  }

  void _onKapMesinItemSelected(int index) {
    setState(() {
      _kapMesinSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateKapMesinSelectedIndex(index);
  }

  void _onKapMesinEnabledChanged(bool enabled) {
    setState(() {
      _kapMesinIsEnabled = enabled;
      if (!enabled) {
        _kapMesinSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateKapMesinIsEnabled(enabled);
    ref.read(formProvider.notifier).updateKapMesinSelectedIndex(_kapMesinSelectedIndex);
  }

  void _onLampuUtamaItemSelected(int index) {
    setState(() {
      _lampuUtamaSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateLampuUtamaSelectedIndex(index);
  }

  void _onLampuUtamaEnabledChanged(bool enabled) {
    setState(() {
      _lampuUtamaIsEnabled = enabled;
      if (!enabled) {
        _lampuUtamaSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateLampuUtamaIsEnabled(enabled);
    ref.read(formProvider.notifier).updateLampuUtamaSelectedIndex(_lampuUtamaSelectedIndex);
  }

  void _onPanelAtapItemSelected(int index) {
    setState(() {
      _panelAtapSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePanelAtapSelectedIndex(index);
  }

  void _onPanelAtapEnabledChanged(bool enabled) {
    setState(() {
      _panelAtapIsEnabled = enabled;
      if (!enabled) {
        _panelAtapSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePanelAtapIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePanelAtapSelectedIndex(_panelAtapSelectedIndex);
  }

  void _onGrillItemSelected(int index) {
    setState(() {
      _grillSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateGrillSelectedIndex(index);
  }

  void _onGrillEnabledChanged(bool enabled) {
    setState(() {
      _grillIsEnabled = enabled;
      if (!enabled) {
        _grillSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateGrillIsEnabled(enabled);
    ref.read(formProvider.notifier).updateGrillSelectedIndex(_grillSelectedIndex);
  }

  void _onLampuFoglampItemSelected(int index) {
    setState(() {
      _lampuFoglampSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateLampuFoglampSelectedIndex(index);
  }

  void _onLampuFoglampEnabledChanged(bool enabled) {
    setState(() {
      _lampuFoglampIsEnabled = enabled;
      if (!enabled) {
        _lampuFoglampSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateLampuFoglampIsEnabled(enabled);
    ref.read(formProvider.notifier).updateLampuFoglampSelectedIndex(_lampuFoglampSelectedIndex);
  }

  void _onKacaBeningItemSelected(int index) {
    setState(() {
      _kacaBeningSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateKacaBeningSelectedIndex(index);
  }

  void _onKacaBeningEnabledChanged(bool enabled) {
    setState(() {
      _kacaBeningIsEnabled = enabled;
      if (!enabled) {
        _kacaBeningSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateKacaBeningIsEnabled(enabled);
    ref.read(formProvider.notifier).updateKacaBeningSelectedIndex(_kacaBeningSelectedIndex);
  }

  void _onWiperBelakangItemSelected(int index) {
    setState(() {
      _wiperBelakangSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateWiperBelakangSelectedIndex(index);
  }

  void _onWiperBelakangEnabledChanged(bool enabled) {
    setState(() {
      _wiperBelakangIsEnabled = enabled;
      if (!enabled) {
        _wiperBelakangSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateWiperBelakangIsEnabled(enabled);
    ref.read(formProvider.notifier).updateWiperBelakangSelectedIndex(_wiperBelakangSelectedIndex);
  }

  void _onBumperBelakangItemSelected(int index) {
    setState(() {
      _bumperBelakangSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateBumperBelakangSelectedIndex(index);
  }

  void _onBumperBelakangEnabledChanged(bool enabled) {
    setState(() {
      _bumperBelakangIsEnabled = enabled;
      if (!enabled) {
        _bumperBelakangSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateBumperBelakangIsEnabled(enabled);
    ref.read(formProvider.notifier).updateBumperBelakangSelectedIndex(_bumperBelakangSelectedIndex);
  }

  void _onLampuBelakangItemSelected(int index) {
    setState(() {
      _lampuBelakangSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateLampuBelakangSelectedIndex(index);
  }

  void _onLampuBelakangEnabledChanged(bool enabled) {
    setState(() {
      _lampuBelakangIsEnabled = enabled;
      if (!enabled) {
        _lampuBelakangSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateLampuBelakangIsEnabled(enabled);
    ref.read(formProvider.notifier).updateLampuBelakangSelectedIndex(_lampuBelakangSelectedIndex);
  }

  void _onTrunklidItemSelected(int index) {
    setState(() {
      _trunklidSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateTrunklidSelectedIndex(index);
  }

  void _onTrunklidEnabledChanged(bool enabled) {
    setState(() {
      _trunklidIsEnabled = enabled;
      if (!enabled) {
        _trunklidSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateTrunklidIsEnabled(enabled);
    ref.read(formProvider.notifier).updateTrunklidSelectedIndex(_trunklidSelectedIndex);
  }

  void _onKacaDepanItemSelected(int index) {
    setState(() {
      _kacaDepanSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateKacaDepanSelectedIndex(index);
  }

  void _onKacaDepanEnabledChanged(bool enabled) {
    setState(() {
      _kacaDepanIsEnabled = enabled;
      if (!enabled) {
        _kacaDepanSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateKacaDepanIsEnabled(enabled);
    ref.read(formProvider.notifier).updateKacaDepanSelectedIndex(_kacaDepanSelectedIndex);
  }

  void _onFenderKananItemSelected(int index) {
    setState(() {
      _fenderKananSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateFenderKananSelectedIndex(index);
  }

  void _onFenderKananEnabledChanged(bool enabled) {
    setState(() {
      _fenderKananIsEnabled = enabled;
      if (!enabled) {
        _fenderKananSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateFenderKananIsEnabled(enabled);
    ref.read(formProvider.notifier).updateFenderKananSelectedIndex(_fenderKananSelectedIndex);
  }

  void _onQuarterPanelKananItemSelected(int index) {
    setState(() {
      _quarterPanelKananSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateQuarterPanelKananSelectedIndex(index);
  }

  void _onQuarterPanelKananEnabledChanged(bool enabled) {
    setState(() {
      _quarterPanelKananIsEnabled = enabled;
      if (!enabled) {
        _quarterPanelKananSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateQuarterPanelKananIsEnabled(enabled);
    ref.read(formProvider.notifier).updateQuarterPanelKananSelectedIndex(_quarterPanelKananSelectedIndex);
  }

  void _onPintuBelakangKananItemSelected(int index) {
    setState(() {
      _pintuBelakangKananSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePintuBelakangKananSelectedIndex(index);
  }

  void _onPintuBelakangKananEnabledChanged(bool enabled) {
    setState(() {
      _pintuBelakangKananIsEnabled = enabled;
      if (!enabled) {
        _pintuBelakangKananSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePintuBelakangKananIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePintuBelakangKananSelectedIndex(_pintuBelakangKananSelectedIndex);
  }

  void _onSpionKananItemSelected(int index) {
    setState(() {
      _spionKananSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSpionKananSelectedIndex(index);
  }

  void _onSpionKananEnabledChanged(bool enabled) {
    setState(() {
      _spionKananIsEnabled = enabled;
      if (!enabled) {
        _spionKananSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateSpionKananIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSpionKananSelectedIndex(_spionKananSelectedIndex);
  }

  void _onLisplangKananItemSelected(int index) {
    setState(() {
      _lisplangKananSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateLisplangKananSelectedIndex(index);
  }

  void _onLisplangKananEnabledChanged(bool enabled) {
    setState(() {
      _lisplangKananIsEnabled = enabled;
      if (!enabled) {
        _lisplangKananSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateLisplangKananIsEnabled(enabled);
    ref.read(formProvider.notifier).updateLisplangKananSelectedIndex(_lisplangKananSelectedIndex);
  }

  void _onSideSkirtKananItemSelected(int index) {
    setState(() {
      _sideSkirtKananSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSideSkirtKananSelectedIndex(index);
  }

  void _onSideSkirtKananEnabledChanged(bool enabled) {
    setState(() {
      _sideSkirtKananIsEnabled = enabled;
      if (!enabled) {
        _sideSkirtKananSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateSideSkirtKananIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSideSkirtKananSelectedIndex(_sideSkirtKananSelectedIndex);
  }

  void _onDaunWiperItemSelected(int index) {
    setState(() {
      _daunWiperSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateDaunWiperSelectedIndex(index);
  }

  void _onDaunWiperEnabledChanged(bool enabled) {
    setState(() {
      _daunWiperIsEnabled = enabled;
      if (!enabled) {
        _daunWiperSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateDaunWiperIsEnabled(enabled);
    ref.read(formProvider.notifier).updateDaunWiperSelectedIndex(_daunWiperSelectedIndex);
  }

  void _onPintuBelakangItemSelected(int index) {
    setState(() {
      _pintuBelakangSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePintuBelakangSelectedIndex(index);
  }

  void _onPintuBelakangEnabledChanged(bool enabled) {
    setState(() {
      _pintuBelakangIsEnabled = enabled;
      if (!enabled) {
        _pintuBelakangSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePintuBelakangIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePintuBelakangSelectedIndex(_pintuBelakangSelectedIndex);
  }

  void _onFenderKiriItemSelected(int index) {
    setState(() {
      _fenderKiriSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateFenderKiriSelectedIndex(index);
  }

  void _onFenderKiriEnabledChanged(bool enabled) {
    setState(() {
      _fenderKiriIsEnabled = enabled;
      if (!enabled) {
        _fenderKiriSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateFenderKiriIsEnabled(enabled);
    ref.read(formProvider.notifier).updateFenderKiriSelectedIndex(_fenderKiriSelectedIndex);
  }

  void _onQuarterPanelKiriItemSelected(int index) {
    setState(() {
      _quarterPanelKiriSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateQuarterPanelKiriSelectedIndex(index);
  }

  void _onQuarterPanelKiriEnabledChanged(bool enabled) {
    setState(() {
      _quarterPanelKiriIsEnabled = enabled;
      if (!enabled) {
        _quarterPanelKiriSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateQuarterPanelKiriIsEnabled(enabled);
    ref.read(formProvider.notifier).updateQuarterPanelKiriSelectedIndex(_quarterPanelKiriSelectedIndex);
  }

  void _onPintuDepanItemSelected(int index) {
    setState(() {
      _pintuDepanSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePintuDepanSelectedIndex(index);
  }

  void _onPintuDepanEnabledChanged(bool enabled) {
    setState(() {
      _pintuDepanIsEnabled = enabled;
      if (!enabled) {
        _pintuDepanSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePintuDepanIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePintuDepanSelectedIndex(_pintuDepanSelectedIndex);
  }

  void _onKacaJendelaKananItemSelected(int index) {
    setState(() {
      _kacaJendelaKananSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateKacaJendelaKananSelectedIndex(index);
  }

  void _onKacaJendelaKananEnabledChanged(bool enabled) {
    setState(() {
      _kacaJendelaKananIsEnabled = enabled;
      if (!enabled) {
        _kacaJendelaKananSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateKacaJendelaKananIsEnabled(enabled);
    ref.read(formProvider.notifier).updateKacaJendelaKananSelectedIndex(_kacaJendelaKananSelectedIndex);
  }

  void _onPintuBelakangKiriItemSelected(int index) {
    setState(() {
      _pintuBelakangKiriSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePintuBelakangKiriSelectedIndex(index);
  }

  void _onPintuBelakangKiriEnabledChanged(bool enabled) {
    setState(() {
      _pintuBelakangKiriIsEnabled = enabled;
      if (!enabled) {
        _pintuBelakangKiriSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePintuBelakangKiriIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePintuBelakangKiriSelectedIndex(_pintuBelakangKiriSelectedIndex);
  }

  void _onSpionKiriItemSelected(int index) {
    setState(() {
      _spionKiriSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSpionKiriSelectedIndex(index);
  }

  void _onSpionKiriEnabledChanged(bool enabled) {
    setState(() {
      _spionKiriIsEnabled = enabled;
      if (!enabled) {
        _spionKiriSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateSpionKiriIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSpionKiriSelectedIndex(_spionKiriSelectedIndex);
  }

  void _onPintuDepanKiriItemSelected(int index) {
    setState(() {
      _pintuDepanKiriSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePintuDepanKiriSelectedIndex(index);
  }

  void _onPintuDepanKiriEnabledChanged(bool enabled) {
    setState(() {
      _pintuDepanKiriIsEnabled = enabled;
      if (!enabled) {
        _pintuDepanKiriSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updatePintuDepanKiriIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePintuDepanKiriSelectedIndex(_pintuDepanKiriSelectedIndex);
  }

  void _onKacaJendelaKiriItemSelected(int index) {
    setState(() {
      _kacaJendelaKiriSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateKacaJendelaKiriSelectedIndex(index);
  }

  void _onKacaJendelaKiriEnabledChanged(bool enabled) {
    setState(() {
      _kacaJendelaKiriIsEnabled = enabled;
      if (!enabled) {
        _kacaJendelaKiriSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateKacaJendelaKiriIsEnabled(enabled);
    ref.read(formProvider.notifier).updateKacaJendelaKiriSelectedIndex(_kacaJendelaKiriSelectedIndex);
  }

  void _onLisplangKiriItemSelected(int index) {
    setState(() {
      _lisplangKiriSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateLisplangKiriSelectedIndex(index);
  }

  void _onLisplangKiriEnabledChanged(bool enabled) {
    setState(() {
      _lisplangKiriIsEnabled = enabled;
      if (!enabled) {
        _lisplangKiriSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateLisplangKiriIsEnabled(enabled);
    ref.read(formProvider.notifier).updateLisplangKiriSelectedIndex(_lisplangKiriSelectedIndex);
  }

  void _onSideSkirtKiriItemSelected(int index) {
    setState(() {
      _sideSkirtKiriSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSideSkirtKiriSelectedIndex(index);
  }

  void _onSideSkirtKiriEnabledChanged(bool enabled) {
    setState(() {
      _sideSkirtKiriIsEnabled = enabled;
      if (!enabled) {
        _sideSkirtKiriSelectedIndex = 0;
      }
    });
    ref.read(formProvider.notifier).updateSideSkirtKiriIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSideSkirtKiriSelectedIndex(_sideSkirtKiriSelectedIndex);
  }

  // Callback method for ExpandableTextField
  void _onEksteriorCatatanChanged(List<String> lines) {
    ref.read(formProvider.notifier).updateEksteriorCatatan(lines.join('\n'));
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
                  PageTitle(data: 'Penilaian (4)'),
                  const SizedBox(height: 24.0),
                  const HeadingOne(text: 'Hasil Inspeksi Eksterior'),
                  const SizedBox(height: 16.0),

                  // ToggleableNumberedButtonList widgets
                  ToggleableNumberedButtonList(
                    label: 'Bumper Depan',
                    count: 10,
                    selectedIndex: _bumperDepanSelectedIndex,
                    onItemSelected: _onBumperDepanItemSelected,
                    initialEnabled: _bumperDepanIsEnabled,
                    onEnabledChanged: _onBumperDepanEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Kap Mesin',
                    count: 10,
                    selectedIndex: _kapMesinSelectedIndex,
                    onItemSelected: _onKapMesinItemSelected,
                    initialEnabled: _kapMesinIsEnabled,
                    onEnabledChanged: _onKapMesinEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Lampu Utama',
                    count: 10,
                    selectedIndex: _lampuUtamaSelectedIndex,
                    onItemSelected: _onLampuUtamaItemSelected,
                    initialEnabled: _lampuUtamaIsEnabled,
                    onEnabledChanged: _onLampuUtamaEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Panel Atap',
                    count: 10,
                    selectedIndex: _panelAtapSelectedIndex,
                    onItemSelected: _onPanelAtapItemSelected,
                    initialEnabled: _panelAtapIsEnabled,
                    onEnabledChanged: _onPanelAtapEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Grill',
                    count: 10,
                    selectedIndex: _grillSelectedIndex,
                    onItemSelected: _onGrillItemSelected,
                    initialEnabled: _grillIsEnabled,
                    onEnabledChanged: _onGrillEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Lampu Foglamp',
                    count: 10,
                    selectedIndex: _lampuFoglampSelectedIndex,
                    onItemSelected: _onLampuFoglampItemSelected,
                    initialEnabled: _lampuFoglampIsEnabled,
                    onEnabledChanged: _onLampuFoglampEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Kaca Bening',
                    count: 10,
                    selectedIndex: _kacaBeningSelectedIndex,
                    onItemSelected: _onKacaBeningItemSelected,
                    initialEnabled: _kacaBeningIsEnabled,
                    onEnabledChanged: _onKacaBeningEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Wiper Belakang',
                    count: 10,
                    selectedIndex: _wiperBelakangSelectedIndex,
                    onItemSelected: _onWiperBelakangItemSelected,
                    initialEnabled: _wiperBelakangIsEnabled,
                    onEnabledChanged: _onWiperBelakangEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Bumper Belakang',
                    count: 10,
                    selectedIndex: _bumperBelakangSelectedIndex,
                    onItemSelected: _onBumperBelakangItemSelected,
                    initialEnabled: _bumperBelakangIsEnabled,
                    onEnabledChanged: _onBumperBelakangEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Lampu Belakang',
                    count: 10,
                    selectedIndex: _lampuBelakangSelectedIndex,
                    onItemSelected: _onLampuBelakangItemSelected,
                    initialEnabled: _lampuBelakangIsEnabled,
                    onEnabledChanged: _onLampuBelakangEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Trunklid',
                    count: 10,
                    selectedIndex: _trunklidSelectedIndex,
                    onItemSelected: _onTrunklidItemSelected,
                    initialEnabled: _trunklidIsEnabled,
                    onEnabledChanged: _onTrunklidEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Kaca Depan',
                    count: 10,
                    selectedIndex: _kacaDepanSelectedIndex,
                    onItemSelected: _onKacaDepanItemSelected,
                    initialEnabled: _kacaDepanIsEnabled,
                    onEnabledChanged: _onKacaDepanEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Fender Kanan',
                    count: 10,
                    selectedIndex: _fenderKananSelectedIndex,
                    onItemSelected: _onFenderKananItemSelected,
                    initialEnabled: _fenderKananIsEnabled,
                    onEnabledChanged: _onFenderKananEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Quarter Panel Kanan',
                    count: 10,
                    selectedIndex: _quarterPanelKananSelectedIndex,
                    onItemSelected: _onQuarterPanelKananItemSelected,
                    initialEnabled: _quarterPanelKananIsEnabled,
                    onEnabledChanged: _onQuarterPanelKananEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Pintu Belakang Kanan',
                    count: 10,
                    selectedIndex: _pintuBelakangKananSelectedIndex,
                    onItemSelected: _onPintuBelakangKananItemSelected,
                    initialEnabled: _pintuBelakangKananIsEnabled,
                    onEnabledChanged: _onPintuBelakangKananEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Spion Kanan',
                    count: 10,
                    selectedIndex: _spionKananSelectedIndex,
                    onItemSelected: _onSpionKananItemSelected,
                    initialEnabled: _spionKananIsEnabled,
                    onEnabledChanged: _onSpionKananEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Lisplang Kanan',
                    count: 10,
                    selectedIndex: _lisplangKananSelectedIndex,
                    onItemSelected: _onLisplangKananItemSelected,
                    initialEnabled: _lisplangKananIsEnabled,
                    onEnabledChanged: _onLisplangKananEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Side Skirt Kanan',
                    count: 10,
                    selectedIndex: _sideSkirtKananSelectedIndex,
                    onItemSelected: _onSideSkirtKananItemSelected,
                    initialEnabled: _sideSkirtKananIsEnabled,
                    onEnabledChanged: _onSideSkirtKananEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Daun Wiper',
                    count: 10,
                    selectedIndex: _daunWiperSelectedIndex,
                    onItemSelected: _onDaunWiperItemSelected,
                    initialEnabled: _daunWiperIsEnabled,
                    onEnabledChanged: _onDaunWiperEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Pintu Belakang',
                    count: 10,
                    selectedIndex: _pintuBelakangSelectedIndex,
                    onItemSelected: _onPintuBelakangItemSelected,
                    initialEnabled: _pintuBelakangIsEnabled,
                    onEnabledChanged: _onPintuBelakangEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Fender Kiri',
                    count: 10,
                    selectedIndex: _fenderKiriSelectedIndex,
                    onItemSelected: _onFenderKiriItemSelected,
                    initialEnabled: _fenderKiriIsEnabled,
                    onEnabledChanged: _onFenderKiriEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Quarter Panel Kiri',
                    count: 10,
                    selectedIndex: _quarterPanelKiriSelectedIndex,
                    onItemSelected: _onQuarterPanelKiriItemSelected,
                    initialEnabled: _quarterPanelKiriIsEnabled,
                    onEnabledChanged: _onQuarterPanelKiriEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Pintu Depan',
                    count: 10,
                    selectedIndex: _pintuDepanSelectedIndex,
                    onItemSelected: _onPintuDepanItemSelected,
                    initialEnabled: _pintuDepanIsEnabled,
                    onEnabledChanged: _onPintuDepanEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Kaca Jendela Kanan',
                    count: 10,
                    selectedIndex: _kacaJendelaKananSelectedIndex,
                    onItemSelected: _onKacaJendelaKananItemSelected,
                    initialEnabled: _kacaJendelaKananIsEnabled,
                    onEnabledChanged: _onKacaJendelaKananEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Pintu Belakang Kiri',
                    count: 10,
                    selectedIndex: _pintuBelakangKiriSelectedIndex,
                    onItemSelected: _onPintuBelakangKiriItemSelected,
                    initialEnabled: _pintuBelakangKiriIsEnabled,
                    onEnabledChanged: _onPintuBelakangKiriEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Spion Kiri',
                    count: 10,
                    selectedIndex: _spionKiriSelectedIndex,
                    onItemSelected: _onSpionKiriItemSelected,
                    initialEnabled: _spionKiriIsEnabled,
                    onEnabledChanged: _onSpionKiriEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Pintu Depan Kiri',
                    count: 10,
                    selectedIndex: _pintuDepanKiriSelectedIndex,
                    onItemSelected: _onPintuDepanKiriItemSelected,
                    initialEnabled: _pintuDepanKiriIsEnabled,
                    onEnabledChanged: _onPintuDepanKiriEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Kaca Jendela Kiri',
                    count: 10,
                    selectedIndex: _kacaJendelaKiriSelectedIndex,
                    onItemSelected: _onKacaJendelaKiriItemSelected,
                    initialEnabled: _kacaJendelaKiriIsEnabled,
                    onEnabledChanged: _onKacaJendelaKiriEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Lisplang Kiri',
                    count: 10,
                    selectedIndex: _lisplangKiriSelectedIndex,
                    onItemSelected: _onLisplangKiriItemSelected,
                    initialEnabled: _lisplangKiriIsEnabled,
                    onEnabledChanged: _onLisplangKiriEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Side Skirt Kiri',
                    count: 10,
                    selectedIndex: _sideSkirtKiriSelectedIndex,
                    onItemSelected: _onSideSkirtKiriItemSelected,
                    initialEnabled: _sideSkirtKiriIsEnabled,
                    onEnabledChanged: _onSideSkirtKiriEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),

                  // ExpandableTextField
                  ExpandableTextField(
                    label: 'Catatan',
                    hintText: 'Masukkan catatan di sini',
                    controller: _eksteriorCatatanController,
                    onChangedList: _onEksteriorCatatanChanged,
                  ),
                  const SizedBox(height: 32.0),

                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageFiveFive()),
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
