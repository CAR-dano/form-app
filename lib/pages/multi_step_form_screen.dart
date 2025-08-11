import 'package:form_app/widgets/logout_button.dart';
import 'package:form_app/utils/crashlytics_util.dart';
import 'package:dio/dio.dart' as dio;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_step_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/multi_step_form_navbar.dart';
// Import all form pages
import 'package:form_app/pages/identitas_page.dart';
import 'package:form_app/pages/data_kendaraan_page.dart';
import 'package:form_app/pages/kelengkapan_page.dart';
import 'package:form_app/pages/hasil_inspeksi_page.dart';
import 'package:form_app/pages/penilaian/penilaian_fitur_page.dart';
import 'package:form_app/pages/penilaian/penilaian_mesin_page.dart';
import 'package:form_app/pages/penilaian/penilaian_interior_page.dart';
import 'package:form_app/pages/penilaian/penilaian_eksterior_page.dart';
import 'package:form_app/pages/penilaian/penilaian_ban_dan_kaki_kaki_page.dart';
import 'package:form_app/pages/penilaian/penilaian_test_drive.dart';
import 'package:form_app/pages/penilaian/penilaian_tools_test_page.dart';
import 'package:form_app/pages/foto_wajib/foto_general_wajib_page.dart';
import 'package:form_app/pages/foto_tambahan/foto_eksterior_tambahan_page.dart';
import 'package:form_app/pages/foto_tambahan/foto_interior_tambahan_page.dart';
import 'package:form_app/pages/foto_tambahan/foto_mesin_tambahan_page.dart';
import 'package:form_app/pages/foto_tambahan/foto_kaki_kaki_tambahan_page.dart';
import 'package:form_app/pages/foto_tambahan/foto_alat_alat_tambahan_page.dart';
import 'package:form_app/pages/foto_dokumen_page.dart';
import 'package:form_app/pages/ketebalan_cat_page.dart';
import 'package:form_app/pages/finalisasi_page.dart';
import 'package:form_app/pages/finished.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/api_service_provider.dart';
import 'package:form_app/providers/image_data_provider.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/page_navigation_provider.dart';
import 'package:form_app/providers/submission_status_provider.dart';
import 'package:form_app/providers/submission_data_cache_provider.dart';
import 'package:form_app/providers/message_overlay_provider.dart'; // Import the new provider
import 'package:form_app/models/uploadable_image.dart';
import 'package:form_app/widgets/multi_step_form_appbar.dart';
import 'package:form_app/widgets/delete_all_tambahan_photos_button.dart';
import 'package:form_app/services/update_service.dart';
import 'package:form_app/widgets/app_version_display.dart'; // Import the new widget

class MultiStepFormScreen extends ConsumerStatefulWidget {
  const MultiStepFormScreen({super.key});

  @override
  ConsumerState<MultiStepFormScreen> createState() => _MultiStepFormScreenState();
}

class _MultiStepFormScreenState extends ConsumerState<MultiStepFormScreen> {
  final List<GlobalKey<FormState>> _formKeys = List.generate(27, (_) => GlobalKey<FormState>());

  dio.CancelToken? _cancelToken;

  final ValueNotifier<bool> _formSubmittedPageOne = ValueNotifier<bool>(false);

  void _cancelSubmission() {
    debugPrint('_cancelSubmission function called');
    if (_cancelToken != null && !(_cancelToken?.isCancelled ?? false)) {
      debugPrint('_cancelToken is not cancelled, cancelling...');
      _cancelToken?.cancel();
    } else {
      debugPrint('_cancelToken is cancelled or null, not cancelling.');
    }
    ref.read(submissionStatusProvider.notifier).reset();
    debugPrint('_cancelSubmission function finished');
  }

