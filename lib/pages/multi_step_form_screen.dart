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
      PageOne(formKey: _formKeys[0]),
      PageTwo(formKey: _formKeys[1]),
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
      const PageNine(),
      const FinishedPage(),
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
          duration: const Duration(milliseconds: 300), // You can adjust the duration
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
