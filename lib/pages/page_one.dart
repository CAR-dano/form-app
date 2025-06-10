import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/inspector_data.dart';
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/providers/inspection_branches_provider.dart'; // Import the provider for branches
import 'package:form_app/providers/inspector_provider.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_date_input_field.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/models/inspection_branch.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/labeled_dropdown_field.dart'; // Use the refactored generic LabeledDropdownField

class PageOne extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> formSubmitted; // New parameter

  const PageOne({
    super.key,
    required this.formKey,
    required this.formSubmitted, // Update constructor
  });

  @override
  ConsumerState<PageOne> createState() => _PageOneState();
}

class _PageOneState extends ConsumerState<PageOne> with AutomaticKeepAliveClientMixin {
  late FocusScopeNode _focusScopeNode;

  @override
  bool get wantKeepAlive => true;

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
              clipBehavior: Clip.none,
              key: const PageStorageKey<String>('pageOneScrollKey'), // Add PageStorageKey here
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '1/26'),
                  const SizedBox(height: 4),
                  PageTitle(data: 'Identitas'),
                  const SizedBox(height: 6.0),
                  LabeledDropdownField<Inspector>( // Change generic type to Inspector
                      label: 'Nama Inspektor',
                      itemsProvider: inspectorProvider, // Use the new provider
                      value: formData.selectedInspector,
                      itemText: (inspector) => inspector.name,
                      onChanged: (newValue) {
                        formNotifier.updateSelectedInspector(newValue);
                        if (widget.formSubmitted.value) {
                          widget.formKey.currentState?.validate();
                        }
                      },
                      validator: (value) {
                        final inspectorsState = ref.read(inspectorProvider);
                        if (widget.formSubmitted.value &&
                            value == null &&
                            inspectorsState is AsyncData<List<Inspector>> &&
                            inspectorsState.value.isNotEmpty) {
                          return 'Nama Inspektor belum terisi';
                        }
                        return null;
                      },
                      initialHintText: 'Pilih nama inspektor',
                      loadingHintText: 'Memuat inspektor...',
                      emptyDataHintText: 'Tidak ada inspektor tersedia',
                      errorHintText: 'Gagal memuat inspektor',
                    ),
                  const SizedBox(height: 16.0),
                  LabeledTextField(
                    label: 'Nama Customer',
                    hintText: 'Masukkan nama customer',
                    initialValue: formData.namaCustomer,
                    onChanged: (value) {
                      formNotifier.updateNamaCustomer(value);
                    },
                    validator: (value) {
                      if (widget.formSubmitted.value &&
                          (value == null || value.isEmpty)) {
                        return 'Nama Customer belum terisi';
                      }
                      return null;
                    },
                    formSubmitted: widget.formSubmitted.value,
                  ),
                  const SizedBox(height: 16.0),
                  LabeledDropdownField<InspectionBranch>(
                    label: 'Cabang Inspeksi',
                    itemsProvider: inspectionBranchesProvider,
                    value: formData.cabangInspeksi,
                    itemText: (branch) => branch.city,
                    onChanged: (newValue) {
                      formNotifier.updateCabangInspeksi(newValue);
                      if (widget.formSubmitted.value) {
                        widget.formKey.currentState?.validate();
                      }
                    },
                    validator: (value) {
                      final branchesState = ref.read(inspectionBranchesProvider);
                      if (widget.formSubmitted.value &&
                          value == null &&
                          branchesState is AsyncData<List<InspectionBranch>> &&
                          branchesState.value.isNotEmpty) {
                        return 'Cabang Inspeksi belum terisi';
                      }
                      return null;
                    },
                    initialHintText: 'Pilih cabang inspeksi',
                    loadingHintText: 'Memuat cabang...',
                    emptyDataHintText: 'Tidak ada cabang tersedia',
                    errorHintText: 'Gagal memuat cabang',
                  ),
                  const SizedBox(height: 16.0),
                  LabeledDateInputField(
                    label: 'Tanggal Inspeksi',
                    hintText: 'DD/MM/YYYY',
                    initialValue: formData.tanggalInspeksi != null 
                        ? '${formData.tanggalInspeksi!.day.toString().padLeft(2, '0')}/${formData.tanggalInspeksi!.month.toString().padLeft(2, '0')}/${formData.tanggalInspeksi!.year}'
                        : null,
                    onChanged: (date) {
                      formNotifier.updateTanggalInspeksi(date);
                    },
                    validator: (dateString) {
                      if (widget.formSubmitted.value && (dateString == null || dateString.isEmpty)) {
                        return 'Tanggal Inspeksi belum terisi';
                      }
                      return null;
                    },
                    formSubmitted: widget.formSubmitted.value,
                  ),
                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    isBackButtonEnabled: false,
                    onNextPressed: () {
                      _focusScopeNode.unfocus();
                      ref.read(formStepProvider.notifier).state++;
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