  static const String _defaultTambahanLabel = 'Foto Tambahan';
  static const String _defaultStnkLabel = 'Foto STNK';
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
    10: 'Foto Mesin (Tambahan)', // FotoMesinTambahanPage
    11: 'Foto Kaki-kaki (Tambahan)', // PageSixKakiKakiTambahan
    12: 'Foto Alat-alat (Tambahan)', // PageSixAlatAlatTambahan
    13: 'Foto Dokumen', // PageSeven
    14: 'Data Kendaraan', // PageTwo
  };

  final Map<int, String> _tambahanImagePageIdentifiers = {
    2: 'Eksterior Tambahan',
    4: 'Interior Tambahan',
    5: 'Mesin Tambahan',
    6: 'Kaki-kaki Tambahan',
    7: 'Alat-alat Tambahan',
    8: 'Foto Dokumen',
  };

  @override
  void initState() {
    super.initState();

    // Pre-cache checker.png
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        precacheImage(const AssetImage('assets/images/checker.png'), context);
        // Check for updates when the screen initializes
        ref.read(updateServiceProvider.notifier).checkForUpdate();
      }
    });

    _formPages = [
      IdentitasPage(key: const ValueKey('IdentitasPage'), formKey: _formKeys[0], formSubmitted: _formSubmittedPageOne),
      const FotoGeneralWajibPage(key: ValueKey('FotoGeneralWajibPage')),
      FotoEksteriorTambahanPage(key: const ValueKey('FotoEksteriorTambahanPage'), formSubmitted: _formSubmittedTambahanImages),
      const KetebalanCatPage(key: ValueKey('KetebalanCatPage')),
      FotoInteriorTambahanPage(key: const ValueKey('FotoInteriorTambahanPage'), formSubmitted: _formSubmittedTambahanImages),
      FotoMesinTambahanPage(key: const ValueKey('FotoMesinTambahanPage'), formSubmitted: _formSubmittedTambahanImages),
      FotoKakiKakiTambahanPage(key: const ValueKey('FotoKakiKakiTambahanPage'), formSubmitted: _formSubmittedTambahanImages),
      FotoAlatAlatTambahanPage(key: const ValueKey('FotoAlatAlatTambahanPage'), formSubmitted: _formSubmittedTambahanImages),
      FotoDokumenPage(key: const ValueKey('FotoDokumenPage'), formSubmitted: _formSubmittedTambahanImages, defaultLabel: _defaultStnkLabel),
      DataKendaraanPage(key: const ValueKey('DataKendaraanPage'), formKey: _formKeys[14], formSubmitted: _formSubmittedPageTwo),
      const KelengkapanPage(key: ValueKey('KelengkapanPage')),
      const HasilInspeksiPage(key: ValueKey('HasilInspeksiPage')),
      const PenilaianFiturPage(key: ValueKey('PenilaianFiturPage')),
      const PenilaianMesinPage(key: ValueKey('PenilaianMesinPage')),
      const PenilaianInteriorPage(key: ValueKey('PenilaianInteriorPage')),
      const PenilaianEksteriorPage(key: ValueKey('PenilaianEksteriorPage')),
      const PenilaianBanDanKakiKakiPage(key: ValueKey('PenilaianBanDanKakiKakiPage')),
      const PenilaianTestDrive(key: ValueKey('PenilaianTestDrive')),
      const PenilaianToolsTestPage(key: ValueKey('PenilaianToolsTestPage')),
      FinalisasiPage(
        key: const ValueKey('PageNine'),
        onCheckedChange: (newValue) {
          final submissionStatus = ref.read(submissionStatusProvider);
          if (!submissionStatus.isLoading) {
            setState(() { _isChecked = newValue; });
          }
        },
        isChecked: _isChecked,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final pageController = ref.watch(pageNavigationProvider);
    final currentPageIndex = ref.watch(formStepProvider);
    final submissionStatus = ref.watch(submissionStatusProvider);

    // The last page is now the finalization page, which should not be scrollable.
    final isLastPage = currentPageIndex == _formPages.length - 1;
    final pageViewPhysics = isLastPage
        ? const NeverScrollableScrollPhysics()
        : const PageScrollPhysics();

    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      extendBody: true,
      appBar: MultiStepFormAppBar(
        currentPage: currentPageIndex + 1,
        totalPages: _formPages.length, // Total pages is now the exact length
        trailingWidget: _buildTrailingWidget(currentPageIndex),
      ),
      body: PageView(
        controller: pageController,
        physics: pageViewPhysics,
        onPageChanged: (int page) {
          // This logic prevents swiping past the last page, but since the navbar
          // button is what triggers submission, we can simplify.
          // We just need to update the current step.
          if (ref.read(formStepProvider) != page) {
            ref.read(formStepProvider.notifier).state = page;
          }
        },
        children: _formPages.map((pageContent) {
          return CommonLayout(child: pageContent);
        }).toList(),
      ),
      bottomNavigationBar: MultiStepFormNavbar(
        currentPageIndex: currentPageIndex,
        formPagesLength: _formPages.length,
        onNextPressed: () {
          if (isLastPage) {
            _submitForm();
          } else {
            FocusScope.of(context).unfocus();
            ref.read(pageNavigationProvider.notifier).goToNextPage();
          }
        },
        onBackPressed: isLastPage && submissionStatus.isLoading
            ? _cancelSubmission
            : () {
                FocusScope.of(context).unfocus();
                ref.read(pageNavigationProvider.notifier).goToPreviousPage();
              },
        isLoading: submissionStatus.isLoading,
        isChecked: _isChecked,
      ),
    );
  }

  Widget? _buildTrailingWidget(int currentPageIndex) {
    if (currentPageIndex == 0) {
      // For the first page, show AppVersionDisplay and a logout button
      return const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          AppVersionDisplay(),
          LogoutButton(),
        ],
      );
    }

    final String? pageIdentifier = _tambahanImagePageIdentifiers[currentPageIndex];
    if (pageIdentifier != null) {
      final images = ref.watch(tambahanImageDataProvider(pageIdentifier));
      final bool hasImages = images.length > 1; // Show button if there is at least one image
      if (hasImages) {
        return DeleteAllTambahanPhotosButton(
          tambahanImageIdentifier: pageIdentifier,
          dialogMessage: 'Yakin ingin menghapus semua foto ${pageIdentifier.toLowerCase()}?',
        );
      }
    }
    return null;
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
      return 'Form tidak siap untuk Halaman ${_pageNames[pageIndex] ?? pageIndex + 1}';
    }
    if (_tambahanImagePageIdentifiers.containsKey(pageIndex)) {
      final identifier = _tambahanImagePageIdentifiers[pageIndex]!;
      final images = ref.read(tambahanImageDataProvider(identifier));
      if (images.any((image) => image.label == _defaultTambahanLabel || image.label.trim().isEmpty )) {
         if (identifier == 'Foto Dokumen' && images.any((image) => image.label == _defaultStnkLabel && image.imagePath.isNotEmpty)) {
            return 'Label untuk "Foto Dokumen" belum diubah dari default atau kosong.';
         } else if (identifier != 'Foto Dokumen' && images.any((image) => image.label.trim().isEmpty && image.imagePath.isNotEmpty)){
            return 'Harap isi semua label gambar di Halaman ${_pageNames[pageIndex] ?? pageIndex + 1}';
         }
      }
    }
    return null;
  }

  // Paste this entire method into your _MultiStepFormScreenState class
  Future<void> _submitForm() async {
    _cancelToken = dio.CancelToken();
    final submissionStatusNotifier = ref.read(submissionStatusProvider.notifier);
    final submissionDataCache = ref.read(submissionDataCacheProvider);
    final submissionDataCacheNotifier = ref.read(submissionDataCacheProvider.notifier);
    final customMessageOverlay = ref.read(customMessageOverlayProvider); // Get the singleton instance
    final crashlytics = ref.read(crashlyticsUtilProvider); // Get the Crashlytics util

    if (ref.read(submissionStatusProvider).isLoading) {
      customMessageOverlay.show(
        context: context, // Pass context here
        message: 'Pengiriman data sedang berlangsung. Harap tunggu.',
        color: Colors.blue,
        icon: Icons.info_outline,
        duration: const Duration(seconds: 3),
      );
      return;
    }

    final isImageProcessing = ref.read(imageProcessingServiceProvider.notifier).isAnyProcessing;
    if (isImageProcessing) {
      customMessageOverlay.show(
        context: context, // Pass context here
        message: 'Pemrosesan gambar masih berjalan. Harap tunggu hingga selesai.',
        color: Colors.orange,
        icon: Icons.hourglass_empty,
      );
      return;
    }

    if (!_isChecked) {
      customMessageOverlay.show(
        context: context, // Pass context here
        message: 'Harap setujui pernyataan di atas sebelum melanjutkan.',
        color: Colors.red,
        icon: Icons.error_outline,
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

    await Future.microtask(() {});

    List<String> validationErrors = [];
    int? firstErrorPageIndex;

    for (int pageIndex in _pagesToValidate) {
      final error = _validatePage(pageIndex);
      if (error != null) {
        validationErrors.add(error);
        firstErrorPageIndex ??= pageIndex;
      }
    }

    if (validationErrors.isNotEmpty) {
      if (!mounted) return;
      customMessageOverlay.show(
        context: context, // Pass context here
        message: validationErrors.join('\n'),
        color: Colors.red,
        icon: Icons.error_outline,
        duration: const Duration(seconds: 5),
      );
      if (firstErrorPageIndex != null) {
        final int? pageViewIndex = _formKeyIndexToPageIndex[firstErrorPageIndex];
        if (pageViewIndex != null) {
          ref.read(pageNavigationProvider.notifier).jumpToPage(pageViewIndex);
        } else {
          debugPrint('Error: No PageView index found for form key index $firstErrorPageIndex');
          ref.read(pageNavigationProvider.notifier).jumpToPage(0);
        }
      }
      submissionStatusNotifier.setLoading(isLoading: false);
      return;
    }

    // --- Start of The Refactored Logic ---
    try {
      String? inspectionId;
      final formDataToSubmit = ref.read(formProvider);
      final apiService = ref.read(apiServiceProvider);


      final bool isFormDataUnchanged = submissionDataCache.lastSubmittedFormData != null &&
          formDataToSubmit == submissionDataCache.lastSubmittedFormData;

      if (isFormDataUnchanged && submissionDataCache.lastSubmittedInspectionId != null) {
        inspectionId = submissionDataCache.lastSubmittedInspectionId;
        debugPrint('Reusing existing inspection ID: $inspectionId');
        submissionStatusNotifier.setLoading(
          isLoading: true,
          message: 'Data formulir tidak berubah. Melanjutkan unggah gambar...', 
          progress: 0.1,
        );
      } else {
        submissionStatusNotifier.setLoading(
          isLoading: true,
          message: 'Mengirim data formulir...', 
          progress: 0.1,
        );

        final Map<String, dynamic> formDataResponse = await apiService.submitFormData(formDataToSubmit, cancelToken: _cancelToken);
        inspectionId = formDataResponse['id'] as String?;

        submissionDataCacheNotifier.setCache(
          inspectionId: inspectionId,
          formData: formDataToSubmit,
        );
      }

      if (inspectionId == null || inspectionId.isEmpty) {
        throw Exception('Inspection ID not received or is empty after form submission.');
      }

      if (!mounted) return;

      List<UploadableImage> allImages = [];
      final wajibImages = ref.read(imageDataListProvider);
      for (var imgData in wajibImages) {
        if (imgData.imagePath.isNotEmpty) {
          allImages.add(UploadableImage(
            imagePath: imgData.imagePath, label: imgData.label, needAttention: imgData.needAttention,
            category: imgData.category, isMandatory: imgData.isMandatory,
          ));
        }
      }

      for (final identifier in _tambahanImagePageIdentifiers.values) {
        final tambahanImagesList = ref.read(tambahanImageDataProvider(identifier));
        for (var imgData in tambahanImagesList) {
          if (imgData.imagePath.isNotEmpty) {
            final String labelToUse = imgData.label.isEmpty ? _defaultTambahanLabel : imgData.label;
            allImages.add(UploadableImage(
              imagePath: imgData.imagePath, label: labelToUse, needAttention: imgData.needAttention,
              category: imgData.category, isMandatory: imgData.isMandatory,
            ));
          }
        }
      }

      final int totalOriginalImages = allImages.length;
      const int batchSize = 10; // Assuming batch size is 10 as per ApiService
      final int totalOriginalBatches = (totalOriginalImages / batchSize).ceil();

      // Filter out already uploaded images
      final Set<String> uploadedPaths = submissionDataCache.uploadedImagePaths.toSet();
      List<UploadableImage> imagesToUpload = allImages.where((image) => !uploadedPaths.contains(image.imagePath)).toList();

      final int initialUploadedImagesCount = uploadedPaths.length;
      final int initialUploadedBatchesCount = (initialUploadedImagesCount / batchSize).floor();


      debugPrint('Total images in original set: $totalOriginalImages');
      debugPrint('Total original batches: $totalOriginalBatches');
      debugPrint('Images already uploaded: ${uploadedPaths.length}');
      debugPrint('Initial uploaded batches: $initialUploadedBatchesCount');
      debugPrint('Images to upload this session: ${imagesToUpload.length}');

      if (totalOriginalImages > 0) { // Check if there are any images at all
        final double formDataWeight = 0.2;
        final double imagesWeight = 0.8;

        await apiService.uploadImagesInBatches(
          inspectionId,
          imagesToUpload, // Pass the filtered list
          (int currentBatchOfRemaining, int totalBatchesOfRemaining) {
            if (!mounted) return;
            // Calculate overall current batch number
            final int overallCurrentBatch = initialUploadedBatchesCount + currentBatchOfRemaining;
            
            // Calculate overall progress based on original total batches
            final double overallProgress = totalOriginalBatches > 0
                ? formDataWeight + ((overallCurrentBatch / totalOriginalBatches.toDouble()) * imagesWeight)
                : 1.0;

            submissionStatusNotifier.setLoading(
              isLoading: true,
              message: totalOriginalBatches > 0
                  ? 'Mengunggah gambar batch $overallCurrentBatch dari $totalOriginalBatches...' 
                  : 'Tidak ada gambar untuk diunggah.',
              progress: overallProgress,
            );
          },
          cancelToken: _cancelToken,
          onBatchUploaded: (List<String> newUploadedPaths) {
            // Update the cache with newly uploaded image paths
            submissionDataCacheNotifier.addUploadedImagePaths(newUploadedPaths);
          },
        );
      } else {
        debugPrint('No images to upload.');
        submissionStatusNotifier.setLoading(
          isLoading: true,
          message: 'Tidak ada gambar untuk diunggah. Proses Selesai.',
          progress: 1.0,
        );
      }

      // Success and final cleanup
      submissionStatusNotifier.setLoading(isLoading: true, message: 'Menyelesaikan...', progress: 1.0);
      // Clear all data only upon successful completion of ALL uploads
      ref.read(formProvider.notifier).resetFormData();
      ref.read(imageDataListProvider.notifier).clearImageData();
      for (final identifier in _tambahanImagePageIdentifiers.values) {
        ref.read(tambahanImageDataProvider(identifier).notifier).clearAll();
      }
      submissionDataCacheNotifier.clearCache(); // Clear cache on full success

      if (!mounted) return;

      // Add a delay before navigating to the finished page
      await Future.delayed(const Duration(milliseconds: 500));
      if (!mounted) return;

      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const FinishedPage()),
        (Route<dynamic> route) => false,
      );

    } on dio.DioException catch (e, stackTrace) {
      if (!mounted) return;
      // This now catches cancellation from BOTH form submission and image upload
      if (e.toString().contains('cancelled')) {
        debugPrint('Submission process cancelled by user.');
        customMessageOverlay.show(
          context: context, // Pass context here
          message: 'Pengiriman data dibatalkan.',
          color: Colors.orange,
          icon: Icons.info_outline,
          duration: const Duration(seconds: 4),
        );
      } else {
        crashlytics.recordError(
          e,
          stackTrace,
          reason: 'Error during form submission (DioException)',
          fatal: true, // Network errors during submission are critical
        );
        customMessageOverlay.show(
          context: context, // Pass context here
          message: 'Terjadi kesalahan saat mengirim data: $e',
          color: Colors.red,
          icon: Icons.error_outline,
          duration: const Duration(seconds: 5),
        );
      }
    } catch (e, stackTrace) { // Add stackTrace here
      if (!mounted) return;
      // Fallback for non-Dio cancellations or other general errors
      if (e.toString().contains('cancelled')) {
        debugPrint('Submission process cancelled by user.');
        customMessageOverlay.show(
          context: context, // Pass context here
          message: 'Pengiriman data dibatalkan.',
          color: Colors.orange,
          icon: Icons.info_outline,
          duration: const Duration(seconds: 4),
        );
      } else {
        crashlytics.recordError(
          e,
          stackTrace,
          reason: 'General error during form submission',
          fatal: true, // This is a critical, unexpected error
        );
        customMessageOverlay.show(
          context: context, // Pass context here
          message: 'Terjadi kesalahan saat mengirim data: $e',
          color: Colors.red,
          icon: Icons.error_outline,
          duration: const Duration(seconds: 5),
        );
      }
    } finally {
      // This will now ALWAYS run after the try or catch block is complete,
      // ensuring the state is reset correctly after the message is shown.
      if (mounted) {
        submissionStatusNotifier.reset();
      }
    }
  }
}
