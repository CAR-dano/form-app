import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveOne extends ConsumerStatefulWidget {
  const PageFiveOne({super.key});

  @override
  ConsumerState<PageFiveOne> createState() => _PageFiveOneState();
}

class _PageFiveOneState extends ConsumerState<PageFiveOne>{
  late FocusScopeNode _focusScopeNode;

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
            clipBehavior: Clip.none,
            key: const PageStorageKey<String>('pageFiveOneScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '18/26'),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian (1)'),
                const SizedBox(height: 6.0),
                HeadingOne(text: 'Fitur'),
                const SizedBox(height: 16.0),

                ..._buildToggleableNumberedButtonLists(formData, formNotifier),

                ExpandableTextField(
                  label: 'Catatan',
                  hintText: 'Masukkan catatan di sini',
                  initialLines: formData.fiturCatatanList,
                  onChangedList: (lines) {
                    formNotifier.updateFiturCatatanList(lines);
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
        'label': 'Airbag',
        'selectedValue': formData.airbagSelectedValue,
        'onItemSelected': (value) => formNotifier.updateAirbagSelectedValue(value),
      },
      {
        'label': 'Sistem Audio',
        'selectedValue': formData.sistemAudioSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSistemAudioSelectedValue(value),
      },
      {
        'label': 'Power Window',
        'selectedValue': formData.powerWindowSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePowerWindowSelectedValue(value),
      },
      {
        'label': 'Sistem AC',
        'selectedValue': formData.sistemAcSelectedValue,
        'onItemSelected': (value) => formNotifier.updateSistemAcSelectedValue(value),
      },
      {
        'label': 'Central Lock',
        'selectedValue': formData.centralLockSelectedValue,
        'onItemSelected': (value) => formNotifier.updateCentralLockSelectedValue(value),
      },
      {
        'label': 'Electric Mirror',
        'selectedValue': formData.electricMirrorSelectedValue,
        'onItemSelected': (value) => formNotifier.updateElectricMirrorSelectedValue(value),
      },
      {
        'label': 'Rem ABS',
        'selectedValue': formData.remAbsSelectedValue,
        'onItemSelected': (value) => formNotifier.updateRemAbsSelectedValue(value),
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
