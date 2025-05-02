import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/pages/page_three.dart'; // Assuming PageThree exists or will be created
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_date_field.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';

class PageTwo extends ConsumerStatefulWidget {
  const PageTwo({super.key});

  @override
  ConsumerState<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends ConsumerState<PageTwo> {
  late FocusScopeNode _focusScopeNode;
  late FocusNode _merekKendaraanFocusNode;
  late FocusNode _tipeKendaraanFocusNode;
  late FocusNode _tahunFocusNode;
  late FocusNode _transmisiFocusNode;
  late FocusNode _warnaKendaraanFocusNode;
  late FocusNode _odometerFocusNode;
  late FocusNode _kepemilikanFocusNode;
  late FocusNode _platNomorFocusNode;
  late FocusNode _pajak1TahunFocusNode;
  late FocusNode _pajak5TahunFocusNode;
  late FocusNode _biayaPajakFocusNode;

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form
  bool _formSubmitted = false; // Track if the form has been submitted

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
    _merekKendaraanFocusNode = FocusNode();
    _tipeKendaraanFocusNode = FocusNode();
    _tahunFocusNode = FocusNode();
    _transmisiFocusNode = FocusNode();
    _warnaKendaraanFocusNode = FocusNode();
    _odometerFocusNode = FocusNode();
    _kepemilikanFocusNode = FocusNode();
    _platNomorFocusNode = FocusNode();
    _pajak1TahunFocusNode = FocusNode();
    _pajak5TahunFocusNode = FocusNode();
    _biayaPajakFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    _merekKendaraanFocusNode.dispose();
    _tipeKendaraanFocusNode.dispose();
    _tahunFocusNode.dispose();
    _transmisiFocusNode.dispose();
    _warnaKendaraanFocusNode.dispose();
    _odometerFocusNode.dispose();
    _kepemilikanFocusNode.dispose();
    _platNomorFocusNode.dispose();
    _pajak1TahunFocusNode.dispose();
    _pajak5TahunFocusNode.dispose();
    _biayaPajakFocusNode.dispose();
    super.dispose();
  }

  void moveToNextPage() {
    // Navigate to Page Three, wrapped in CommonLayout
    Navigator.push(
      context,
      MaterialPageRoute(
        builder:
            (context) =>
                const CommonLayout(child: PageThree()), // Wrap PageThree
      ),
    );
  }

  void moveToPreviousPage() {
    Navigator.pop(
      context,
    ); // Simple pop to go back to the previous page (PageOne)
  }

  void validateAndMoveToNextPage() {
    setState(() {
      _formSubmitted = true; // Mark the form as submitted
    });
    if (_formKey.currentState!.validate()) {
      // If the form is valid, navigate to the next page.
      moveToNextPage(); // Move to the next page if validation passes
    }
  }

  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(formProvider); // Watch the form data
    final formNotifier = ref.read(formProvider.notifier); // Read the notifier

