import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart'; // Import the provider
import 'package:form_app/providers/form_provider.dart'; // Import formProvider
import 'package:form_app/widgets/common_layout.dart';

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
import 'package:form_app/pages/page_six_general_tambahan.dart';
import 'package:form_app/pages/page_six_eksterior_wajib.dart';
import 'package:form_app/pages/page_six_eksterior_tambahan.dart';
import 'package:form_app/pages/page_six_interior_wajib.dart';
import 'package:form_app/pages/page_six_interior_tambahan.dart';
import 'package:form_app/pages/page_six_mesin_wajib.dart';
import 'package:form_app/pages/page_six_mesin_tambahan.dart';
import 'package:form_app/pages/page_six_kaki_kaki_wajib.dart';
import 'package:form_app/pages/page_six_kaki_kaki_tambahan.dart';
import 'package:form_app/pages/page_six_alat_alat_wajib.dart';
import 'package:form_app/pages/page_six_alat_alat_tambahan.dart';
import 'package:form_app/pages/page_seven.dart';
import 'package:form_app/pages/page_eight.dart';
import 'package:form_app/pages/page_nine.dart';
import 'package:form_app/pages/finished.dart';

class MultiStepFormScreen extends ConsumerStatefulWidget {
  const MultiStepFormScreen({super.key});

  @override
  ConsumerState<MultiStepFormScreen> createState() => _MultiStepFormScreenState();
}

class _MultiStepFormScreenState extends ConsumerState<MultiStepFormScreen> {
  // Add this flag:
  bool _isProgrammaticallyMovingPage = false; // To manage programmatic vs. user-driven page changes
  bool _isPostFrameCallbackScheduled = false; // To prevent scheduling multiple post-frame callbacks

  final List<GlobalKey<FormState>> _formKeys = List.generate(27, (_) => GlobalKey<FormState>());

  // ValueNotifiers to control when validation messages are shown for specific pages
  final ValueNotifier<bool> _formSubmittedPageOne = ValueNotifier<bool>(false);
  static const String _defaultTambahanLabel = 'Foto Tambahan';
  final ValueNotifier<bool> _formSubmittedPageTwo = ValueNotifier<bool>(false);
  // ValueNotifier for Tambahan Image pages
  final ValueNotifier<bool> _formSubmittedTambahanImages = ValueNotifier<bool>(false);

  late final List<Widget> _formPages;
  late PageController _pageController;

  // Map page indices to their names for snackbar messages
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

  // Identifiers for pages with TambahanImageSelection
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
    // Read the current form data to get the saved page index
    final formData = ref.read(formProvider);
    int initialStep = formData.currentPageIndex; // Use the saved page index

    _pageController = PageController(initialPage: initialStep);

