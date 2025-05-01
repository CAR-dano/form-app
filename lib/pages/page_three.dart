import 'package:flutter/material.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/toggle_option_widget.dart';
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Three
class PageThree extends StatelessWidget {
  const PageThree({super.key});

  @override
  Widget build(BuildContext context) {
    // Basic structure, replace with actual content later
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '3/9'),
                const SizedBox(height: 8.0),
                PageTitle(data: 'Kelengkapan'),
                const SizedBox(height: 24.0),
                ToggleOptionWidget(label: 'Buku Service'),
                const SizedBox(height: 16.0),
                ToggleOptionWidget(label: 'Kunci Serep'),
                const SizedBox(height: 16.0),
                ToggleOptionWidget(label: 'Buku Manual'),
                const SizedBox(height: 16.0),
                ToggleOptionWidget(label: 'Ban Serep'),
                const SizedBox(height: 16.0),
                ToggleOptionWidget(label: 'BPKP'),
                const SizedBox(height: 16.0),
                ToggleOptionWidget(label: 'Dongkrak'),
                const SizedBox(height: 16.0),
                ToggleOptionWidget(label: 'Toolkit'),
                const SizedBox(height: 16.0),
                ToggleOptionWidget(label: 'No Rangka'),
                const SizedBox(height: 16.0),
                ToggleOptionWidget(label: 'No Mesin'),
                const SizedBox(height: 32.0),
                NavigationButtonRow(
                  onBackPressed: () => Navigator.pop(context),
                  onNextPressed: () {
                    // TODO: Implement navigation to Page Four
                  },
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0), 
        Footer(),
      ],
    );
  }
}
