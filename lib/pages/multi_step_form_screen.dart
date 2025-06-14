import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_step_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart'; // Import the provider
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/multi_step_form_navbar.dart';
// Import all form pages
import 'package:form_app/pages/page_one.dart';
import 'package:form_app/pages/page_two.dart';
import 'package:form_app/pages/page_three.dart';
import 'package:form_app/pages/page_four.dart';
import 'package:form_app/pages/page_five_one.dart';
import 'package:form_app/pages/page_five_two.dart';
import 'package:form_app/pages/page_five_three.dart';
import 'package:form_app/pages/page_five_four.dart';
import 'package:form_app/pages/page_five_five.dart';
import 'package:form_app/pages/page_five_six.dart';
import 'package:form_app/pages/page_five_seven.dart';
import 'package:form_app/pages/page_six_general_wajib.dart';
//import 'package:form_app/pages/page_six_general_tambahan.dart';
// import 'package:form_app/pages/page_six_eksterior_wajib.dart';
import 'package:form_app/pages/page_six_eksterior_tambahan.dart';
// import 'package:form_app/pages/page_six_interior_wajib.dart';
import 'package:form_app/pages/page_six_interior_tambahan.dart';
// import 'package:form_app/pages/page_six_mesin_wajib.dart';
import 'package:form_app/pages/page_six_mesin_tambahan.dart';
// import 'package:form_app/pages/page_six_kaki_kaki_wajib.dart';
import 'package:form_app/pages/page_six_kaki_kaki_tambahan.dart';
// import 'package:form_app/pages/page_six_alat_alat_wajib.dart';
import 'package:form_app/pages/page_six_alat_alat_tambahan.dart';
import 'package:form_app/pages/page_seven.dart';
import 'package:form_app/pages/page_eight.dart';
import 'package:form_app/pages/page_nine.dart';
import 'package:form_app/pages/finished.dart';
import 'package:form_app/providers/form_provider.dart'; // For form data
import 'package:form_app/services/api_service.dart'; // For API calls
import 'package:form_app/statics/app_styles.dart'; // For text styles
import 'package:form_app/providers/image_data_provider.dart'; // For wajib images
import 'package:form_app/providers/image_processing_provider.dart'; // For image processing status
import 'package:form_app/providers/page_navigation_provider.dart'; // Import the provider
import 'package:form_app/providers/submission_status_provider.dart'; // Import the new provider
import 'package:form_app/providers/submission_data_cache_provider.dart'; // Import the new cache provider

class MultiStepFormScreen extends ConsumerStatefulWidget {
  const MultiStepFormScreen({super.key});

  @override
  ConsumerState<MultiStepFormScreen> createState() => _MultiStepFormScreenState();
}

class _MultiStepFormScreenState extends ConsumerState<MultiStepFormScreen> {
  final List<GlobalKey<FormState>> _formKeys = List.generate(27, (_) => GlobalKey<FormState>());

  final ValueNotifier<bool> _formSubmittedPageOne = ValueNotifier<bool>(false);
  static const String _defaultTambahanLabel = 'Foto Tambahan';
  final ValueNotifier<bool> _formSubmittedPageTwo = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _formSubmittedTambahanImages = ValueNotifier<bool>(false);

  // Mapping from _formKeys index to _formPages index
  final Map<int, int> _formKeyIndexToPageIndex = {
    0: 0, // _formKeys[0] (PageOne) is at _formPages[0]
    14: 9, // _formKeys[14] (PageTwo) is at _formPages[9]
  };

  // State variables for submission logic (moved from PageNine)
  bool _isChecked = false; // For the confirmation checkbox on PageNine

  // Combined list of page indices that need validation (moved from PageNine)
  List<int> get _pagesToValidate => [
    0, // PageOne
    14, // PageTwo
    // Removed validation for Tambahan Image pages as per user request
  ];

  late final List<Widget> _formPages;

