import 'package:flutter/material.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/numbered_button_list.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/expandable_text_field.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/toggle_option_widget.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Four
class PageFour extends ConsumerStatefulWidget { // Change to ConsumerStatefulWidget
  const PageFour({super.key});

  @override
  ConsumerState<PageFour> createState() => _PageFourState(); // Change to ConsumerState
}

class _PageFourState extends ConsumerState<PageFour> { // Change to ConsumerState
  late FocusScopeNode _focusScopeNode; // Add FocusScopeNode

  int _interiorSelectedIndex = -1;
  int _eksteriorSelectedIndex = -1;
  int _kakiKakiSelectedIndex = -1;
  int _mesinSelectedIndex = -1;
  int _penilaianKeseluruhanSelectedIndex = -1;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode(); // Initialize FocusScopeNode
  }

  @override
  void dispose() {
    _focusScopeNode.dispose(); // Dispose FocusScopeNode
    super.dispose();
  }

  void _onInteriorItemSelected(int index) {
    setState(() {
      if (_interiorSelectedIndex == index) {
        _interiorSelectedIndex = -1; // Unselect if already selected
      } else {
        _interiorSelectedIndex = index; // Select the tapped index
      }
    });
  }

  void _onEksteriorItemSelected(int index) {
    setState(() {
      if (_eksteriorSelectedIndex == index) {
        _eksteriorSelectedIndex = -1; // Unselect if already selected
      } else {
        _eksteriorSelectedIndex = index; // Select the tapped index
      }
    });
  }

  void _onKakiKakiItemSelected(int index) {
    setState(() {
      if (_kakiKakiSelectedIndex == index) {
        _kakiKakiSelectedIndex = -1; // Unselect if already selected
      } else {
        _kakiKakiSelectedIndex = index; // Select the tapped index
      }
    });
  }

  void _onMesinItemSelected(int index) {
    setState(() {
      if (_mesinSelectedIndex == index) {
        _mesinSelectedIndex = -1; // Unselect if already selected
      } else {
        _mesinSelectedIndex = index; // Select the tapped index
      }
    });
  }

  void _onPenilaianKeseluruhanItemSelected(int index) {
    setState(() {
      if (_penilaianKeseluruhanSelectedIndex == index) {
        _penilaianKeseluruhanSelectedIndex = -1; // Unselect if already selected
      } else {
        _penilaianKeseluruhanSelectedIndex = index; // Select the tapped index
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(formProvider); // Watch the form data
    final formNotifier = ref.read(formProvider.notifier); // Read the notifier

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
        child: CommonLayout(
          child: GestureDetector(
            // Wrap with GestureDetector
            onTap: () {
              _focusScopeNode.unfocus(); // Unfocus on tap outside text fields
            },
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageNumber(data: '4/9'),
                        const SizedBox(height: 8.0),
                        PageTitle(data: 'Hasil Inspeksi'), // Placeholder Title
                        const SizedBox(height: 24.0),
                        NumberedButtonList(
                          label: 'Interior',
                          count: 10, // Assuming 10 options based on the image
                          selectedIndex: _interiorSelectedIndex,
                          onItemSelected: _onInteriorItemSelected,
                        ),
                        const SizedBox(height: 24.0),
                        ExpandableTextField(
                          label: 'Keterangan Interior', // Placeholder label
                          hintText:
                              'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                          onChanged: (value) {
                            // TODO: Handle text changes
                          },
                        ),
                        const SizedBox(height: 32.0),
                        NumberedButtonList(
                          label: 'Eksterior',
                          count: 10, // Assuming 10 options based on the image
                          selectedIndex: _eksteriorSelectedIndex,
                          onItemSelected: _onEksteriorItemSelected,
                        ),
                        const SizedBox(height: 24.0),
                        ExpandableTextField(
                          label: 'Keterangan Eksterior', // Placeholder label
                          hintText:
                              'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                          onChanged: (value) {
                            // TODO: Handle text changes
                          },
                        ),
                        const SizedBox(height: 32.0),
                        NumberedButtonList(
                          label: 'Kaki-kaki',
                          count: 10, // Assuming 10 options based on the image
                          selectedIndex: _kakiKakiSelectedIndex,
                          onItemSelected: _onKakiKakiItemSelected,
                        ),
                        const SizedBox(height: 24.0),
                        ExpandableTextField(
                          label: 'Keterangan Kaki-kaki', // Placeholder label
                          hintText:
                              'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                          onChanged: (value) {
                            // TODO: Handle text changes
                          },
                        ),
                        const SizedBox(height: 32.0),
                        NumberedButtonList(
                          label: 'Mesin',
                          count: 10, // Assuming 10 options based on the image
                          selectedIndex: _mesinSelectedIndex,
                          onItemSelected: _onMesinItemSelected,
                        ),
                        const SizedBox(height: 24.0),
                        ExpandableTextField(
                          label: 'Keterangan Mesin', // Placeholder label
                          hintText:
                              'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                          onChanged: (value) {
                            // TODO: Handle text changes
                          },
                        ),
                        const SizedBox(height: 32.0),
                        NumberedButtonList(
                          label: 'Penilaian Keseluruhan',
                          count: 10, // Assuming 10 options based on the image
                          selectedIndex: _penilaianKeseluruhanSelectedIndex,
                          onItemSelected: _onPenilaianKeseluruhanItemSelected,
                        ),
                        const SizedBox(height: 24.0),
                        ExpandableTextField(
                          label: 'Deskripsi Keseluruhan', // Placeholder label
                          hintText:
                              'Deskripsi 1\nDeskripsi 2\nDeskripsi 3', // Multi-line hint text
                          onChanged: (value) {
                            // TODO: Handle text changes
                          },
                        ),
                        const SizedBox(height: 32.0), // Spacing before new toggle options
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
                        const SizedBox(height: 32.0), // Spacing before new text fields
                        LabeledTextField(
                          label: 'Merek Ban Depan',
                          hintText: 'Masukkan Merek Ban',
                          initialValue: formData.merekBanDepan,
                          onChanged: (value) {
                            formNotifier.updateMerekBanDepan(value);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Tipe Velg Depan',
                          hintText: 'Masukkan tipe velg',
                          initialValue: formData.tipeVelgDepan,
                          onChanged: (value) {
                            formNotifier.updateTipeVelgDepan(value);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Ketebalan Ban Depan',
                          hintText: 'Masukkan ketebalan ban',
                          initialValue: formData.ketebalanBanDepan,
                          onChanged: (value) {
                            formNotifier.updateKetebalanBanDepan(value);
                          },
                        ),
                        const SizedBox(height: 32.0), // Spacing between front and rear tire fields
                        LabeledTextField(
                          label: 'Merek Ban Belakang',
                          hintText: 'Masukkan Merek Ban',
                          initialValue: formData.merekBanBelakang,
                          onChanged: (value) {
                            formNotifier.updateMerekBanBelakang(value);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Tipe Velg Belakang',
                          hintText: 'Masukkan tipe velg',
                          initialValue: formData.tipeVelgBelakang,
                          onChanged: (value) {
                            formNotifier.updateTipeVelgBelakang(value);
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Ketebalan Ban Belakang',
                          hintText: 'Masukkan ketebalan ban',
                          initialValue: formData.ketebalanBanBelakang,
                          onChanged: (value) {
                            formNotifier.updateKetebalanBanBelakang(value);
                          },
                        ),
                        const SizedBox(height: 32.0), // Spacing before navigation buttons
                        NavigationButtonRow(
                          onBackPressed: () => Navigator.pop(context),
                          onNextPressed: () {
                            // TODO: Implement navigation to Page Five
                          },
                        ),
                        SizedBox(
                          height: 32.0,
                        ), // Optional spacing below the content
                        // Footer
                        Footer(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
