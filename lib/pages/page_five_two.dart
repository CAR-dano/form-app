import 'package:flutter/material.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_five_three.dart'; // Import PageFiveThree

class PageFiveTwo extends StatelessWidget {
  const PageFiveTwo({super.key});

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
                  PageNumber(data: '5.2/9'),
                  const SizedBox(height: 8.0),
                  PageTitle(data: 'Page Five - Part 2'), // Placeholder Title
                  const SizedBox(height: 24.0),
                  const Center(child: Text('Page Five Part 2 Content Goes Here')),
                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageFiveThree()),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Footer(),
        ],
      ),
    );
  }
}
