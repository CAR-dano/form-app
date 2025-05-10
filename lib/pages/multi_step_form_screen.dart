import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_step_provider.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
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

  @override
  void initState() {
    super.initState();
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

    return Scaffold(
      body: CommonLayout(
        child: IndexedStack(
          index: currentStep,
          children: _formPages,
        ),
      ),
    );
  }
}
