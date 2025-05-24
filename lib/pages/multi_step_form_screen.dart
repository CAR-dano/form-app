import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_step_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart'; // Import the provider
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
  final List<GlobalKey<FormState>> _formKeys = List.generate(27, (_) => GlobalKey<FormState>());

  // ValueNotifiers to control when validation messages are shown for specific pages
  final ValueNotifier<bool> _formSubmittedPageOne = ValueNotifier<bool>(false);
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
    _pageController = PageController(initialPage: ref.read(formStepProvider));

    _formPages = [
      PageOne(formKey: _formKeys[0], formSubmitted: _formSubmittedPageOne),
      const PageSixGeneralWajib(),
      const PageSixEksteriorWajib(),
      const PageSixInteriorWajib(),
      const PageSixMesinWajib(),
      const PageSixKakiKakiWajib(),
      const PageSixAlatAlatWajib(),
      PageSixGeneralTambahan(formSubmitted: _formSubmittedTambahanImages), // Index 7
      PageSixEksteriorTambahan(formSubmitted: _formSubmittedTambahanImages), // Index 8
      PageSixInteriorTambahan(formSubmitted: _formSubmittedTambahanImages), // Index 9
      PageSixMesinTambahan(formSubmitted: _formSubmittedTambahanImages), // Index 10
      PageSixKakiKakiTambahan(formSubmitted: _formSubmittedTambahanImages), // Index 11
      PageSixAlatAlatTambahan(formSubmitted: _formSubmittedTambahanImages), // Index 12
      PageSeven(formSubmitted: _formSubmittedTambahanImages), // Index 13
      PageTwo(formKey: _formKeys[14], formSubmitted: _formSubmittedPageTwo), // Index 14
      const PageThree(),
      const PageFour(),
      const PageFiveOne(),
      const PageFiveTwo(),
      const PageFiveThree(),
      const PageFiveFour(),
      const PageFiveFive(),
      const PageFiveSix(),
      const PageFiveSeven(),
      const PageEight(),
      PageNine(
        formKeyPageOne: _formKeys[0],
        formKeyPageTwo: _formKeys[14],
        formSubmittedPageOne: _formSubmittedPageOne,
        formSubmittedPageTwo: _formSubmittedPageTwo,
        formSubmittedTambahanImages: _formSubmittedTambahanImages,
        pageNames: _pageNames,
        validatePage: _validatePage,
        tambahanImagePageIdentifiers: _tambahanImagePageIdentifiers,
      ),
      const FinishedPage(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    _formSubmittedPageOne.dispose();
    _formSubmittedPageTwo.dispose();
    _formSubmittedTambahanImages.dispose();
    super.dispose();
  }

  // Function to validate a specific page
  String? _validatePage(int pageIndex) {
    // Validation for pages with GlobalKey<FormState>
    if (_formKeys[pageIndex].currentState != null) {
      if (!(_formKeys[pageIndex].currentState!.validate())) {
        return 'Harap lengkapi data di Halaman ${pageIndex + 1}';
      }
    }

    // Validation for pages with TambahanImageSelection
    if (_tambahanImagePageIdentifiers.containsKey(pageIndex)) {
      final identifier = _tambahanImagePageIdentifiers[pageIndex]!;
      final images = ref.read(tambahanImageDataProvider(identifier));
      if (images.any((image) => image.label.trim().isEmpty)) {
        return 'Harap isi semua label gambar di Halaman ${pageIndex + 1}';
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<int>(formStepProvider, (previous, next) {
      if (_pageController.hasClients && _pageController.page?.round() != next) {
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
        );
      }
    });

    final currentPageIndex = ref.watch(formStepProvider); // Watch the current step

    ref.listen<int>(formStepProvider, (previous, next) {
      if (_pageController.hasClients && _pageController.page?.round() != next) {
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 150),
          curve: Curves.easeInOut,
        );
      }
    });

    // Determine the physics for the PageView
    ScrollPhysics pageViewPhysics;
    // PageNine is at index 25, FinishedPage is at index 26.
    // _formPages.length - 2 is the index of PageNine.
    // _formPages.length - 1 is the index of FinishedPage.
    if (currentPageIndex >= _formPages.length - 2) { // If current page is PageNine or FinishedPage
      pageViewPhysics = const NeverScrollableScrollPhysics();
    } else {
      pageViewPhysics = const PageScrollPhysics();
    }

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _pageController,
        physics: pageViewPhysics, // Use the conditionally set physics
        onPageChanged: (int page) {
          // Prevent swiping from PageNine to FinishedPage manually
          if (currentPageIndex == _formPages.length - 2 && page == _formPages.length - 1) {
            // If on PageNine and trying to swipe to FinishedPage, jump back to PageNine
            _pageController.jumpToPage(currentPageIndex);
          } else {
            ref.read(formStepProvider.notifier).state = page;
          }
        },
        children: _formPages.map((pageContent) {
          return CommonLayout(child: pageContent);
        }).toList(),
      ),
    );
  }
}
