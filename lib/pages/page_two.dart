import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:form_app/pages/page_three.dart'; // No longer directly navigating
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_date_field.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';

class PageTwo extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey; // Add formKey parameter

  const PageTwo({super.key, required this.formKey}); // Update constructor

  @override
  ConsumerState<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends ConsumerState<PageTwo> with AutomaticKeepAliveClientMixin { // Add mixin
  late FocusScopeNode _focusScopeNode;

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  // final _formKey = GlobalKey<FormState>(); // GlobalKey for the form - now passed as a parameter
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

  // void moveToNextPage() {
  //   // Navigation is now handled by MultiStepFormScreen
  // }

  // void moveToPreviousPage() {
  //   // Navigation is now handled by MultiStepFormScreen
  // }

  // void validateAndMoveToNextPage() { // Keep validation logic, but remove navigation
  //   setState(() {
  //     _formSubmitted = true; // Mark the form as submitted
  //   });
  //   if (widget.formKey.currentState!.validate()) { // Use widget.formKey
  //     // Navigation is now handled by MultiStepFormScreen
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
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
          key: widget.formKey, // Use the passed formKey
          child: GestureDetector(
            // Wrap with GestureDetector
            onTap: () {
              _focusScopeNode.unfocus(); // Unfocus on tap outside text fields
            },
            child: SingleChildScrollView(
              key: const PageStorageKey<String>('pageTwoScrollKey'), // Add PageStorageKey here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '2/9'), // Updated Page Number
                  const SizedBox(height: 4),
                  PageTitle(data: 'Data Kendaraan'), // Updated Title
                  const SizedBox(height: 6.0),
                        
                  // Input Fields based on user request
                  LabeledTextField(
                    label: 'Merek Kendaraan',
                    hintText: 'Misal : Honda',
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
                    hintText: 'Misal : City 1.5 HB RS CVT',
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
                    hintText: 'Misal : 2022',
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
                    hintText: 'Misal : Automatis CVT',
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
                    hintText: 'Misal : Kuning',
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
                    hintText: 'Misal : 43.456',
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
                    hintText: 'Misal : Pribadi',
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
                    hintText: 'Misal : AB 1234 CD',
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
                    hintText: 'Misal : 3.123.456',
                    suffixText: 'Rp', // Add prefix text for currency
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
                  NavigationButtonRow(
                    onBackPressed: () {
                      _focusScopeNode.unfocus();
                      ref.read(formStepProvider.notifier).state--;
                    },
                    onNextPressed: () {
                      setState(() {
                        _formSubmitted = true;
                      });
                      if (widget.formKey.currentState?.validate() ?? false) {
                        _focusScopeNode.unfocus();
                        ref.read(formStepProvider.notifier).state++;
                      }
                    },
                  ),
                  const SizedBox(height: 24.0),
                  Footer(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
