import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/services/api_service.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/form_confirmation.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/providers/image_data_provider.dart';

// Placeholder for Page Nine
class PageNine extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKeyPageOne;
  final GlobalKey<FormState> formKeyPageTwo;
  final ValueNotifier<bool> formSubmittedPageOne;
  final ValueNotifier<bool> formSubmittedPageTwo;
  final Map<int, String> pageNames;
  final bool Function(int pageIndex) validateAndShowSnackbar; // New parameter

  const PageNine({
    super.key,
    required this.formKeyPageOne,
    required this.formKeyPageTwo,
    required this.formSubmittedPageOne,
    required this.formSubmittedPageTwo,
    required this.pageNames,
    required this.validateAndShowSnackbar, // Update constructor
  });

  @override
  ConsumerState<PageNine> createState() => _PageNineState();
}

class _PageNineState extends ConsumerState<PageNine> with AutomaticKeepAliveClientMixin {
  bool _isChecked = false;
  bool _isLoading = false;

  final List<String> tambahanImageIdentifiers = [
    'general_tambahan',
    'eksterior_tambahan',
    'interior_tambahan',
    'mesin_tambahan',
    'kaki_kaki_tambahan',
    'alat_alat_tambahan',
    'foto_dokumen',
  ];

  @override
  bool get wantKeepAlive => true;

  Future<void> _submitForm() async {
    if (_isLoading || !_isChecked) {
      // Use the passed validateAndShowSnackbar for the initial check
      widget.validateAndShowSnackbar(-1); // Use a dummy index or handle this case in MultiStepFormScreen
      return;
    }

    // Set formSubmitted to true for Page One and Page Two
    widget.formSubmittedPageOne.value = true;
    widget.formSubmittedPageTwo.value = true;

    // Validate Page One using the passed function
    if (!widget.validateAndShowSnackbar(0)) {
      return;
    }

    // Validate Page Two using the passed function
    if (!widget.validateAndShowSnackbar(1)) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final formData = ref.read(formProvider);
      final apiService = ApiService();

      await apiService.submitFormData(formData);

      ref.read(formProvider.notifier).resetFormData();
      ref.read(imageDataListProvider.notifier).clearImageData();
      for (final identifier in tambahanImageIdentifiers) {
        ref.read(tambahanImageDataProvider(identifier).notifier).clearAll();
      }

      if (!mounted) return;
      ref.read(formStepProvider.notifier).state++;
    } catch (e) {
      if (!mounted) return;
      // Use the passed validateAndShowSnackbar for error messages
      widget.validateAndShowSnackbar(-2); // Use a dummy index or handle this case in MultiStepFormScreen
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    return Column(
      children: [
        SingleChildScrollView(
          key: const PageStorageKey<String>('pageNineScrollKey'), // Add PageStorageKey here
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageNumber(data: '9/9'),
              const SizedBox(height: 4),
              PageTitle(data: 'Finalisasi'), // Placeholder Title
              const SizedBox(height: 6.0),
              Text(
                'Pastikan data yang telah diisi telah sesuai dengan yang sebenarnya dan memenuhi SOP PT Inspeksi Mobil Jogja',
                style: labelStyle.copyWith(
                  fontWeight: FontWeight.w300,
                ), // Corrected font weight
              ),
              const SizedBox(height: 16.0), // Added spacing
              FormConfirmation(
                label: 'Data yang saya isi telah sesuai',
                initialValue: _isChecked,
                onChanged: (bool newValue) {
                  setState(() {
                    _isChecked = newValue;
                  });
                },
              ),
              const SizedBox(height: 32.0),
            ],
          ),
        ),
        Spacer(),
        NavigationButtonRow(
          onBackPressed: () => ref.read(formStepProvider.notifier).state--,
          isLastPage:
              true, // This will make the button text "Selesai" or similar
          onNextPressed:
              _submitForm, // _submitForm will now update formStepProvider on success
          isFormConfirmed: _isChecked,
          isLoading: _isLoading, // Pass loading state to disable button
        ),
        const SizedBox(height: 24.0), // Optional spacing below the content
        // Footer
        Footer(),
      ],
    );
  }
}
