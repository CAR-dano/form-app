import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
// import 'package:form_app/pages/page_six_general_wajib.dart'; // No longer directly navigating
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveSeven extends ConsumerStatefulWidget {
  const PageFiveSeven({super.key});

  @override
  ConsumerState<PageFiveSeven> createState() => _PageFiveSevenState();
}

class _PageFiveSevenState extends ConsumerState<PageFiveSeven> with AutomaticKeepAliveClientMixin { // Add mixin
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
            key: const PageStorageKey<String>('pageFiveSevenScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '5/9'),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian'),
                const SizedBox(height: 6.0),
                const HeadingOne(text: 'Tools Test (7)'),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Tebal Cat Body Depan',
                  count: 10,
                  selectedValue: formData.tebalCatBodyDepanSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTebalCatBodyDepanSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Tebal cat Body Kiri',
                  count: 10,
                  selectedValue: formData.tebalCatBodyKiriSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTebalCatBodyKiriSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Temperature AC Mobil',
                  count: 10,
                  selectedValue: formData.temperatureAcMobilSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTemperatureAcMobilSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Tebal Cat Body Kanan',
                  count: 10,
                  selectedValue: formData.tebalCatBodyKananSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTebalCatBodyKananSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Tebal Cat Body Belakang',
                  count: 10,
                  selectedValue: formData.tebalCatBodyBelakangSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTebalCatBodyBelakangSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'OBD Scanner',
                  count: 10,
                  selectedValue: formData.obdScannerSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateObdScannerSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Tebal Cat Body Atap',
                  count: 10,
                  selectedValue: formData.tebalCatBodyAtapSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTebalCatBodyAtapSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Test ACCU ( ON & OFF )',
                  count: 10,
                  selectedValue: formData.testAccuSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateTestAccuSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ExpandableTextField(
                  label: 'Catatan',
                  hintText: 'Masukkan catatan di sini',
                  initialLines: formData.toolsTestCatatanList,
                  onChangedList: (lines) {
                    formNotifier.updateToolsTestCatatanList(lines);
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
                const SizedBox(height: 32.0),
                Footer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
