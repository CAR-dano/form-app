import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_step_provider.dart';
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
  final List<GlobalKey<FormState>> _formKeys = [
    GlobalKey<FormState>(), // For PageOne
    GlobalKey<FormState>(), // For PageTwo
    // Add more GlobalKeys if other pages have forms needing them
  ];

  late final List<Widget> _formPages;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    // Initialize PageController with the initial step from the provider
    // Note: ref.read is safe here as initState is called once.
    _pageController = PageController(initialPage: ref.read(formStepProvider));

    // Initialize _formPages:
    // PageStorageKey on the page widgets themselves is not strictly needed
    // when using PageView with AutomaticKeepAliveClientMixin on each page's state.
    // The key on the scrollable child INSIDE the page remains important.
    _formPages = [
      PageOne(formKey: _formKeys[0]), // Removed PageStorageKey from here
      PageTwo(formKey: _formKeys[1]), // Removed PageStorageKey from here
      const PageThree(),              // Removed PageStorageKey from here
      const PageFour(),
      const PageFiveOne(),
      const PageFiveTwo(),
      const PageFiveThree(),
      const PageFiveFour(),
      const PageFiveFive(),
      const PageFiveSix(),
      const PageFiveSeven(),
      const PageSixGeneralWajib(),
      const PageSixGeneralTambahan(),
      const PageSixEksteriorWajib(),
      const PageSixEksteriorTambahan(),
      const PageSixInteriorWajib(),
      const PageSixInteriorTambahan(),
      const PageSixMesinWajib(),
      const PageSixMesinTambahan(),
      const PageSixKakiKakiWajib(),
      const PageSixKakiKakiTambahan(),
      const PageSixAlatAlatWajib(),
      const PageSixAlatAlatTambahan(),
      const PageSeven(),
      const PageEight(),
      const PageNine(),
      const FinishedPage(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Listen to formStepProvider changes to control PageView
    ref.listen<int>(formStepProvider, (previous, next) {
      if (_pageController.hasClients && _pageController.page?.round() != next) {
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 150), // Standard page transition duration
          curve: Curves.easeInOut,
        );
      }
    });

    return Scaffold(
      // The PageView becomes the direct body of this Scaffold.
      // Each child of PageView will be a CommonLayout wrapping a page from _formPages.
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(), // Disable manual swiping by user
        children: _formPages.map((pageContent) {
          return CommonLayout(child: pageContent);
        }).toList(),
        // If you want to update formStepProvider when PageView swipes (if not disabled):
        // onPageChanged: (index) {
        //   ref.read(formStepProvider.notifier).state = index;
        // },
      ),
    );
  }
}