    // Return the core content Column directly. Scaffold/SafeArea are in CommonLayout.
    return PopScope(
      // Wrap with PopScope
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus(); // Unfocus when navigating back
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: Form(
          // Wrap with Form widget
          key: _formKey, // Assign the form key
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
                        PageNumber(data: '2/9'), // Updated Page Number
                        const SizedBox(height: 8.0),
                        PageTitle(data: 'Data Kendaraan'), // Updated Title
                        const SizedBox(height: 24.0),

                        // Input Fields based on user request
                        LabeledTextField(
                          label: 'Merek Kendaraan',
                          hintText: 'Masukkan merek kendaraan',
                          focusNode: _merekKendaraanFocusNode,
                          initialValue:
                              formData
                                  .merekKendaraan, // Initialize with data from provider
                          onChanged: (value) {
                            formNotifier.updateMerekKendaraan(
                              value,
                            ); // Update data in provider
                          },
                          formSubmitted:
                              _formSubmitted, // Pass the formSubmitted flag
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Merek Kendaraan tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Tipe Kendaraan',
                          hintText: 'Masukkan tipe kendaraan',
                          focusNode: _tipeKendaraanFocusNode,
                          initialValue:
                              formData
                                  .tipeKendaraan, // Initialize with data from provider
                          onChanged: (value) {
                            formNotifier.updateTipeKendaraan(
                              value,
                            ); // Update data in provider
                          },
                          formSubmitted:
                              _formSubmitted, // Pass the formSubmitted flag
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tipe Kendaraan tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Tahun',
                          hintText: 'Masukkan tahun pembuatan',
                          keyboardType:
                              TextInputType.number, // Use number keyboard
                          useThousandsSeparator:
                              false, // Disable thousands separator for Tahun
                          focusNode: _tahunFocusNode,
                          initialValue:
                              formData
                                  .tahun, // Initialize with data from provider
                          onChanged: (value) {
                            formNotifier.updateTahun(
                              value,
                            ); // Update data in provider
                          },
                          formSubmitted:
                              _formSubmitted, // Pass the formSubmitted flag
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Tahun tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Transmisi',
                          hintText: 'Contoh: Otomatis / Manual',
                          focusNode: _transmisiFocusNode,
                          initialValue:
                              formData
                                  .transmisi, // Initialize with data from provider
                          onChanged: (value) {
                            formNotifier.updateTransmisi(
                              value,
                            ); // Update data in provider
                          },
                          formSubmitted: _formSubmitted,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Transmisi tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Warna Kendaraan',
                          hintText: 'Masukkan warna kendaraan',
                          focusNode: _warnaKendaraanFocusNode,
                          initialValue:
                              formData
                                  .warnaKendaraan, // Initialize with data from provider
                          onChanged: (value) {
                            formNotifier.updateWarnaKendaraan(
                              value,
                            ); // Update data in provider
                          },
                          formSubmitted: _formSubmitted,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Warna Kendaraan tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Odometer',
                          hintText: 'Masukkan angka odometer (km)',
                          keyboardType:
                              TextInputType.number, // Use number keyboard
                          focusNode: _odometerFocusNode,
                          initialValue:
                              formData
                                  .odometer, // Initialize with data from provider
                          onChanged: (value) {
                            formNotifier.updateOdometer(
                              value,
                            ); // Update data in provider
                          },
                          formSubmitted: _formSubmitted,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Odometer tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Kepemilikan',
                          hintText: 'Contoh: Pribadi / Perusahaan',
                          focusNode: _kepemilikanFocusNode,
                          initialValue:
                              formData
                                  .kepemilikan, // Initialize with data from provider
                          onChanged: (value) {
                            formNotifier.updateKepemilikan(
                              value,
                            ); // Update data in provider
                          },
                          formSubmitted: _formSubmitted,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Kepemilikan tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Plat Nomor',
                          hintText: 'Masukkan plat nomor',
                          focusNode: _platNomorFocusNode,
                          initialValue:
                              formData
                                  .platNomor, // Initialize with data from provider
                          onChanged: (value) {
                            formNotifier.updatePlatNomor(
                              value,
                            ); // Update data in provider
                          },
                          formSubmitted: _formSubmitted,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Plat Nomor tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledDateField(
                          label: 'Pajak 1 Tahun s.d.',
                          hintText: 'Pilih tanggal',
                          initialDate:
                              formData
                                  .pajak1TahunDate, // Initialize with data from provider
                          onChanged: (date) {
                            formNotifier.updatePajak1TahunDate(
                              date,
                            ); // Update data in provider
                          },
                          focusNode: _pajak1TahunFocusNode,
                          formSubmitted:
                              _formSubmitted, // Pass the formSubmitted flag
                          lastDate: DateTime.now().add(
                            const Duration(days: 365 * 20),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Pajak 1 Tahun s.d. tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledDateField(
                          label: 'Pajak 5 Tahun s.d.',
                          hintText: 'Pilih tanggal',
                          initialDate:
                              formData
                                  .pajak5TahunDate, // Initialize with data from provider
                          onChanged: (date) {
                            formNotifier.updatePajak5TahunDate(
                              date,
                            ); // Update data in provider
                          },
                          focusNode: _pajak5TahunFocusNode,
                          formSubmitted:
                              _formSubmitted, // Pass the formSubmitted flag
                          lastDate: DateTime.now().add(
                            const Duration(days: 365 * 20),
                          ), // Set last date to 20 years from now
                          validator: (value) {
                            if (value == null) {
                              return 'Pajak 5 Tahun s.d. tidak boleh kosong';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Biaya Pajak',
                          hintText: 'Masukkan biaya pajak (Rp)',
                          keyboardType:
                              TextInputType.number, // Use number keyboard
                          focusNode: _biayaPajakFocusNode,
                          initialValue:
                              formData
                                  .biayaPajak, // Initialize with data from provider
                          onChanged: (value) {
                            formNotifier.updateBiayaPajak(
                              value,
                            ); // Update data in provider
                          },
                          formSubmitted: _formSubmitted,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Biaya Pajak tidak boleh kosong';
                            }
                            return null;
                          },
                        ),

                        const SizedBox(height: 32.0), // Spacing before buttons
                        // Navigation Row - Back button is enabled here
                        NavigationButtonRow(
                          onBackPressed:
                              moveToPreviousPage, // Enable back navigation
                          onNextPressed:
                              validateAndMoveToNextPage, // Call validation function
                          // isBackButtonEnabled: true, // Default is true, so can be omitted
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
