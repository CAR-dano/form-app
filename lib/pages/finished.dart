import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/custom_button.dart';

class FinishedPage extends StatefulWidget {
  const FinishedPage({super.key});

  @override
  State<FinishedPage> createState() => _FinishedPageState();
}

class _FinishedPageState extends State<FinishedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
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
                      width: 100,
                      height: 100,
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
              CustomButton(
                onPressed: () {
                  // TODO: Implement button action
                },
                text: 'Buat Laporan lagi',
              ),
              const SizedBox(height: 16.0),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
