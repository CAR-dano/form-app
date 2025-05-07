import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/make_new_report_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/pages/page_one.dart'; // Import PageOne
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/pages/page_nine.dart'; // Import PageNine


class FinishedPage extends ConsumerStatefulWidget {
  const FinishedPage({super.key});

  @override
  ConsumerState<FinishedPage> createState() => _FinishedPageState();
}

class _FinishedPageState extends ConsumerState<FinishedPage> {
  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  'assets/images/check.svg',
                  width: 185.5,
                  height: 185.5,
                ),
                const SizedBox(height: 24.0),
                Text(
                  'Data Terkirim',
                  style: pageTitleStyle,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 8.0),
                Text(
                  'Terima kasih atas kerja kerasnya',
                  style: labelStyle,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: MakeNewReportButton(
            onPressed: () {
              ref.read(formProvider.notifier).resetFormData();
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const CommonLayout(child: PageOne())),
                (Route<dynamic> route) => false, // Remove all routes until the new one
              );
            },
            text: 'Buat Laporan lagi',
          ),
          ),
          // const SizedBox(height: 8.0), // Added spacing
          // SizedBox(
          //   width: double.infinity,
          //   child: ElevatedButton(
          //     onPressed: () {
          //       Navigator.of(context).pushReplacement(
          //         MaterialPageRoute(builder: (context) => PageNine()),
          //       );
          //     },
          //     child: const Text('Go to Page Nine'),
          //   ),
          // ),
          const SizedBox(height: 16.0),
          const Footer(),
        ],
      ),
    );
  }
}
