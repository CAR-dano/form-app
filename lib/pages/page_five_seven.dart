import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Import FormData
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PageFiveSeven extends ConsumerStatefulWidget {
  final int currentPage;
  final int totalPages;

  const PageFiveSeven({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

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
            clipBehavior: Clip.none,
            key: const PageStorageKey<String>('pageFiveSevenScrollKey'), // Add PageStorageKey here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(currentPage: widget.currentPage, totalPages: widget.totalPages),
                const SizedBox(height: 4),
                PageTitle(data: 'Penilaian (7)'),
                const SizedBox(height: 6.0),
                const HeadingOne(text: 'Tools Test'),
                const SizedBox(height: 16.0),

                ..._buildToggleableNumberedButtonLists(formData, formNotifier),

                ExpandableTextField(
                  label: 'Catatan',
                  hintText: 'Masukkan catatan di sini',
                  initialLines: formData.toolsTestCatatanList,
                  onChangedList: (lines) {
                    formNotifier.updateToolsTestCatatanList(lines);
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
        'label': 'Tebal Cat Body Depan',
        'selectedValue': formData.tebalCatBodyDepanSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTebalCatBodyDepanSelectedValue(value),
      },
      {
        'label': 'Tebal cat Body Kiri',
        'selectedValue': formData.tebalCatBodyKiriSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTebalCatBodyKiriSelectedValue(value),
      },
      {
        'label': 'Temperature AC Mobil',
        'selectedValue': formData.temperatureAcMobilSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTemperatureAcMobilSelectedValue(value),
      },
      {
        'label': 'Tebal Cat Body Kanan',
        'selectedValue': formData.tebalCatBodyKananSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTebalCatBodyKananSelectedValue(value),
      },
      {
        'label': 'Tebal Cat Body Belakang',
        'selectedValue': formData.tebalCatBodyBelakangSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTebalCatBodyBelakangSelectedValue(value),
      },
      {
        'label': 'OBD Scanner',
        'selectedValue': formData.obdScannerSelectedValue,
        'onItemSelected': (value) => formNotifier.updateObdScannerSelectedValue(value),
      },
      {
        'label': 'Tebal Cat Body Atap',
        'selectedValue': formData.tebalCatBodyAtapSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTebalCatBodyAtapSelectedValue(value),
      },
      {
        'label': 'Test ACCU ( ON & OFF )',
        'selectedValue': formData.testAccuSelectedValue,
        'onItemSelected': (value) => formNotifier.updateTestAccuSelectedValue(value),
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
