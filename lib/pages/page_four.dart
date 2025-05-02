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
  int _interiorSelectedIndex = -1;
  int _eksteriorSelectedIndex = -1;
  int _kakiKakiSelectedIndex = -1;
  int _mesinSelectedIndex = -1;
  int _penilaianKeseluruhanSelectedIndex = -1;

  void _onInteriorItemSelected(int index) {
    setState(() {
      if (_interiorSelectedIndex == index) {
        _interiorSelectedIndex = -1; // Unselect if already selected
      } else {
        _interiorSelectedIndex = index; // Select the tapped index
      }
    });
  }

  void _onEksteriorItemSelected(int index) {
    setState(() {
      if (_eksteriorSelectedIndex == index) {
        _eksteriorSelectedIndex = -1; // Unselect if already selected
      } else {
        _eksteriorSelectedIndex = index; // Select the tapped index
      }
    });
  }

  void _onKakiKakiItemSelected(int index) {
    setState(() {
      if (_kakiKakiSelectedIndex == index) {
        _kakiKakiSelectedIndex = -1; // Unselect if already selected
      } else {
        _kakiKakiSelectedIndex = index; // Select the tapped index
      }
    });
  }

  void _onMesinItemSelected(int index) {
    setState(() {
      if (_mesinSelectedIndex == index) {
        _mesinSelectedIndex = -1; // Unselect if already selected
      } else {
        _mesinSelectedIndex = index; // Select the tapped index
      }
    });
  }

  void _onPenilaianKeseluruhanItemSelected(int index) {
    setState(() {
      if (_penilaianKeseluruhanSelectedIndex == index) {
        _penilaianKeseluruhanSelectedIndex = -1; // Unselect if already selected
      } else {
        _penilaianKeseluruhanSelectedIndex = index; // Select the tapped index
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
                    label: 'Interior',
                    count: 10, // Assuming 10 options based on the image
                    selectedIndex: _interiorSelectedIndex,
                    onItemSelected: _onInteriorItemSelected,
                  ),
                  const SizedBox(height: 24.0),
                  ExpandableTextField(
                    label: 'Keterangan Interior', // Placeholder label
                    hintText: 'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                    onChanged: (value) {
                      // TODO: Handle text changes
                    },
                  ),
                  const SizedBox(height: 32.0),
                  NumberedButtonList(
                    label: 'Eksterior',
                    count: 10, // Assuming 10 options based on the image
                    selectedIndex: _eksteriorSelectedIndex,
                    onItemSelected: _onEksteriorItemSelected,
                  ),
                  const SizedBox(height: 24.0),
                  ExpandableTextField(
                    label: 'Keterangan Eksterior', // Placeholder label
                    hintText: 'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                    onChanged: (value) {
                      // TODO: Handle text changes
                    },
                  ),
                  const SizedBox(height: 32.0),
                  NumberedButtonList(
                    label: 'Kaki-kaki',
                    count: 10, // Assuming 10 options based on the image
                    selectedIndex: _kakiKakiSelectedIndex,
                    onItemSelected: _onKakiKakiItemSelected,
                  ),
                  const SizedBox(height: 24.0),
                  ExpandableTextField(
                    label: 'Keterangan Kaki-kaki', // Placeholder label
                    hintText: 'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                    onChanged: (value) {
                      // TODO: Handle text changes
                    },
                  ),
                  const SizedBox(height: 32.0),
                  NumberedButtonList(
                    label: 'Mesin',
                    count: 10, // Assuming 10 options based on the image
                    selectedIndex: _mesinSelectedIndex,
                    onItemSelected: _onMesinItemSelected,
                  ),
                  const SizedBox(height: 24.0),
                  ExpandableTextField(
                    label: 'Keterangan Mesin', // Placeholder label
                    hintText: 'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                    onChanged: (value) {
                      // TODO: Handle text changes
                    },
                  ),
                  const SizedBox(height: 32.0),
                  NumberedButtonList(
                    label: 'Penilaian Keseluruhan',
                    count: 10, // Assuming 10 options based on the image
                    selectedIndex: _penilaianKeseluruhanSelectedIndex,
                    onItemSelected: _onPenilaianKeseluruhanItemSelected,
                  ),
                  const SizedBox(height: 24.0),
                  ExpandableTextField(
                    label: 'Deskripsi Keseluruhan', // Placeholder label
                    hintText: 'Deskripsi 1\nDeskripsi 2\nDeskripsi 3', // Multi-line hint text
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