    // Pre-cache checker.png
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        precacheImage(const AssetImage('assets/images/checker.png'), context);
      }
    });

    // This flag will be true when we expect the PageController to be on initialStep
    // due to initialization or a reset from FinishedPage.
    _isProgrammaticallyMovingPage = true;

    if (!_isPostFrameCallbackScheduled) {
        _isPostFrameCallbackScheduled = true;
        WidgetsBinding.instance.addPostFrameCallback((_) {
        _isPostFrameCallbackScheduled = false; // Reset flag
        if (mounted && _pageController.hasClients) {
            final currentStepFromFormData = ref.read(formProvider).currentPageIndex; // Read from FormData
            final currentPageOnController = _pageController.page?.round();

            if (currentPageOnController != currentStepFromFormData) {
            // If the controller isn't on the page the provider dictates,
            // forcefully jump to it. This is crucial for the reset.
            _pageController.jumpToPage(currentStepFromFormData);
            }
            // After ensuring the PageController is settled on the correct page,
            // allow onPageChanged events to be processed normally.
            // We use a microtask to ensure this runs after jumpToPage has had its effect
            // within the current event loop, before any potential onPageChanged from the jump.
            Future.microtask(() {
                if (mounted) {
                    setState(() { // Or just assign if no UI element depends on it for rebuild
                        _isProgrammaticallyMovingPage = false;
                    });
                }
            });
        } else if (mounted) {
            // If controller is already on the correct page, we can allow onPageChanged.
             Future.microtask(() {
                if (mounted) {
                    setState(() {
                        _isProgrammaticallyMovingPage = false;
                    });
                }
            });
        }
        });
    }

    _formPages = [
      PageOne(key: const ValueKey('PageOne'), formKey: _formKeys[0], formSubmitted: _formSubmittedPageOne),
      const PageSixGeneralWajib(key: ValueKey('PageSixGeneralWajib')),
      const PageSixEksteriorWajib(key: ValueKey('PageSixEksteriorWajib')),
      const PageSixInteriorWajib(key: ValueKey('PageSixInteriorWajib')),
      const PageSixMesinWajib(key: ValueKey('PageSixMesinWajib')),
      const PageSixKakiKakiWajib(key: ValueKey('PageSixKakiKakiWajib')),
      const PageSixAlatAlatWajib(key: ValueKey('PageSixAlatAlatWajib')),
      PageSixGeneralTambahan(key: const ValueKey('PageSixGeneralTambahan'), formSubmitted: _formSubmittedTambahanImages),
      PageSixEksteriorTambahan(key: const ValueKey('PageSixEksteriorTambahan'), formSubmitted: _formSubmittedTambahanImages),
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
      const PageEight(key: ValueKey('PageEight')),
      PageNine(
        key: const ValueKey('PageNine'),
        formKeyPageOne: _formKeys[0],
        formKeyPageTwo: _formKeys[14],
        formSubmittedPageOne: _formSubmittedPageOne,
        formSubmittedPageTwo: _formSubmittedPageTwo,
        formSubmittedTambahanImages: _formSubmittedTambahanImages,
        pageNames: _pageNames,
        validatePage: _validatePage,
        tambahanImagePageIdentifiers: _tambahanImagePageIdentifiers,
        defaultTambahanLabel: _defaultTambahanLabel,
      ),
      const FinishedPage(key: ValueKey('FinishedPage')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    // Listener for formStepProvider is removed as it's replaced by formData.currentPageIndex
    // ref.listen<int>(formStepProvider, (previous, next) {
    //   if (_pageController.hasClients && _pageController.page?.round() != next) {
    //     _isProgrammaticallyMovingPage = true;
    //     _pageController.animateToPage(
    //       next,
    //       duration: const Duration(milliseconds: 150),
    //       curve: Curves.easeInOut,
    //     ).then((_) {
    //       if (mounted) {
    //         setState(() {
    //           _isProgrammaticallyMovingPage = false;
    //         });
    //       }
    //     });
    //   }
    // });

    final currentFormData = ref.watch(formProvider); // Watch the form data
    final currentPageIndex = currentFormData.currentPageIndex; // Get current page from form data
    ScrollPhysics pageViewPhysics;
    if (currentPageIndex >= _formPages.length - 2) {
      pageViewPhysics = const NeverScrollableScrollPhysics();
    } else {
      pageViewPhysics = const PageScrollPhysics();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _pageController,
        physics: pageViewPhysics,
        onPageChanged: (int page) {
          // If the page change was initiated by our programmatic scroll/jump,
          // or if we are still in the initial settling phase, don't update the provider from here.
          if (_isProgrammaticallyMovingPage) {
            return;
          }

          final currentActualStep = ref.read(formProvider).currentPageIndex; // Read from form data
          // Prevent swipe from PageNine to FinishedPage
          if (currentActualStep == _formPages.length - 2 && page == _formPages.length - 1) {
            // We might still need to set the _isProgrammaticallyMovingPage flag here if jumpToPage also triggers onPageChanged
            _isProgrammaticallyMovingPage = true;
            _pageController.jumpToPage(currentActualStep);
            Future.microtask(() {
                if(mounted) {
                    setState(() => _isProgrammaticallyMovingPage = false);
                }
            });
          } else {
            if (currentActualStep != page) {
              ref.read(formProvider.notifier).updateCurrentPageIndex(page); // Update current page in form data
            }
          }
        },
        children: _formPages.map((pageContent) {
          return CommonLayout(child: pageContent);
        }).toList(),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _formSubmittedPageOne.dispose();
    _formSubmittedPageTwo.dispose();
    _formSubmittedTambahanImages.dispose();
    // No need to dispose formStepProvider as it's no longer directly watched here
    super.dispose();
  }

  String? _validatePage(int pageIndex) {
    if (_formKeys[pageIndex].currentState != null) {
      if (!(_formKeys[pageIndex].currentState!.validate())) {
        return 'Harap lengkapi data di Halaman ${_pageNames[pageIndex] ?? pageIndex + 1}';
      }
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
}
