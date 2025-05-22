import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/services/api_service.dart'; // Ensure UploadableImage is accessible or define it here
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/form_confirmation.dart';
import 'package:form_app/providers/form_step_provider.dart';
import 'package:form_app/providers/image_data_provider.dart';

// Placeholder for Page Nine
class PageNine extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKeyPageOne;
  final GlobalKey<FormState> formKeyPageTwo;
  final ValueNotifier<bool> formSubmittedPageOne;
  final ValueNotifier<bool> formSubmittedPageTwo;
  final Map<int, String> pageNames;
  final String? Function(int pageIndex) validatePage;

  const PageNine({
    super.key,
    required this.formKeyPageOne,
    required this.formKeyPageTwo,
    required this.formSubmittedPageOne,
    required this.formSubmittedPageTwo,
    required this.pageNames,
    required this.validatePage,
  });

  @override
  ConsumerState<PageNine> createState() => _PageNineState();
}

class _PageNineState extends ConsumerState<PageNine> with AutomaticKeepAliveClientMixin {
  bool _isChecked = false;
  bool _isLoading = false;

  final List<String> tambahanImageIdentifiers = [
    'General Tambahan',
    'Eksterior Tambahan',
    'Interior Tambahan',
    'Mesin Tambahan',
    'Kaki-kaki Tambahan',
    'Alat-alat Tambahan',
    'Foto Dokumen', // Assuming 'Foto Dokumen' is one of the identifiers for TambahanImageData
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

    widget.formSubmittedPageOne.value = true;
    widget.formSubmittedPageTwo.value = true;

    List<String> validationErrors = [];
    int? firstErrorPageIndex;

    final pageOneError = widget.validatePage(0);
    if (pageOneError != null) {
      validationErrors.add(pageOneError);
      firstErrorPageIndex ??= 0;
    }

    final pageTwoError = widget.validatePage(1);
    if (pageTwoError != null) {
      validationErrors.add(pageTwoError);
      firstErrorPageIndex ??= 1;
    }

    if (validationErrors.isNotEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            validationErrors.join('\n'),
            style: subTitleTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      if (firstErrorPageIndex != null) {
        ref.read(formStepProvider.notifier).state = firstErrorPageIndex;
      }
      setState(() {
        _isLoading = false;
      });
      return;
    }

    String? inspectionId;
    try {
      final formData = ref.read(formProvider);
      final apiService = ApiService();

      final Map<String, dynamic> formDataResponse = await apiService.submitFormData(formData);
      inspectionId = formDataResponse['id'] as String?;

      if (inspectionId == null || inspectionId.isEmpty) {
        throw Exception('Inspection ID not received from server.');
      }

      if (!mounted) return;
      setState(() {
      });

      // Collect all images
      List<UploadableImage> allImagesToUpload = [];

      // 1. Wajib Images
      final wajibImages = ref.read(imageDataListProvider);
      for (var imgData in wajibImages) {
        if (imgData.imagePath.isNotEmpty) { // Only add if path is not empty
            allImagesToUpload.add(UploadableImage(
            imagePath: imgData.imagePath,
            label: imgData.label,
            needAttention: imgData.needAttention,
            category: imgData.category,
            isMandatory: imgData.isMandatory,
          ));
        }
      }

      // 2. Tambahan Images
      for (final identifier in tambahanImageIdentifiers) {
        final tambahanImagesList = ref.read(tambahanImageDataProvider(identifier));
        for (var imgData in tambahanImagesList) {
           if (imgData.imagePath.isNotEmpty) { // Only add if path is not empty
            allImagesToUpload.add(UploadableImage(
              imagePath: imgData.imagePath,
              label: imgData.label,
              needAttention: imgData.needAttention,
              category: imgData.category, // Already set during creation
              isMandatory: imgData.isMandatory, // Already set
            ));
           }
        }
      }
      
      if (kDebugMode) {
        print('Total images to upload: ${allImagesToUpload.length}');
        for (var img in allImagesToUpload) {
          print('Image: ${img.label}, Path: ${img.imagePath}, Category: ${img.category}, Mandatory: ${img.isMandatory}');
        }
      }


      if (allImagesToUpload.isNotEmpty) {
        await apiService.uploadImagesInBatches(inspectionId, allImagesToUpload);
      } else {
        if (kDebugMode) {
          print('No images to upload.');
        }
      }


      // If all successful
      ref.read(formProvider.notifier).resetFormData();
      ref.read(imageDataListProvider.notifier).clearImageData();
      for (final identifier in tambahanImageIdentifiers) {
        ref.read(tambahanImageDataProvider(identifier).notifier).clearAll();
      }

      if (!mounted) return;
      ref.read(formStepProvider.notifier).state++; // Move to finished page

    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Terjadi kesalahan: $e', // Display specific error
            style: subTitleTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        SingleChildScrollView(
          key: const PageStorageKey<String>('pageNineScrollKey'),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PageNumber(data: '9/9'),
              const SizedBox(height: 4),
              PageTitle(data: 'Finalisasi'),
              const SizedBox(height: 6.0),
              Text(
                'Pastikan data yang telah diisi telah sesuai dengan yang sebenarnya dan memenuhi SOP PT Inspeksi Mobil Jogja',
                style: labelStyle.copyWith(
                  fontWeight: FontWeight.w300,
                ),
              ),
              const SizedBox(height: 16.0),
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
        const Spacer(),
        NavigationButtonRow(
          onBackPressed: () => ref.read(formStepProvider.notifier).state--,
          isLastPage: true,
          onNextPressed: _submitForm,
          isFormConfirmed: _isChecked,
          isLoading: _isLoading,
          // Optional: Pass _loadingMessage to NavigationButtonRow if it can display it
          // nextButtonText: _isLoading ? _loadingMessage : 'Kirim', // Example
        ),
        const SizedBox(height: 24.0),
        const Footer(),
      ],
    );
  }
}