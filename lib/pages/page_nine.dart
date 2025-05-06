import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/services/api_service.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/custom_checkbox_tile.dart';

// Placeholder for Page Nine
class PageNine extends ConsumerStatefulWidget {
  const PageNine({super.key});

  @override
  ConsumerState<PageNine> createState() => _PageNineState();
}

class _PageNineState extends ConsumerState<PageNine> {
  bool _isChecked = false;
  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (!_isChecked) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Harap setujui pernyataan untuk melanjutkan.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      final formData = ref.read(formProvider);
      final apiService = ApiService(); // Consider providing ApiService via Riverpod as well

      // TODO: Before calling submitFormData, ensure all TODOs within ApiService.submitFormData are addressed
      // For now, we call it as is.
      await apiService.submitFormData(formData);

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Formulir berhasil dikirim!'),
          backgroundColor: Colors.green,
        ),
      );
      // Optionally, navigate to a success page or clear the form
      // Navigator.of(context).popUntil((route) => route.isFirst); // Example: Pop to first page
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
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '9/9'),
                  const SizedBox(height: 8.0),
                  PageTitle(data: 'Finalisasi'), // Placeholder Title
                  const SizedBox(height: 16.0),
                  Text(
                    'Pastikan data yang telah diisi telah sesuai dengan yang sebenarnya dan memenuhi SOP PT Inspeksi Mobil Jogja',
                    style: labelStyle.copyWith(fontWeight: FontWeight.w300), // Corrected font weight
                  ),
                  const SizedBox(height: 16.0), // Added spacing
                  CustomCheckboxTile(
                    label: 'Data yang saya isi telah sesuai',
                    initialValue: _isChecked,
                    onChanged: (bool newValue) {
                      setState(() {
                        _isChecked = newValue;
                      });
                    },
                  ),
                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    isLastPage: true,
                    onNextPressed: _isLoading ? () {} : _submitForm, // Disable button when loading
                    // TODO: Pass _isLoading to NavigationButtonRow if it supports a loading state for the button
                  ),
                  if (_isLoading) ...[
                    const SizedBox(height: 16),
                    const Center(child: CircularProgressIndicator()),
                  ],
                  const SizedBox(
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
    );
  }
}
