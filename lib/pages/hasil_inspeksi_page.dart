import 'package:flutter/material.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/numbered_button_list.dart';
import 'package:form_app/widgets/expandable_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/repair_estimation.dart';
import 'package:form_app/widgets/toggle_option_widget.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Four
class HasilInspeksiPage extends ConsumerStatefulWidget { // Change to ConsumerStatefulWidget
  const HasilInspeksiPage({
    super.key,
  });

  @override
  ConsumerState<HasilInspeksiPage> createState() => _HasilInspeksiPageState(); // Change to ConsumerState
}

class _HasilInspeksiPageState extends ConsumerState<HasilInspeksiPage> with AutomaticKeepAliveClientMixin { // Add mixin
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

    // Basic structure, replace with actual content later
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
          child: CustomScrollView(
            key: const PageStorageKey<String>('pageFourScrollKey'),
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(data: 'Hasil Inspeksi'), // Placeholder Title
                    SizedBox(height: 6.0),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    NumberedButtonList(
                      label: 'Interior',
                      count: 10, // Assuming 10 options based on the image
                      selectedValue: formData.interiorSelectedValue ?? -1,
                      onItemSelected: (value) {
                        final formNotifier = ref.read(formProvider.notifier);
                        formNotifier.updateInteriorSelectedValue(value == formData.interiorSelectedValue ? -1 : value);
                      },
                    ),
                    const SizedBox(height: 12.0),
                    ExpandableTextField(
                      label: 'Keterangan Interior', // Placeholder label
                      hintText:
                          'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                      initialLines: formData.keteranganInterior,
                      onChangedList: (lines) {
                        formNotifier.updateKeteranganInterior(lines);
                      },
                    ),
                    const SizedBox(height: 24.0),
                    NumberedButtonList(
                      label: 'Eksterior',
                      count: 10, // Assuming 10 options based on the image
                      selectedValue: formData.eksteriorSelectedValue ?? -1,
                      onItemSelected: (value) {
                        final formNotifier = ref.read(formProvider.notifier);
                        formNotifier.updateEksteriorSelectedValue(value == formData.eksteriorSelectedValue ? -1 : value);
                      },
                    ),
                    const SizedBox(height: 12.0),
                    ExpandableTextField(
                      label: 'Keterangan Eksterior', // Placeholder label
                      hintText:
                          'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                      initialLines: formData.keteranganEksterior,
                      onChangedList: (lines) {
                        formNotifier.updateKeteranganEksterior(lines);
                      },
                    ),
                    const SizedBox(height: 24.0),
                    NumberedButtonList(
                      label: 'Kaki-kaki',
                      count: 10, // Assuming 10 options based on the image
                      selectedValue: formData.kakiKakiSelectedValue ?? -1,
                      onItemSelected: (value) {
                        final formNotifier = ref.read(formProvider.notifier);
                        formNotifier.updateKakiKakiSelectedValue(value == formData.kakiKakiSelectedValue ? -1 : value);
                      },
                    ),
                    const SizedBox(height: 12.0),
                    ExpandableTextField(
                      label: 'Keterangan Kaki-kaki', // Placeholder label
                      hintText:
                          'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                      initialLines: formData.keteranganKakiKaki,
                      onChangedList: (lines) {
                        formNotifier.updateKeteranganKakiKaki(lines);
                      },
                    ),
                    const SizedBox(height: 24.0),
                    NumberedButtonList(
                      label: 'Mesin',
                      count: 10, // Assuming 10 options based on the image
                      selectedValue: formData.mesinSelectedValue ?? -1,
                      onItemSelected: (value) {
                        final formNotifier = ref.read(formProvider.notifier);
                        formNotifier.updateMesinSelectedValue(value == formData.mesinSelectedValue ? -1 : value);
                      },
                    ),
                    const SizedBox(height: 12.0),
                    ExpandableTextField(
                      label: 'Keterangan Mesin', // Placeholder label
                      hintText:
                          'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                      initialLines: formData.keteranganMesin,
                      onChangedList: (lines) {
                        formNotifier.updateKeteranganMesin(lines);
                      },
                    ),
                    const SizedBox(height: 24.0),
                    ExpandableTextField(
                      label: 'Deskripsi Keseluruhan', // Placeholder label
                      hintText:
                          'Deskripsi 1\nDeskripsi 2\nDeskripsi 3', // Multi-line hint text
                      initialLines: formData.deskripsiKeseluruhan,
                      onChangedList: (lines) {
                        formNotifier.updateDeskripsiKeseluruhan(lines);
                      },
                    ),
                    const SizedBox(height: 24.0), // Spacing before new toggle options
                    ToggleOption(
                      label: 'Indikasi Tabrakan',
                      toggleValues: ['Tidak ada', 'Terindikasi'],
                      initialValue: formData.indikasiTabrakan,
                      onChanged: (value) => formNotifier.updateIndikasiTabrakan(value),
                    ),
                    const SizedBox(height: 16.0),
                    ToggleOption(
                      label: 'Indikasi Banjir',
                      toggleValues: ['Tidak ada', 'Terindikasi'],
                      initialValue: formData.indikasiBanjir,
                      onChanged: (value) => formNotifier.updateIndikasiBanjir(value),
                    ),
                    const SizedBox(height: 16.0),
                    ToggleOption(
                      label: 'Indikasi Odometer Reset',
                      toggleValues: ['Tidak ada', 'Terindikasi'],
                      initialValue: formData.indikasiOdometerReset,
                      onChanged: (value) => formNotifier.updateIndikasiOdometerReset(value),
                    ),
                    const SizedBox(height: 24.0), // Spacing before new text fields
                    LabeledTextField(
                      label: 'Posisi Ban',
                      hintText: 'Misal : Ban agak miring ke kanan',
                      initialValue: formData.posisiBan,
                      onChanged: (value) {
                        formNotifier.updatePosisiBan(value);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    LabeledTextField(
                      label: 'Merk',
                      hintText: 'Misal : Bridgestone',
                      initialValue: formData.merk,
                      onChanged: (value) {
                        formNotifier.updateMerk(value);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    LabeledTextField(
                      label: 'Tipe Velg',
                      hintText: 'Misal : Alloy Standar',
                      initialValue: formData.tipeVelg,
                      onChanged: (value) {
                        formNotifier.updateTipeVelg(value);
                      },
                    ),
                    const SizedBox(height: 16.0),
                    LabeledTextField(
                      label: 'Ketebalan',
                      hintText: 'Misal : Ban telah aus',
                      initialValue: formData.ketebalan,
                      onChanged: (value) {
                        formNotifier.updateKetebalan(value);
                      },
                    ),
                    const SizedBox(height: 16.0), // Spacing before Estimasi Perbaikan section
                    RepairEstimation(
                      label: 'Estimasi Perbaikan', // Added the custom widget with label
                      initialEstimations: formData.repairEstimations,
                      onChanged: (estimations) => formNotifier.updateRepairEstimations(estimations),
                    ),
                    const SizedBox(height: 24.0), // Spacing before navigation buttons
                    const SizedBox(
                      height: 24.0,
                    ), // Optional spacing below the content
                    // Footer
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
}
