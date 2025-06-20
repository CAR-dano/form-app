import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Import FormData
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveSix extends ConsumerStatefulWidget {
  const PageFiveSix({
    super.key,
  });

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
            clipBehavior: Clip.none,
            key: const PageStorageKey<String>('pageFiveSixScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageTitle(data: 'Penilaian (6)'),
                const SizedBox(height: 6.0),
                const HeadingOne(text: 'Test Drive'),
                const SizedBox(height: 16.0),

                ..._buildToggleableNumberedButtonLists(formData, formNotifier),

                ExpandableTextField(
                  label: 'Catatan',
                  hintText: 'Masukkan catatan di sini',
                  initialLines: formData.testDriveCatatanList,
                  onChangedList: (lines) {
                    formNotifier.updateTestDriveCatatanList(lines);
                  },
                ),
                const SizedBox(height: 32.0),
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
        'label': 'Bunyi/Getaran',
        'selectedValue': formData.bunyiGetaranSelectedValue,
        'onItemSelected': (value) => formNotifier.updateBunyiGetaranSelectedValue(value),
      },
      {
        'label': 'Performa Stir',
        'selectedValue': formData.performaStirSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePerformaStirSelectedValue(value),
      },
      {
        'label': 'Perpindahan Transmisi',
        'selectedValue': formData.perpindahanTransmisiSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePerpindahanTransmisiSelectedValue(value),
      },
      {
        'label': 'Stir Balance',
        'selectedValue': formData.stirBalanceSelectedValue,
        'onItemSelected': (value) => formNotifier.updateStirBalanceSelectedValue(value),
      },
      {
        'label': 'Performa Suspensi',
        'selectedValue': formData.performaSuspensiSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePerformaSuspensiSelectedValue(value),
      },
      {
        'label': 'Performa Kopling',
        'selectedValue': formData.performaKoplingSelectedValue,
        'onItemSelected': (value) => formNotifier.updatePerformaKoplingSelectedValue(value),
      },
      {
        'label': 'RPM',
        'selectedValue': formData.rpmSelectedValue,
        'onItemSelected': (value) => formNotifier.updateRpmSelectedValue(value),
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
