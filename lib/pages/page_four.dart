import 'package:flutter/material.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/numbered_button_list.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/expandable_text_field.dart';
// Import other necessary widgets like CommonLayout if you plan to use it here

// Placeholder for Page Four
class PageFour extends StatefulWidget {
  const PageFour({super.key});

  @override
  State<PageFour> createState() => _PageFourState();
}

class _PageFourState extends State<PageFour> {
  int _selectedIndex = -1;

  void _onItemSelected(int index) {
    setState(() {
      if (_selectedIndex == index) {
        _selectedIndex = -1; // Unselect if already selected
      } else {
        _selectedIndex = index; // Select the tapped index
      }
    });
  }

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
                  PageNumber(data: '4/9'),
                  const SizedBox(height: 8.0),
                  PageTitle(data: 'Hasil Inspeksi'), // Placeholder Title
                  const SizedBox(height: 24.0),
                  NumberedButtonList(
                    label: 'Eksterior',
                    count: 10, // Assuming 10 options based on the image
                    selectedIndex: _selectedIndex,
                    onItemSelected: _onItemSelected,
                  ),
                  const SizedBox(height: 24.0),
                  ExpandableTextField(
                    label: 'Tambahkan Catatan Eksterior', // Placeholder label
                    hintText: 'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                    onChanged: (value) {
                      // TODO: Handle text changes
                    },
                  ),
                  const SizedBox(height: 32.0),
                  NavigationButtonRow(
                    onBackPressed: () => Navigator.pop(context),
                    onNextPressed: () {
                      // TODO: Implement navigation to Page Five
                    },
                  ),
                  SizedBox(height: 32.0), // Optional spacing below the content
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
