// page_one.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/pages/page_two.dart';
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/widgets/common_layout.dart'; // Import CommonLayout
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_date_field.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/labeled_text_field.dart';


class PageOne extends ConsumerStatefulWidget {
  const PageOne({super.key});

  @override
  ConsumerState<PageOne> createState() => _PageOneState();
}

class _PageOneState extends ConsumerState<PageOne> {
  late FocusScopeNode _focusScopeNode;
  late FocusNode _namaInspektorFocusNode;
  late FocusNode _namaCustomerFocusNode;
  late FocusNode _cabangInspeksiFocusNode;
  late FocusNode _tanggalInspeksiFocusNode;

  final _formKey = GlobalKey<FormState>(); // GlobalKey for the form
  bool _formSubmitted = false; // Track if the form has been submitted

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
    _namaInspektorFocusNode = FocusNode();
    _namaCustomerFocusNode = FocusNode();
    _cabangInspeksiFocusNode = FocusNode();
    _tanggalInspeksiFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    _namaInspektorFocusNode.dispose();
    _namaCustomerFocusNode.dispose();
    _cabangInspeksiFocusNode.dispose();
    _tanggalInspeksiFocusNode.dispose();
    super.dispose();
  }


  moveToNextPage() {
    // Wrap the next page with CommonLayout as well
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CommonLayout(child: PageTwo()), // Wrap PageTwo
      ),
    );
  }

  void validateAndMoveToNextPage() {
    setState(() {
      _formSubmitted = true; // Mark the form as submitted
    });
    if (_formKey.currentState!.validate()) {
      // If the form is valid, display a snackbar. In a real app,
      // you would save the data and navigate to the next page.
      moveToNextPage(); // Move to the next page if validation passes
    }
  }


  @override
  Widget build(BuildContext context) {
    final formData = ref.watch(formProvider); // Watch the form data
    final formNotifier = ref.read(formProvider.notifier); // Read the notifier

    // Return the core content Column directly. Scaffold/SafeArea are in CommonLayout.
    // The GestureDetector for unfocus is removed; can be added to CommonLayout if needed globally.
    return FocusScope(
      node: _focusScopeNode,
      child: Form( // Wrap with Form widget
        key: _formKey, // Assign the form key
        child: Column( // This Column is now the root widget returned by PageOne's build method
          children: [
            // Expanded takes up available space, pushing footer down
            Expanded(
              // Removed the Container with margin, CommonLayout handles padding
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageNumber(data: '1/9'),
                    const SizedBox(height: 8.0),
                    PageTitle(data: 'Identitas'),
                    const SizedBox(height: 24.0), // Keep internal spacing
                    LabeledTextField(
                      label: 'Nama Inspektor',
                      hintText: 'Masukkan nama inspektor',
                      focusNode: _namaInspektorFocusNode,
                      initialValue: formData.namaInspektor, // Initialize with data from provider
                      onChanged: (value) {
                        formNotifier.updateNamaInspektor(value); // Update data in provider
                      },
                      validator: (value) {
                        if (_formSubmitted && (value == null || value.isEmpty)) {
                          return 'Nama Inspektor belum terisi'; // Validation message
                        }
                        return null; // Return null if valid
                      },
                      formSubmitted: _formSubmitted, // Pass the formSubmitted flag
                    ),
                    const SizedBox(height: 16.0), // Keep internal spacing
                    LabeledTextField(
                      label: 'Nama Customer',
                      hintText: 'Masukkan nama customer',
                      focusNode: _namaCustomerFocusNode,
                      initialValue: formData.namaCustomer, // Initialize with data from provider
                      onChanged: (value) {
                        formNotifier.updateNamaCustomer(value); // Update data in provider
                      },
                       validator: (value) {
                        if (_formSubmitted && (value == null || value.isEmpty)) {
                          return 'Nama Customer belum terisi'; // Validation message
                        }
                        return null; // Return null if valid
                      },
                      formSubmitted: _formSubmitted, // Pass the formSubmitted flag
                    ),
                    const SizedBox(height: 16.0), // Keep internal spacing
                    LabeledTextField(
                      label: 'Cabang Inspeksi',
                      hintText: 'Contoh: Yogyakarta / Semarang',
                      focusNode: _cabangInspeksiFocusNode,
                      initialValue: formData.cabangInspeksi, // Initialize with data from provider
                       onChanged: (value) {
                        formNotifier.updateCabangInspeksi(value); // Update data in provider
                      },
                       validator: (value) {
                        if (_formSubmitted && (value == null || value.isEmpty)) {
                          return 'Cabang Inspeksi belum terisi'; // Validation message
                        }
                        return null; // Return null if valid
                      },
                      formSubmitted: _formSubmitted, // Pass the formSubmitted flag
                    ),
                    const SizedBox(height: 16.0), // Keep internal spacing
                    LabeledDateField(
                      label: 'Tanggal Inspeksi',
                      hintText: 'Pilih tanggal inspeksi',
                      initialDate: formData.tanggalInspeksi, // Initialize with data from provider
                      onChanged: (date) {
                        formNotifier.updateTanggalInspeksi(date); // Update data in provider
                      },
                      focusNode: _tanggalInspeksiFocusNode,
                       validator: (date) {
                        if (_formSubmitted && date == null) {
                          return 'Tanggal Inspeksi belum terisi'; // Validation message
                        }
                        return null; // Return null if valid
                        },
                      formSubmitted: _formSubmitted, // Pass the formSubmitted flag
                    ),
                    const SizedBox(height: 32.0), // Keep internal spacing
                    // Pass isBackButtonEnabled: false for PageOne
                    NavigationButtonRow(
                      onNextPressed: validateAndMoveToNextPage, // Call validation function
                      isBackButtonEnabled: false, // Hide back button on page 1
                      // Add onBackPressed: null explicitly if needed, though it won't be used when hidden
                      // onBackPressed: null,
                    ),
                    SizedBox(height: 32.0), // Optional spacing below the content
                    // Footer
                    Footer(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
