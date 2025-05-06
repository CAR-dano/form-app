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

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form
  bool _formSubmitted = false; // Track if the form has been submitted

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
                              return 'Merek Kendaraan belum terisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Tipe Kendaraan',
                          hintText: 'Masukkan tipe kendaraan',
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
                              return 'Tipe Kendaraan belum terisi';
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
                              return 'Tahun belum terisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Transmisi',
                          hintText: 'Contoh: Otomatis / Manual',
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
                              return 'Transmisi belum terisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Warna Kendaraan',
                          hintText: 'Masukkan warna kendaraan',
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
                              return 'Warna Kendaraan belum terisi';
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
                          suffixText: 'km', // Add suffix text for km
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
                              return 'Odometer belum terisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Kepemilikan',
                          hintText: 'Contoh: Pribadi / Perusahaan',
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
                              return 'Kepemilikan belum terisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Plat Nomor',
                          hintText: 'Masukkan plat nomor',
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
                              return 'Plat Nomor belum terisi';
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
                          formSubmitted:
                              _formSubmitted, // Pass the formSubmitted flag
                          lastDate: DateTime.now().add(
                            const Duration(days: 365 * 20),
                          ),
                          validator: (value) {
                            if (value == null) {
                              return 'Pajak 1 Tahun s.d. belum terisi';
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
                          formSubmitted:
                              _formSubmitted, // Pass the formSubmitted flag
                          lastDate: DateTime.now().add(
                            const Duration(days: 365 * 20),
                          ), // Set last date to 20 years from now
                          validator: (value) {
                            if (value == null) {
                              return 'Pajak 5 Tahun s.d. belum terisi';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Biaya Pajak',
                          hintText: 'Masukkan biaya pajak (Rp)',
                          suffixText: 'Rupiah', // Add prefix text for currency
                          keyboardType:
                              TextInputType.number, // Use number keyboard
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
                              return 'Biaya Pajak belum terisi';
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
