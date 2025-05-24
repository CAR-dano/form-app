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
import 'package:form_app/widgets/loading_indicator_widget.dart';

// Placeholder for Page Nine
class PageNine extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKeyPageOne;
  final GlobalKey<FormState> formKeyPageTwo;
  final ValueNotifier<bool> formSubmittedPageOne;
  final ValueNotifier<bool> formSubmittedPageTwo;
  final ValueNotifier<bool> formSubmittedTambahanImages; // New
  final Map<int, String> pageNames;
  final String? Function(int pageIndex) validatePage;
  final Map<int, String> tambahanImagePageIdentifiers; // New
  final String defaultTambahanLabel;

  const PageNine({
    super.key,
    required this.formKeyPageOne,
    required this.formKeyPageTwo,
    required this.formSubmittedPageOne,
    required this.formSubmittedPageTwo,
    required this.formSubmittedTambahanImages, // New
    required this.pageNames,
    required this.validatePage,
    required this.tambahanImagePageIdentifiers, // New
    required this.defaultTambahanLabel,
  });

  @override
  ConsumerState<PageNine> createState() => _PageNineState();
}

class _PageNineState extends ConsumerState<PageNine> with AutomaticKeepAliveClientMixin {
  bool _isChecked = false;
  bool _isLoading = false;
  // New state variables for detailed progress
  String _loadingMessage = 'Mengirim data...';
  double _currentProgress = 0.0; // Overall progress (0.0 to 1.0) for LinearProgressIndicator
// Could be batches or form data step
// Start with 1 for form data, then update for image batches

  // Combined list of page indices that need validation
  List<int> get _pagesToValidate => [
    0, // PageOne
    14, // PageTwo
    // Removed validation for Tambahan Image pages as per user request
  ];


  @override
  bool get wantKeepAlive => true;

