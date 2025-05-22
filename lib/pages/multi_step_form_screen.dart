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
    GlobalKey<FormState>(), // For PageOne (index 0)
    GlobalKey<FormState>(), // For PageTwo (index 1)
    // Add more GlobalKeys if other pages have forms needing them
  ];

  // ValueNotifiers to control when validation messages are shown for specific pages
  final ValueNotifier<bool> _formSubmittedPageOne = ValueNotifier<bool>(false);
  final ValueNotifier<bool> _formSubmittedPageTwo = ValueNotifier<bool>(false);

  late final List<Widget> _formPages;
  late PageController _pageController;

  // Map page indices to their names for snackbar messages
  final Map<int, String> _pageNames = {
    0: 'Identitas (Halaman 1)',
    1: 'Data Kendaraan (Halaman 2)',
  };

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: ref.read(formStepProvider));

    _formPages = [
      PageOne(formKey: _formKeys[0], formSubmitted: _formSubmittedPageOne),
      PageTwo(formKey: _formKeys[1], formSubmitted: _formSubmittedPageTwo),
      const PageThree(),
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
      PageNine(
        formKeyPageOne: _formKeys[0],
        formKeyPageTwo: _formKeys[1],
        formSubmittedPageOne: _formSubmittedPageOne,
        formSubmittedPageTwo: _formSubmittedPageTwo,
        pageNames: _pageNames,
        validatePage: _validatePage, // Pass the function
      ),
      const FinishedPage(),
    ];
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  // Function to validate a specific page
  String? _validatePage(int pageIndex) {
    final formKey = _formKeys[pageIndex];
    // Trigger validation for the specific page's form
    if (!(formKey.currentState?.validate() ?? false)) {
      return 'Harap lengkapi data di ${_pageNames[pageIndex]}';
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

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _formPages.map((pageContent) {
          return CommonLayout(child: pageContent);
        }).toList(),
      ),
    );
  }
}
