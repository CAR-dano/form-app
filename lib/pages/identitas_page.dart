import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/inspector_data.dart';
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/providers/inspection_branches_provider.dart'; // Import the provider for branches
import 'package:form_app/providers/inspector_provider.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_text.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/models/inspection_branch.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/labeled_dropdown_field.dart'; // Use the refactored generic LabeledDropdownField

class IdentitasPage extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> formSubmitted;

  const IdentitasPage({
    super.key,
    required this.formKey,
    required this.formSubmitted,
  });

  @override
  ConsumerState<IdentitasPage> createState() => _IdentitasPageState();
}

class _IdentitasPageState extends ConsumerState<IdentitasPage> with AutomaticKeepAliveClientMixin {
  late FocusScopeNode _focusScopeNode;
  bool _hasValidatedOnSubmit = false; // Declare the state variable

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

    var hariIni = '${DateTime.now().day.toString().padLeft(2, '0')}/'
                           '${DateTime.now().month.toString().padLeft(2, '0')}/'
                           '${DateTime.now().year}';
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
        child: ValueListenableBuilder<bool>( // Add ValueListenableBuilder here
          valueListenable: widget.formSubmitted,
          builder: (context, isFormSubmitted, child) {
            if (isFormSubmitted && !_hasValidatedOnSubmit) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  widget.formKey.currentState?.validate();
                  setState(() {
                    _hasValidatedOnSubmit = true;
                  });
                }
              });
            }
            return Form(
              key: widget.formKey,
              child: child!, // Pass the original child
            );
          },
          child: GestureDetector( // This becomes the child of ValueListenableBuilder
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
                  const PageTitle(data: 'Identitas'),
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
                        if (widget.formSubmitted.value && value == null) {
                          return 'Nama Inspektor belum terisi';
                        }
                        return null;
                      },
                      initialHintText: 'Pilih nama inspektor',
                      loadingHintText: 'Memuat inspektor...',
                      emptyDataHintText: 'Tidak ada inspektor tersedia',
                      errorHintText: 'Gagal memuat inspektor',
                      formSubmitted: widget.formSubmitted.value, // Pass formSubmitted
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
                      if (widget.formSubmitted.value && value == null) {
                        return 'Cabang Inspeksi belum terisi';
                      }
                      return null;
                    },
                    initialHintText: 'Pilih cabang inspeksi',
                    loadingHintText: 'Memuat cabang...',
                    emptyDataHintText: 'Tidak ada cabang tersedia',
                    errorHintText: 'Gagal memuat cabang',
                    formSubmitted: widget.formSubmitted.value, // Pass formSubmitted
                  ),
                  const SizedBox(height: 16.0),
                  LabeledText(
                    label: 'Tanggal Inspeksi',
                    value: hariIni,
                  ),
                  const SizedBox(height: 32.0),
                  
                  const Footer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
