import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_step_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
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
import 'package:form_app/pages/page_six_eksterior_tambahan.dart';
import 'package:form_app/pages/page_six_interior_tambahan.dart';
import 'package:form_app/pages/page_six_mesin_tambahan.dart';
import 'package:form_app/pages/page_six_kaki_kaki_tambahan.dart';
import 'package:form_app/pages/page_six_alat_alat_tambahan.dart';
import 'package:form_app/pages/page_seven.dart';
import 'package:form_app/pages/page_eight.dart';
import 'package:form_app/pages/page_nine.dart';
import 'package:form_app/pages/finished.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/services/api_service.dart';
import 'package:form_app/providers/image_data_provider.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/page_navigation_provider.dart';
import 'package:form_app/providers/submission_status_provider.dart';
import 'package:form_app/providers/submission_data_cache_provider.dart';
import 'package:form_app/widgets/custom_message_overlay.dart';
import 'package:form_app/models/uploadable_image.dart';
import 'package:form_app/widgets/multi_step_form_appbar.dart';
import 'package:form_app/widgets/delete_all_tambahan_photos_button.dart';

class MultiStepFormScreen extends ConsumerStatefulWidget {
  const MultiStepFormScreen({super.key});

  @override
  ConsumerState<MultiStepFormScreen> createState() => _MultiStepFormScreenState();
}

class _MultiStepFormScreenState extends ConsumerState<MultiStepFormScreen> {
  final List<GlobalKey<FormState>> _formKeys = List.generate(27, (_) => GlobalKey<FormState>());

  late CustomMessageOverlay _customMessageOverlay;

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
    _customMessageOverlay = CustomMessageOverlay(context);

