import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/providers/inspection_branches_provider.dart'; // Import the provider for branches
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_date_field.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/labeled_dropdown_field.dart'; // Use the refactored generic LabeledDropdownField

class PageOne extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey; // Add formKey parameter

  const PageOne({super.key, required this.formKey}); // Update constructor

  @override
  ConsumerState<PageOne> createState() => _PageOneState();
}

class _PageOneState extends ConsumerState<PageOne> with AutomaticKeepAliveClientMixin { // Add mixin
  late FocusScopeNode _focusScopeNode;
  // Removed local state for branches, loading, and error

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  bool _formSubmitted = false; // Track if the form has been submitted

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
    // Fetching is handled by FutureProvider, no need to call _fetchBranches here
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final formData = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    // No longer need to watch inspectionBranchesProvider directly here for the UI part of the dropdown.
    // LabeledBranchesDropdownField will handle it.

    // The GestureDetector for unfocus is removed; can be added to CommonLayout if needed globally.
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
              key: const PageStorageKey<String>('pageOneScrollKey'), // Add PageStorageKey here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '1/9'),
                  const SizedBox(height: 4),
                  PageTitle(data: 'Identitas'),
                  const SizedBox(height: 6.0),
                  LabeledTextField(
                    label: 'Nama Inspektor',
                    hintText: 'Masukkan nama inspektor',
                    initialValue:
                        formData
                            .namaInspektor, // Initialize with data from provider
                    onChanged: (value) {
                      formNotifier.updateNamaInspektor(
                        value,
                      ); // Update data in provider
                    },
                    validator: (value) {
                      if (_formSubmitted &&
                          (value == null || value.isEmpty)) {
                        return 'Nama Inspektor belum terisi'; // Validation message
                      }
                      return null; // Return null if valid
                    },
                    formSubmitted:
                        _formSubmitted, // Pass the formSubmitted flag
                  ),
                  const SizedBox(height: 16.0), // Keep internal spacing
                  LabeledTextField(
                    label: 'Nama Customer',
                    hintText: 'Masukkan nama customer',
                    initialValue:
                        formData
                            .namaCustomer, // Initialize with data from provider
                    onChanged: (value) {
                      formNotifier.updateNamaCustomer(
                        value,
                      ); // Update data in provider
                    },
                    validator: (value) {
                      if (_formSubmitted &&
                          (value == null || value.isEmpty)) {
                        return 'Nama Customer belum terisi'; // Validation message
                      }
                      return null; // Return null if valid
                    },
                    formSubmitted:
                        _formSubmitted, // Pass the formSubmitted flag
                  ),
                  const SizedBox(height: 16.0), // Keep internal spacing
                  LabeledDropdownField<String>( // Use the refactored LabeledDropdownField
                    label: 'Cabang Inspeksi',
                    itemsProvider: inspectionBranchesProvider, // Pass the provider
                    value: formData.cabangInspeksi,
                    onChanged: (newValue) {
                      formNotifier.updateCabangInspeksi(newValue);
                      if (_formSubmitted) {
                        widget.formKey.currentState?.validate();
                      }
                    },
                    validator: (value) {
                      final branchesState = ref.read(inspectionBranchesProvider);
                      // Only validate if branches are loaded and not empty
                      if (_formSubmitted && value == null && branchesState is AsyncData<List<String>> && branchesState.value.isNotEmpty) {
                        return 'Cabang Inspeksi belum terisi';
                      }
                      return null;
                    },
                    initialHintText: 'Pilih cabang inspeksi',
                    loadingHintText: 'Memuat cabang...',
                    emptyDataHintText: 'Tidak ada cabang tersedia',
                    errorHintText: 'Gagal memuat cabang',
                  ),
                  const SizedBox(height: 16.0), // Keep internal spacing
                  LabeledDateField(
                    label: 'Tanggal Inspeksi',
                    hintText: 'Pilih tanggal inspeksi',
                    initialDate:
                        formData
                            .tanggalInspeksi, // Initialize with data from provider
                    onChanged: (date) {
                      formNotifier.updateTanggalInspeksi(
                        date,
                      ); // Update data in provider
                    },
                    validator: (date) {
                      if (_formSubmitted && date == null) {
                        return 'Tanggal Inspeksi belum terisi'; // Validation message
                      }
                      return null; // Return null if valid
                    },
                    formSubmitted:
                        _formSubmitted, // Pass the formSubmitted flag
                  ),
                  const SizedBox(height: 32.0), // Keep internal spacing
                  NavigationButtonRow(
                    isBackButtonEnabled: false, // PageOne has no back button
                    onNextPressed: () {
                      setState(() {
                        _formSubmitted = true;
                      });
                      if (widget.formKey.currentState?.validate() ?? false) {
                        _focusScopeNode.unfocus();
                        ref.read(formStepProvider.notifier).state++;
                      }
                    },
                    // onBackPressed will be null due to isBackButtonEnabled: false
                  ),
                  const SizedBox(height: 24.0), // Optional spacing below the content
                  // Footer
                  Footer(),
                ],
              ),
            ),
          ), // Closing parenthesis for GestureDetector
        ),
      ),
    );
  }
}
