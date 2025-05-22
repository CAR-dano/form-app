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
  final String? Function(int pageIndex) validatePage; // New parameter

  const PageNine({
    super.key,
    required this.formKeyPageOne,
    required this.formKeyPageTwo,
    required this.formSubmittedPageOne,
    required this.formSubmittedPageTwo,
    required this.pageNames,
    required this.validatePage, // Update constructor
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
    if (_isLoading) {
      return;
    }

    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Harap setujui pernyataan di atas sebelum melanjutkan.',
            style: subTitleTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    // Set formSubmitted to true for Page One and Page Two to show validation messages
    widget.formSubmittedPageOne.value = true;
    widget.formSubmittedPageTwo.value = true;

    List<String> validationErrors = [];
    int? firstErrorPageIndex;

    // Validate Page One
    final pageOneError = widget.validatePage(0);
    if (pageOneError != null) {
      validationErrors.add(pageOneError);
      firstErrorPageIndex ??= 0;
    }

    // Validate Page Two
    final pageTwoError = widget.validatePage(1);
    if (pageTwoError != null) {
      validationErrors.add(pageTwoError);
      firstErrorPageIndex ??= 1; // Only set if it's the first error found
    }

    if (validationErrors.isNotEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            validationErrors.join('\n'), // Join all error messages
            style: subTitleTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5), // Give more time for multiple messages
        ),
      );
      // Navigate to the first page that failed validation
      if (firstErrorPageIndex != null) {
        ref.read(formStepProvider.notifier).state = firstErrorPageIndex;
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }

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
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Terjadi kesalahan saat mengirim data: $e',
            style: subTitleTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
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
