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
  const PageNine({super.key});

  @override
  ConsumerState<PageNine> createState() => _PageNineState();
}

class _PageNineState extends ConsumerState<PageNine> with AutomaticKeepAliveClientMixin { // Add mixin
  bool _isChecked = false;
  bool _isLoading = false; // Add loading state

  @override
  bool get wantKeepAlive => true; // Override wantKeepAlive

  Future<void> _submitForm() async {
    if (_isLoading || !_isChecked) { // Prevent multiple submissions while loading
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap setujui pernyataan untuk melanjutkan.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true; // Set loading state to true
    });

    try {
      final formData = ref.read(formProvider);
      final apiService =
          ApiService(); // Consider providing ApiService via Riverpod as well

      await apiService.submitFormData(formData);

      // Clear stored data after successful submission
      ref.read(formProvider.notifier).resetFormData();
      ref.read(imageDataListProvider.notifier).clearImageData();
      ref.read(tambahanImageDataProvider.notifier).clearAll();

      if (!mounted) return;
      // Navigate to the FinishedPage by updating the form step
      ref.read(formStepProvider.notifier).state++;
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Gagal mengirim formulir: $e'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false; // Reset loading state
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