    // Pre-cache checker.png
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        precacheImage(const AssetImage('assets/images/checker.png'), context);
      }
    });

    _formPages = [
      PageOne(key: const ValueKey('PageOne'), formKey: _formKeys[0], formSubmitted: _formSubmittedPageOne),
      const PageSixGeneralWajib(key: ValueKey('PageSixGeneralWajib')),
      PageSixEksteriorTambahan(key: const ValueKey('PageSixEksteriorTambahan'), formSubmitted: _formSubmittedTambahanImages),
      const PageEight(key: ValueKey('PageEight')),
      PageSixInteriorTambahan(key: const ValueKey('PageSixInteriorTambahan'), formSubmitted: _formSubmittedTambahanImages),
      PageSixMesinTambahan(key: const ValueKey('PageSixMesinTambahan'), formSubmitted: _formSubmittedTambahanImages),
      PageSixKakiKakiTambahan(key: const ValueKey('PageSixKakiKakiTambahan'), formSubmitted: _formSubmittedTambahanImages),
      PageSixAlatAlatTambahan(key: const ValueKey('PageSixAlatAlatTambahan'), formSubmitted: _formSubmittedTambahanImages),
      PageSeven(key: const ValueKey('PageSeven'), formSubmitted: _formSubmittedTambahanImages, defaultLabel: _defaultTambahanLabel),
      PageTwo(key: const ValueKey('PageTwo'), formKey: _formKeys[14], formSubmitted: _formSubmittedPageTwo),
      const PageThree(key: ValueKey('PageThree')),
      const PageFour(key: ValueKey('PageFour')),
      const PageFiveOne(key: ValueKey('PageFiveOne')),
      const PageFiveTwo(key: ValueKey('PageFiveTwo')),
      const PageFiveThree(key: ValueKey('PageFiveThree')),
      const PageFiveFour(key: ValueKey('PageFiveFour')),
      const PageFiveFive(key: ValueKey('PageFiveFive')),
      const PageFiveSix(key: ValueKey('PageFiveSix')),
      const PageFiveSeven(key: ValueKey('PageFiveSeven')),
      PageNine(
        key: const ValueKey('PageNine'),
        onCheckedChange: (newValue) {
          final submissionStatus = ref.read(submissionStatusProvider);
          if (!submissionStatus.isLoading) {
            setState(() { _isChecked = newValue; });
          }
        },
        isChecked: _isChecked,
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
      extendBody: true,
      appBar: currentPageIndex < _formPages.length - 1
          ? MultiStepFormAppBar(
              currentPage: currentPageIndex + 1,
              totalPages: _formPages.length - 1, // Exclude FinishedPage from total
              trailingWidget: _buildTrailingWidget(currentPageIndex),
            )
          : null,
      body: PageView(
        controller: pageController,
        physics: pageViewPhysics,
        onPageChanged: (int page) {
          final currentActualStep = ref.read(formStepProvider);
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
                if (currentPageIndex == _formPages.length - 2) {
                  _submitForm();
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
            )
          : null,
    );
  }

  Widget? _buildTrailingWidget(int currentPageIndex) {
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
         if (identifier == 'Foto Dokumen' && images.any((image) => image.label == _defaultTambahanLabel && image.imagePath.isNotEmpty)) {
            return 'Label untuk "Foto Dokumen" belum diubah dari default atau kosong.';
         } else if (identifier != 'Foto Dokumen' && images.any((image) => image.label.trim().isEmpty && image.imagePath.isNotEmpty)){
            return 'Harap isi semua label gambar di Halaman ${_pageNames[pageIndex] ?? pageIndex + 1}';
         }
      }
    }
    return null;
  }

  Future<void> _submitForm() async {
    final submissionStatus = ref.read(submissionStatusProvider);
    final submissionStatusNotifier = ref.read(submissionStatusProvider.notifier);
    final submissionDataCache = ref.read(submissionDataCacheProvider);
    final submissionDataCacheNotifier = ref.read(submissionDataCacheProvider.notifier);

    if (submissionStatus.isLoading) return;

    final isImageProcessing = ref.read(imageProcessingServiceProvider.notifier).isAnyProcessing;
    if (isImageProcessing) {
      _customMessageOverlay.show(
        message: 'Pemrosesan gambar masih berjalan. Harap tunggu hingga selesai.',
        color: Colors.orange,
        icon: Icons.hourglass_empty,
      );
      return;
    }

    if (!_isChecked) {
      _customMessageOverlay.show(
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
      _customMessageOverlay.show(
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

    String? inspectionId;
    final formDataToSubmit = ref.read(formProvider);
    final apiService = ApiService();

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
      try {
        submissionStatusNotifier.setLoading(
          isLoading: true,
          message: 'Mengirim data formulir...',
          progress: 0.1,
        );

        final Map<String, dynamic> formDataResponse = await apiService.submitFormData(formDataToSubmit);
        inspectionId = formDataResponse['id'] as String?;

        submissionDataCacheNotifier.setCache(
          inspectionId: inspectionId,
          formData: formDataToSubmit,
        );
      } catch (e) {
        if (!mounted) return;
        _customMessageOverlay.show(
          message: 'Terjadi kesalahan saat mengirim data formulir: $e',
          color: Colors.red,
          icon: Icons.error_outline,
          duration: const Duration(seconds: 5),
        );
        submissionStatusNotifier.setLoading(isLoading: false);
        return;
      }
    }

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

      for (final identifier in _tambahanImagePageIdentifiers.values) {
        final tambahanImagesList = ref.read(tambahanImageDataProvider(identifier));
        for (var imgData in tambahanImagesList) {
          if (imgData.imagePath.isNotEmpty) {
            final String labelToUse = imgData.label.isEmpty ? _defaultTambahanLabel : imgData.label;
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
      for (final identifier in _tambahanImagePageIdentifiers.values) {
        ref.read(tambahanImageDataProvider(identifier).notifier).clearAll();
      }

      if (!mounted) return;
      ref.read(formStepProvider.notifier).state++;
    } catch (e) {
      if (!mounted) return;
      _customMessageOverlay.show(
        message: 'Terjadi kesalahan saat mengunggah gambar: $e',
        color: Colors.red,
        icon: Icons.error_outline,
        duration: const Duration(seconds: 5),
      );
      submissionStatusNotifier.setLoading(isLoading: false);
    } finally {
      submissionStatusNotifier.reset();
    }
  }
}
