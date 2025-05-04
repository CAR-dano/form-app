import 'package:flutter/material.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/pages/page_seven.dart'; // Import PageSeven
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Six
class PageSix extends StatelessWidget {
  const PageSix({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic structure, replace with actual content later
    return CommonLayout(
      child: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PageNumber(data: '6/9'),
                  const SizedBox(height: 8.0),
                  PageTitle(data: 'Page Six Title'), // Placeholder Title
                  const SizedBox(height: 24.0),
                  const Center(child: Text('Page Six Content Goes Here')),
                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const PageSeven()),
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
