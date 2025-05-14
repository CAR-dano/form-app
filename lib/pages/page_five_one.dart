import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
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

class _PageFiveOneState extends ConsumerState<PageFiveOne> with AutomaticKeepAliveClientMixin { // Add mixin
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
            key: const PageStorageKey<String>('pageFiveOneScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '5/9'),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian (1)'),
                const SizedBox(height: 6.0),
                HeadingOne(text: 'Fitur'),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Airbag',
                  count: 10,
                  selectedValue: formData.airbagSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateAirbagSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Sistem Audio',
                  count: 10,
                  selectedValue: formData.sistemAudioSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSistemAudioSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Power Window',
                  count: 10,
                  selectedValue: formData.powerWindowSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePowerWindowSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Sistem AC',
                  count: 10,
                  selectedValue: formData.sistemAcSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateSistemAcSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
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
}
