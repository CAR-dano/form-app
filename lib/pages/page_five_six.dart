import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
// import 'package:form_app/pages/page_five_seven.dart'; // No longer directly navigating
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveSix extends ConsumerStatefulWidget {
  const PageFiveSix({super.key});

  @override
  ConsumerState<PageFiveSix> createState() => _PageFiveSixState();
}

class _PageFiveSixState extends ConsumerState<PageFiveSix> with AutomaticKeepAliveClientMixin { // Add mixin
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
            key: const PageStorageKey<String>('pageFiveSixScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '6/9'),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian (6)'),
                const SizedBox(height: 6.0),
                const HeadingOne(text: 'Test Drive'),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Bunyi/Getaran',
                  count: 10,
                  selectedValue: formData.bunyiGetaranSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateBunyiGetaranSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Performa Stir',
                  count: 10,
                  selectedValue: formData.performaStirSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePerformaStirSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Perpindahan Transmisi',
                  count: 10,
                  selectedValue: formData.perpindahanTransmisiSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePerpindahanTransmisiSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Stir Balance',
                  count: 10,
                  selectedValue: formData.stirBalanceSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateStirBalanceSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Performa Suspensi',
                  count: 10,
                  selectedValue: formData.performaSuspensiSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePerformaSuspensiSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'Performa Kopling',
                  count: 10,
                  selectedValue: formData.performaKoplingSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updatePerformaKoplingSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ToggleableNumberedButtonList(
                  label: 'RPM',
                  count: 10,
                  selectedValue: formData.rpmSelectedValue ?? -1,
                  onItemSelected: (value) {
                    formNotifier.updateRpmSelectedValue(value);
                  },
                ),
                const SizedBox(height: 16.0),
                ExpandableTextField(
                  label: 'Catatan',
                  hintText: 'Masukkan catatan di sini',
                  initialLines: formData.testDriveCatatanList,
                  onChangedList: (lines) {
                    formNotifier.updateTestDriveCatatanList(lines);
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