  Future<void> _submitForm() async {
    if (_isLoading) return;
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
      _loadingMessage = 'Memvalidasi data...';
      _currentProgress = 0.0;
    });

    widget.formSubmittedPageOne.value = true;
    widget.formSubmittedPageTwo.value = true;
    widget.formSubmittedTambahanImages.value = true; // Trigger for Tambahan Image Pages

    List<String> validationErrors = [];
    int? firstErrorPageIndex;

    for (int pageIndex in _pagesToValidate) {
      final error = widget.validatePage(pageIndex);
      if (error != null) {
        validationErrors.add(error);
        firstErrorPageIndex ??= pageIndex;
      }
    }

    if (validationErrors.isNotEmpty) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(validationErrors.join('\n'), style: subTitleTextStyle.copyWith(color: Colors.white)),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 5),
        ),
      );
      if (firstErrorPageIndex != null) {
        ref.read(formStepProvider.notifier).state = firstErrorPageIndex;
      }
      setState(() { _isLoading = false; });
      return;
    }

    String? inspectionId;
    try {
      final formDataToSubmit = ref.read(formProvider);
      final apiService = ApiService();

      setState(() {
        _loadingMessage = 'Mengirim data formulir...';
        _currentProgress = 0.1; // Small progress for form submission
// About to process the first item (form data)
      });

      final Map<String, dynamic> formDataResponse = await apiService.submitFormData(formDataToSubmit);
      inspectionId = formDataResponse['id'] as String?;

      if (inspectionId == null || inspectionId.isEmpty) {
        throw Exception('Inspection ID not received from server.');
      }

      setState(() { // Update progress after form data submission
// Form data is 1 item
        _loadingMessage = 'Data formulir terkirim. Mengumpulkan gambar...';
        _currentProgress = 0.2; // Progress after form data
      });

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

      // Use widget.tambahanImagePageIdentifiers.values directly if they are the strings for the provider
      for (final identifier in widget.tambahanImagePageIdentifiers.values) {
        final tambahanImagesList = ref.read(tambahanImageDataProvider(identifier));
        for (var imgData in tambahanImagesList) {
          if (imgData.imagePath.isNotEmpty) {
            // If label is empty, use the default label provided
            final String labelToUse = imgData.label.isEmpty ? widget.defaultTambahanLabel : imgData.label;
            allImagesToUpload.add(UploadableImage(
              imagePath: imgData.imagePath, label: labelToUse, needAttention: imgData.needAttention,
              category: imgData.category, isMandatory: imgData.isMandatory,
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
        // Update _totalItems to include form data + image batches
        // Let's say form data is 1 unit of work, and each image batch is 1 unit of work.
        // For progress calculation, consider a weight. If form data is 20% and images 80%.
        final double formDataWeight = 0.2;
        final double imagesWeight = 0.8;


        await apiService.uploadImagesInBatches(inspectionId, allImagesToUpload,
          (int currentBatch, int totalBatchesFromCallback) {
          if (!mounted) return;
          setState(() {
            if (totalBatchesFromCallback > 0) {
              _loadingMessage = 'Mengunggah gambar batch $currentBatch dari $totalBatchesFromCallback...';
              // Calculate progress: formDataWeight is done, now add progress of image upload
              _currentProgress = formDataWeight + ( (currentBatch / totalBatchesFromCallback.toDouble()) * imagesWeight );
            } else { // Should not happen if allImagesToUpload.isNotEmpty
                 _loadingMessage = 'Tidak ada batch gambar untuk diunggah.';
                 _currentProgress = 1.0; // Mark as complete if this path is hit unexpectedly
            }
            if (currentBatch >= totalBatchesFromCallback && totalBatchesFromCallback > 0) {
                _loadingMessage = 'Unggahan gambar selesai.';
                _currentProgress = 1.0; // Ensure it hits 100%
            }
          });
        });
      } else {
         if (kDebugMode) print('No images to upload.');
         setState(() {
           _loadingMessage = 'Tidak ada gambar untuk diunggah. Proses Selesai.';
           _currentProgress = 1.0; // Submission complete if no images
         });
      }

      setState(() { _loadingMessage = 'Menyelesaikan...'; _currentProgress = 1.0; });
      ref.read(formProvider.notifier).resetFormData();
      ref.read(imageDataListProvider.notifier).clearImageData();
      for (final identifier in widget.tambahanImagePageIdentifiers.values) {
        ref.read(tambahanImageDataProvider(identifier).notifier).clearAll();
      }

      if (!mounted) return;
      ref.read(formStepProvider.notifier).state++;

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
      setState(() { _isLoading = false; }); // Reset loading on error
    } finally {
      // This finally block might set _isLoading to false too soon if success path is taken
      // The success path should handle setting _isLoading = false AFTER navigation or completion
      // For now, let's keep it simple; if an error occurs, _isLoading becomes false.
      // If successful, it navigates, and this specific PageNine instance might be disposed.
      if (mounted && _isLoading) { // Only set if still loading (i.e., an error occurred before completion)
         // setState(() { _isLoading = false; }); // isLoading will be set to false upon completion/error within try/catch
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Column(
      children: [
        Expanded( // Makes the main content area scrollable
          child: SingleChildScrollView(
            clipBehavior: Clip.none,
            key: const PageStorageKey<String>('pageNineScrollKey'),
            child: Padding( // Add padding to the scrollable content
              padding: const EdgeInsets.symmetric(horizontal: 0), // Match CommonLayout padding
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '26/26'), // Consider making this dynamic
                  const SizedBox(height: 4),
                  PageTitle(data: 'Finalisasi'),
                  const SizedBox(height: 6.0),
                  Text(
                    'Pastikan data yang telah diisi telah sesuai dengan yang sebenarnya dan memenuhi SOP PT Inspeksi Mobil Jogja',
                    style: labelStyle.copyWith(fontWeight: FontWeight.w300),
                  ),
                  const SizedBox(height: 16.0),
                  FormConfirmation(
                    label: 'Data yang saya isi telah sesuai',
                    initialValue: _isChecked,
                    onChanged: (bool newValue) {
                      if (!_isLoading) {
                        setState(() { _isChecked = newValue; });
                      }
                    },
                  ),
                  const SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
        // Buttons and Footer at the bottom
        if (_isLoading)
          LoadingIndicatorWidget(
            message: _loadingMessage,
            progress: _currentProgress,
          ),
        Padding(
          padding: const EdgeInsets.only(top:16.0), // Add some space if content is short
          child: NavigationButtonRow(
            onBackPressed: _isLoading ? null : () => ref.read(formStepProvider.notifier).state--,
            isLastPage: true,
            onNextPressed: _submitForm,
            isFormConfirmed: _isChecked,
            // Let NavigationButtonRow handle its own isLoading for the spinner within the button
            // If you want to completely replace the button content, that's a bigger change for NavigationButtonRow
            isLoading: _isLoading, 
            nextButtonText: 'Kirim',
          ),
        ),
        const SizedBox(height: 24.0),
        const Footer(),
      ],
    );
  }
}
