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
// import 'package:form_app/pages/page_six_dokumen.dart'; // Removed as per user feedback
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
  ];

  late final List<Widget> _formPages;
  // int _previousStep = 0; // Removed as it's no longer used with default FadeTransition

  @override
  void initState() {
    super.initState();
    // Initialize _previousStep with the initial step from the provider
    // However, ref is not available in initState directly for listeners in the same way.
    // We will use ref.listen in the build method or another lifecycle method where ref is available.
    // For now, _formPages initialization remains here.
    _formPages = [
      PageOne(key: const PageStorageKey('pageOne'), formKey: _formKeys[0]),
      PageTwo(key: const PageStorageKey('pageTwo'), formKey: _formKeys[1]),
      const PageThree(key: PageStorageKey('pageThree')),
      const PageFour(key: PageStorageKey('pageFour')),
      const PageFiveOne(key: PageStorageKey('pageFiveOne')),
      const PageFiveTwo(key: PageStorageKey('pageFiveTwo')),
      const PageFiveThree(key: PageStorageKey('pageFiveThree')),
      const PageFiveFour(key: PageStorageKey('pageFiveFour')),
      const PageFiveFive(key: PageStorageKey('pageFiveFive')),
      const PageFiveSix(key: PageStorageKey('pageFiveSix')),
      const PageFiveSeven(key: PageStorageKey('pageFiveSeven')),
      const PageSixGeneralWajib(key: PageStorageKey('pageSixGeneralWajib')),
      const PageSixGeneralTambahan(key: PageStorageKey('pageSixGeneralTambahan')),
      const PageSixEksteriorWajib(key: PageStorageKey('pageSixEksteriorWajib')),
      const PageSixEksteriorTambahan(key: PageStorageKey('pageSixEksteriorTambahan')),
      const PageSixInteriorWajib(key: PageStorageKey('pageSixInteriorWajib')),
      const PageSixInteriorTambahan(key: PageStorageKey('pageSixInteriorTambahan')),
      const PageSixMesinWajib(key: PageStorageKey('pageSixMesinWajib')),
      const PageSixMesinTambahan(key: PageStorageKey('pageSixMesinTambahan')),
      const PageSixKakiKakiWajib(key: PageStorageKey('pageSixKakiKakiWajib')),
      const PageSixKakiKakiTambahan(key: PageStorageKey('pageSixKakiKakiTambahan')),
      const PageSixAlatAlatWajib(key: PageStorageKey('pageSixAlatAlatWajib')),
      const PageSixAlatAlatTambahan(key: PageStorageKey('pageSixAlatAlatTambahan')),
      const PageSeven(key: PageStorageKey('pageSeven')),
      const PageEight(key: PageStorageKey('pageEight')),
      const PageNine(key: PageStorageKey('pageNine')),
      const FinishedPage(key: PageStorageKey('finishedPage')),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final currentStep = ref.watch(formStepProvider);
    //final totalSteps = _formPages.length;

    // Removed ref.listen for _previousStep as it's no longer used.

    return Scaffold(
      body: CommonLayout(
        child: AnimatedSwitcher(
          duration: const Duration(milliseconds: 150), // You can adjust the duration
          layoutBuilder: (Widget? currentChild, List<Widget> previousChildren) {
            return Stack(
              alignment: Alignment.topCenter, // Align children to the top center
              children: <Widget>[
                ...previousChildren,
                if (currentChild != null) currentChild,
              ],
            );
          },
          // No transitionBuilder specified, so it defaults to FadeTransition
          child: Container( 
            key: ValueKey<int>(currentStep), // Crucial for AnimatedSwitcher to detect change
            child: _formPages[currentStep],
          ),
        ),
      ),
    );
  }
}
