import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Import FormData
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggleable_numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

class PenilaianToolsTestPage extends ConsumerStatefulWidget {
  const PenilaianToolsTestPage({
    super.key,
  });

  @override
  ConsumerState<PenilaianToolsTestPage> createState() => _PenilaianToolsTestPage();
}

class _PenilaianToolsTestPage extends ConsumerState<PenilaianToolsTestPage> with AutomaticKeepAliveClientMixin { // Add mixin
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
            key: const PageStorageKey<String>('pageFiveSevenScrollKey'),
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(data: 'Penilaian (7)'),
                    SizedBox(height: 6.0),
                    HeadingOne(text: 'Tools Test'),
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
                      initialLines: formData.toolsTestCatatanList,
                      onChangedList: (lines) {
                        formNotifier.updateToolsTestCatatanList(lines);
                      },
                    ),
                    const SizedBox(height: 32.0),
                    const SizedBox(height: 24.0),
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

    return toggleableNumberedButtonListData;
  }
}
