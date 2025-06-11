import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/providers/image_data_provider.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/make_new_report_button.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/providers/form_step_provider.dart'; // Import form_step_provider
import 'package:form_app/pages/multi_step_form_screen.dart'; // Import MultiStepFormScreen


class FinishedPage extends ConsumerStatefulWidget {
  const FinishedPage({super.key});

  @override
  ConsumerState<FinishedPage> createState() => _FinishedPageState();
}

class _FinishedPageState extends ConsumerState<FinishedPage>{

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
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
              );
            },
          ),
        ),
        SizedBox(
          width: double.infinity,
          child: MakeNewReportButton(
            onPressed: () {
              ref.read(formProvider.notifier).resetFormData();
              ref.read(imageDataListProvider.notifier).clearImageData();
              ref.read(formStepProvider.notifier).state = 0; // Reset form step to 0
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (context) => const MultiStepFormScreen()), // Navigate to MultiStepFormScreen
                (Route<dynamic> route) => false, // Remove all routes until the new one
              );
            },
            text: 'Buat Laporan lagi',
          ),
        ),
        const SizedBox(height: 16.0),
        const Footer(),
      ],
    );
  }
}
