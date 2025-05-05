import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_two.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveOne extends ConsumerStatefulWidget {
  const PageFiveOne({super.key});

  @override
  ConsumerState<PageFiveOne> createState() => _PageFiveOneState();
}

class _PageFiveOneState extends ConsumerState<PageFiveOne> {
  int _airbagSelectedIndex = -1;
  bool _airbagIsEnabled = true;

  int _sistemAudioSelectedIndex = -1;
  bool _sistemAudioIsEnabled = true;

  int _powerWindowSelectedIndex = -1;
  bool _powerWindowIsEnabled = true;

  int _sistemAcSelectedIndex = -1;
  bool _sistemAcIsEnabled = true;

  @override
  void initState() {
    super.initState();
    final formData = ref.read(formProvider);
    _airbagSelectedIndex = formData.airbagSelectedIndex ?? -1;
    _airbagIsEnabled = formData.airbagIsEnabled ?? true;
    _sistemAudioSelectedIndex = formData.sistemAudioSelectedIndex ?? -1;
    _sistemAudioIsEnabled = formData.sistemAudioIsEnabled ?? true;
    _powerWindowSelectedIndex = formData.powerWindowSelectedIndex ?? -1;
    _powerWindowIsEnabled = formData.powerWindowIsEnabled ?? true;
    _sistemAcSelectedIndex = formData.sistemAcSelectedIndex ?? -1;
    _sistemAcIsEnabled = formData.sistemAcIsEnabled ?? true;
  }

  @override
  void dispose() {
    super.dispose();
  }

  void _onAirbagItemSelected(int index) {
    setState(() {
      _airbagSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateAirbagSelectedIndex(index);
  }

  void _onAirbagEnabledChanged(bool enabled) {
    setState(() {
      _airbagIsEnabled = enabled;
      if (!enabled) {
        _airbagSelectedIndex = -1; // Reset selected index when disabled
      }
    });
    ref.read(formProvider.notifier).updateAirbagIsEnabled(enabled);
    ref.read(formProvider.notifier).updateAirbagSelectedIndex(_airbagSelectedIndex);
  }

  void _onSistemAudioItemSelected(int index) {
    setState(() {
      _sistemAudioSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSistemAudioSelectedIndex(index);
  }

  void _onSistemAudioEnabledChanged(bool enabled) {
    setState(() {
      _sistemAudioIsEnabled = enabled;
      if (!enabled) {
        _sistemAudioSelectedIndex = -1;
      }
    });
    ref.read(formProvider.notifier).updateSistemAudioIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSistemAudioSelectedIndex(_sistemAudioSelectedIndex);
  }

  void _onPowerWindowItemSelected(int index) {
    setState(() {
      _powerWindowSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updatePowerWindowSelectedIndex(index);
  }

  void _onPowerWindowEnabledChanged(bool enabled) {
    setState(() {
      _powerWindowIsEnabled = enabled;
      if (!enabled) {
        _powerWindowSelectedIndex = -1;
      }
    });
    ref.read(formProvider.notifier).updatePowerWindowIsEnabled(enabled);
    ref.read(formProvider.notifier).updatePowerWindowSelectedIndex(_powerWindowSelectedIndex);
  }

  void _onSistemAcItemSelected(int index) {
    setState(() {
      _sistemAcSelectedIndex = index;
    });
    ref.read(formProvider.notifier).updateSistemAcSelectedIndex(index);
  }

  void _onSistemAcEnabledChanged(bool enabled) {
    setState(() {
      _sistemAcIsEnabled = enabled;
      if (!enabled) {
        _sistemAcSelectedIndex = -1;
      }
    });
    ref.read(formProvider.notifier).updateSistemAcIsEnabled(enabled);
    ref.read(formProvider.notifier).updateSistemAcSelectedIndex(_sistemAcSelectedIndex);
  }

  void _onFiturCatatanChanged(List<String> lines) {
    ref.read(formProvider.notifier).updateFiturCatatanList(lines);
  }

  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(formProvider);
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
                  PageTitle(data: 'Penilaian'),
                  const SizedBox(height: 24.0),
                  HeadingOne(text: 'Fitur'),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Airbag',
                    count: 10,
                    selectedIndex: _airbagSelectedIndex,
                    onItemSelected: _onAirbagItemSelected,
                    initialEnabled: _airbagIsEnabled,
                    onEnabledChanged: _onAirbagEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Sistem Audio',
                    count: 10,
                    selectedIndex: _sistemAudioSelectedIndex,
                    onItemSelected: _onSistemAudioItemSelected,
                    initialEnabled: _sistemAudioIsEnabled,
                    onEnabledChanged: _onSistemAudioEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Power Window',
                    count: 10,
                    selectedIndex: _powerWindowSelectedIndex,
                    onItemSelected: _onPowerWindowItemSelected,
                    initialEnabled: _powerWindowIsEnabled,
                    onEnabledChanged: _onPowerWindowEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ToggleableNumberedButtonList(
                    label: 'Sistem AC',
                    count: 10,
                    selectedIndex: _sistemAcSelectedIndex,
                    onItemSelected: _onSistemAcItemSelected,
                    initialEnabled: _sistemAcIsEnabled,
                    onEnabledChanged: _onSistemAcEnabledChanged,
                  ),
                  const SizedBox(height: 16.0),
                  ExpandableTextField(
                    label: 'Catatan',
                    hintText: 'Masukkan catatan di sini',
                    initialLines: formData.fiturCatatanList,
                    onChangedList: _onFiturCatatanChanged,
                  ),
                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageFiveTwo()),
                      );
                    },
                  ),
                  const SizedBox(height: 32.0),
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