  final Map<int, String> _pageNames = {
    0: 'Identitas', // PageOne
    7: 'Foto General (Tambahan)', // PageSixGeneralTambahan
    8: 'Foto Eksterior (Tambahan)', // PageSixEksteriorTambahan
    9: 'Foto Interior (Tambahan)', // PageSixInteriorTambahan
    10: 'Foto Mesin (Tambahan)', // PageSixMesinTambahan
    11: 'Foto Kaki-kaki (Tambahan)', // PageSixKakiKakiTambahan
    12: 'Foto Alat-alat (Tambahan)', // PageSixAlatAlatTambahan
    13: 'Foto Dokumen', // PageSeven
    14: 'Data Kendaraan', // PageTwo
  };

  final Map<int, String> _tambahanImagePageIdentifiers = {
    7: 'General Tambahan',
    8: 'Eksterior Tambahan',
    9: 'Interior Tambahan',
    10: 'Mesin Tambahan',
    11: 'Kaki-kaki Tambahan',
    12: 'Alat-alat Tambahan',
    13: 'Foto Dokumen',
  };

  @override
  void initState() {
    super.initState();

    // Pre-cache checker.png
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        precacheImage(const AssetImage('assets/images/checker.png'), context);
      }
    });

    _formPages = [
      PageOne(key: const ValueKey('PageOne'), formKey: _formKeys[0], formSubmitted: _formSubmittedPageOne, currentPage: 1, totalPages: 20),
      const PageSixGeneralWajib(key: ValueKey('PageSixGeneralWajib'), currentPage: 2, totalPages: 20),
      PageSixEksteriorTambahan(key: const ValueKey('PageSixEksteriorTambahan'), formSubmitted: _formSubmittedTambahanImages, currentPage: 3, totalPages: 20),
      const PageEight(key: ValueKey('PageEight'), currentPage: 4, totalPages: 20),
      PageSixInteriorTambahan(key: const ValueKey('PageSixInteriorTambahan'), formSubmitted: _formSubmittedTambahanImages, currentPage: 5, totalPages: 20),
      PageSixMesinTambahan(key: const ValueKey('PageSixMesinTambahan'), formSubmitted: _formSubmittedTambahanImages, currentPage: 6, totalPages: 20),
      PageSixKakiKakiTambahan(key: const ValueKey('PageSixKakiKakiTambahan'), formSubmitted: _formSubmittedTambahanImages, currentPage: 7, totalPages: 20),
      PageSixAlatAlatTambahan(key: const ValueKey('PageSixAlatAlatTambahan'), formSubmitted: _formSubmittedTambahanImages, currentPage: 8, totalPages: 20),
      PageSeven(key: const ValueKey('PageSeven'), formSubmitted: _formSubmittedTambahanImages, defaultLabel: _defaultTambahanLabel, currentPage: 9, totalPages: 20),
      PageTwo(key: const ValueKey('PageTwo'), formKey: _formKeys[14], formSubmitted: _formSubmittedPageTwo, currentPage: 10, totalPages: 20),
      const PageThree(key: ValueKey('PageThree'), currentPage: 11, totalPages: 20),
      const PageFour(key: ValueKey('PageFour'), currentPage: 12, totalPages: 20),
      const PageFiveOne(key: ValueKey('PageFiveOne'), currentPage: 13, totalPages: 20),
      const PageFiveTwo(key: ValueKey('PageFiveTwo'), currentPage: 14, totalPages: 20),
      const PageFiveThree(key: ValueKey('PageFiveThree'), currentPage: 15, totalPages: 20),
      const PageFiveFour(key: ValueKey('PageFiveFour'), currentPage: 16, totalPages: 20),
      const PageFiveFive(key: ValueKey('PageFiveFive'), currentPage: 17, totalPages: 20),
      const PageFiveSix(key: ValueKey('PageFiveSix'), currentPage: 18, totalPages: 20),
      const PageFiveSeven(key: ValueKey('PageFiveSeven'), currentPage: 19, totalPages: 20),
      PageNine(
        key: const ValueKey('PageNine'),
        // Pass callbacks for PageNine's internal state management
        onCheckedChange: (newValue) {
          final submissionStatus = ref.read(submissionStatusProvider); // Read the current state
          if (!submissionStatus.isLoading) {
            setState(() { _isChecked = newValue; });
          }
        },
        isChecked: _isChecked,
        currentPage: 20, // PageNine is the last page before FinishedPage
        totalPages: 20,
      ),
      const FinishedPage(key: ValueKey('FinishedPage')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(pageNavigationProvider);
    final currentPageIndex = ref.watch(formStepProvider);
    ScrollPhysics pageViewPhysics;
    if (currentPageIndex >= _formPages.length - 2) {
      pageViewPhysics = const NeverScrollableScrollPhysics();
    } else {
      pageViewPhysics = const PageScrollPhysics();
    }

    final submissionStatus = ref.watch(submissionStatusProvider);
    return Scaffold(
      resizeToAvoidBottomInset: true,
      extendBody: true, // Extend body behind the bottom navigation bar for blur effect
      body: PageView(
        controller: pageController,
        physics: pageViewPhysics,
        onPageChanged: (int page) {
          final currentActualStep = ref.read(formStepProvider);
          // Prevent swipe from PageNine to FinishedPage
          if (currentActualStep == _formPages.length - 2 && page == _formPages.length - 1) {
            pageController.jumpToPage(currentActualStep);
          } else {
            if (currentActualStep != page) {
              ref.read(formStepProvider.notifier).state = page;
            }
          }
        },
        children: _formPages.map((pageContent) {
          return CommonLayout(child: pageContent);
        }).toList(),
      ),
      bottomNavigationBar: currentPageIndex < _formPages.length - 1
          ? MultiStepFormNavbar(
              currentPageIndex: currentPageIndex,
              formPagesLength: _formPages.length,
              onNextPressed: () {
                if (currentPageIndex == _formPages.length - 2) { // PageNine
                  _submitForm(); // Call the submission logic
                } else {
                  FocusScope.of(context).unfocus();
                  ref.read(pageNavigationProvider.notifier).goToNextPage();
                }
              },
              onBackPressed: () {
                FocusScope.of(context).unfocus();
                ref.read(pageNavigationProvider.notifier).goToPreviousPage();
              },
              isLoading: submissionStatus.isLoading,
              isChecked: _isChecked,
              // Removed other parameters as they are no longer needed in MultiStepFormNavbar
            )
          : null, // Hide navigation buttons on the FinishedPage
    );
  }

  @override
  void dispose() {
    _formSubmittedPageOne.dispose();
    _formSubmittedPageTwo.dispose();
    _formSubmittedTambahanImages.dispose();
    super.dispose();
  }

  String? _validatePage(int pageIndex) {
    debugPrint('Validating page index: $pageIndex');
    if (_formKeys[pageIndex].currentState != null) {
      debugPrint('FormState for page $pageIndex is NOT null.');
      final isValid = _formKeys[pageIndex].currentState!.validate();
      debugPrint('Validation result for page $pageIndex: $isValid');
      if (!isValid) {
        return 'Harap lengkapi data di Halaman ${_pageNames[pageIndex] ?? pageIndex + 1}';
      }
    } else {
      debugPrint('FormState for page $pageIndex IS null.');
      // This case should ideally not happen for pages that are expected to be rendered.
      // If it does, it means the Form widget hasn't registered its state yet.
      // For now, we'll return an error if the form state is null for a validated page.
      return 'Form tidak siap untuk Halaman ${_pageNames[pageIndex] ?? pageIndex + 1}';
    }
    if (_tambahanImagePageIdentifiers.containsKey(pageIndex)) {
      final identifier = _tambahanImagePageIdentifiers[pageIndex]!;
      final images = ref.read(tambahanImageDataProvider(identifier));
      // Ensure defaultTambahanLabel is used correctly in comparison.
      // If an image has the default label, it's considered "empty" or not yet customized by the user.
      // The validation should check if a label is present *and* not the default placeholder if a custom one is expected.
      // For 'Foto Dokumen', isMandatory is true, so it must have *some* label if an image is present.
      // If an image is present, its label should not be the default if the user was supposed to change it.
      // Or, if the default label IS the intended final label, then this check is fine.
      // The current logic implies that if an image is present, a non-default label is expected.
      if (images.any((image) => image.label == _defaultTambahanLabel || image.label.trim().isEmpty )) {
         // If category is 'Foto Dokumen' and default label implies empty, then validate.
         if (identifier == 'Foto Dokumen' && images.any((image) => image.label == _defaultTambahanLabel && image.imagePath.isNotEmpty)) {
            return 'Label untuk "Foto Dokumen" belum diubah dari default atau kosong.';
         } else if (identifier != 'Foto Dokumen' && images.any((image) => image.label.trim().isEmpty && image.imagePath.isNotEmpty)){
            return 'Harap isi semua label gambar di Halaman ${_pageNames[pageIndex] ?? pageIndex + 1}';
         }
      }
    }
    return null;
  }

  // Moved _submitForm logic from PageNine to MultiStepFormScreen
  Future<void> _submitForm() async {
    final submissionStatus = ref.read(submissionStatusProvider); // Read the current state
    final submissionStatusNotifier = ref.read(submissionStatusProvider.notifier);
    final submissionDataCache = ref.read(submissionDataCacheProvider); // Read the cache
    final submissionDataCacheNotifier = ref.read(submissionDataCacheProvider.notifier);

    if (submissionStatus.isLoading) return;

    final isImageProcessing = ref.read(imageProcessingServiceProvider.notifier).isProcessing;
    if (isImageProcessing) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Pemrosesan gambar masih berjalan. Harap tunggu hingga selesai.',
            style: subTitleTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 3),
        ),
      );
      return;
    }

    if (!_isChecked) {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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

    submissionStatusNotifier.setLoading(
      isLoading: true,
      message: 'Memvalidasi data...',
      progress: 0.0,
    );

    _formSubmittedPageOne.value = true;
    _formSubmittedPageTwo.value = true;
    _formSubmittedTambahanImages.value = true;

    // Allow a microtask to complete, ensuring ValueNotifiers trigger rebuilds
    // and PageOne's ValueListenableBuilder has a chance to call validate()
    await Future.microtask(() {});

    List<String> validationErrors = [];
    int? firstErrorPageIndex;

    for (int pageIndex in _pagesToValidate) {
      final error = _validatePage(pageIndex); // Use _validatePage from MultiStepFormScreen
      if (error != null) {
        validationErrors.add(error);
        firstErrorPageIndex ??= pageIndex;
      }
    }

    if (validationErrors.isNotEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationErrors.join('\n'), style: subTitleTextStyle.copyWith(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      if (firstErrorPageIndex != null) {
        final int? pageViewIndex = _formKeyIndexToPageIndex[firstErrorPageIndex];
        if (pageViewIndex != null) {
          ref.read(pageNavigationProvider.notifier).jumpToPage(pageViewIndex);
        } else {
          // Fallback or log error if mapping is missing
          debugPrint('Error: No PageView index found for form key index $firstErrorPageIndex');
          ref.read(pageNavigationProvider.notifier).jumpToPage(0); // Jump to first page as a fallback
        }
      }
      submissionStatusNotifier.setLoading(isLoading: false);
      return;
    }

    String? inspectionId;
    final formDataToSubmit = ref.read(formProvider);
    final apiService = ApiService();

    // Check if form data is unchanged and an inspection ID exists
    final bool isFormDataUnchanged = submissionDataCache.lastSubmittedFormData != null &&
        formDataToSubmit == submissionDataCache.lastSubmittedFormData; // Use Equatable comparison

    if (isFormDataUnchanged && submissionDataCache.lastSubmittedInspectionId != null) {
      inspectionId = submissionDataCache.lastSubmittedInspectionId;
      debugPrint('Reusing existing inspection ID: $inspectionId');
      submissionStatusNotifier.setLoading(
        isLoading: true,
        message: 'Data formulir tidak berubah. Melanjutkan unggah gambar...',
        progress: 0.1, // Start progress as if form data was just sent
      );
    } else {
      try {
        submissionStatusNotifier.setLoading(
          isLoading: true,
          message: 'Mengirim data formulir...',
          progress: 0.1,
        );

        final Map<String, dynamic> formDataResponse = await apiService.submitFormData(formDataToSubmit);
        inspectionId = formDataResponse['id'] as String?;

        // Cache the successfully submitted form data and inspection ID
        submissionDataCacheNotifier.setCache(
          inspectionId: inspectionId,
          formData: formDataToSubmit,
        );
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).hideCurrentSnackBar();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'Terjadi kesalahan saat mengirim data formulir: $e',
              style: subTitleTextStyle.copyWith(color: Colors.white),
            ),
            backgroundColor: Colors.red,
            duration: const Duration(seconds: 5),
          ),
        );
        submissionStatusNotifier.setLoading(isLoading: false);
        return; // Exit if form data submission fails
      }
    }

    // Continue with image upload logic
    try {
      if (inspectionId == null || inspectionId.isEmpty) {
        throw Exception('Inspection ID not received or is empty after form submission.');
      }

      if (!mounted) return;

      List<UploadableImage> allImagesToUpload = [];
      final wajibImages = ref.read(imageDataListProvider);
      for (var imgData in wajibImages) {
        if (imgData.imagePath.isNotEmpty) {
          allImagesToUpload.add(UploadableImage(
            imagePath: imgData.imagePath, label: imgData.label, needAttention: imgData.needAttention,
            category: imgData.category, isMandatory: imgData.isMandatory,
          ));
        }
      }

      for (final identifier in _tambahanImagePageIdentifiers.values) { // Use _tambahanImagePageIdentifiers from MultiStepFormScreen
        final tambahanImagesList = ref.read(tambahanImageDataProvider(identifier));
        for (var imgData in tambahanImagesList) {
          if (imgData.imagePath.isNotEmpty) {
            final String labelToUse = imgData.label.isEmpty ? _defaultTambahanLabel : imgData.label; // Use _defaultTambahanLabel from MultiStepFormScreen
            allImagesToUpload.add(UploadableImage(
              imagePath: imgData.imagePath, label: labelToUse, needAttention: imgData.needAttention,
              category: imgData.category, isMandatory: imgData.isMandatory,
            ));
          }
        }
      }

      debugPrint('Total images to upload: ${allImagesToUpload.length}');
      for (var img in allImagesToUpload) {
        debugPrint('Image: ${img.label}, Path: ${img.imagePath}, Category: ${img.category}, Mandatory: ${img.isMandatory}');
      }

      if (allImagesToUpload.isNotEmpty) {
        final double formDataWeight = 0.2;
        final double imagesWeight = 0.8;

        await apiService.uploadImagesInBatches(inspectionId, allImagesToUpload,
          (int currentBatch, int totalBatchesFromCallback) {
          if (!mounted) return;
          submissionStatusNotifier.setLoading(
            isLoading: true,
            message: totalBatchesFromCallback > 0
                ? 'Mengunggah gambar batch $currentBatch dari $totalBatchesFromCallback...'
                : 'Tidak ada batch gambar untuk diunggah.',
            progress: totalBatchesFromCallback > 0
                ? formDataWeight + ((currentBatch / totalBatchesFromCallback.toDouble()) * imagesWeight)
                : 1.0,
          );
          if (currentBatch >= totalBatchesFromCallback && totalBatchesFromCallback > 0) {
            submissionStatusNotifier.setLoading(
              isLoading: true,
              message: 'Unggahan gambar selesai.',
              progress: 1.0,
            );
          }
        });
      } else {
        debugPrint('No images to upload.');
        submissionStatusNotifier.setLoading(
          isLoading: true,
          message: 'Tidak ada gambar untuk diunggah. Proses Selesai.',
          progress: 1.0,
        );
      }

      submissionStatusNotifier.setLoading(isLoading: true, message: 'Menyelesaikan...', progress: 1.0);
      ref.read(formProvider.notifier).resetFormData();
      ref.read(imageDataListProvider.notifier).clearImageData();
      for (final identifier in _tambahanImagePageIdentifiers.values) { // Use _tambahanImagePageIdentifiers from MultiStepFormScreen
        ref.read(tambahanImageDataProvider(identifier).notifier).clearAll();
      }

      if (!mounted) return;
      ref.read(formStepProvider.notifier).state++; // Navigate to FinishedPage
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Terjadi kesalahan saat mengunggah gambar: $e',
            style: subTitleTextStyle.copyWith(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      submissionStatusNotifier.setLoading(isLoading: false);
    } finally {
      submissionStatusNotifier.reset(); // Ensure loading state is reset on completion or error
      // Only clear cache if the entire process (form + images) is successful.
      // If image upload fails, we want to keep the inspectionId and form data in cache.
      // The cache should only be cleared if the user explicitly resets the form or navigates away.
      // For now, I'll remove the clearCache from finally block and rely on explicit reset.
    }
  }
}
