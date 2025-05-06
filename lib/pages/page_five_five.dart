import 'package:flutter/material.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/heading_one.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_six.dart'; // Import PageFiveSix

class PageFiveFive extends StatelessWidget {
  const PageFiveFive({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonLayout(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '5/9'),
                  const SizedBox(height: 8.0),
                  PageTitle(data: 'Penilaian (5)'),
                  const SizedBox(height: 24.0),
                  const HeadingOne(text: 'Ban dan Kaki-kaki'),
                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageFiveSix()),
                      );
                    },
                  ),
                  const SizedBox(height: 32.0), // Optional spacing below the content
                  // Footer
                  Footer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
