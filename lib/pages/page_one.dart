// page_one.dart
import 'package:flutter/material.dart';
import 'package:form_app/pages/page_two.dart';
import 'package:form_app/widgets/common_layout.dart'; // Import CommonLayout
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_date_field.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/labeled_text_field.dart';


class PageOne extends StatefulWidget {
  const PageOne({super.key});

  @override
  State<PageOne> createState() => _PageOneState();
}

class _PageOneState extends State<PageOne> {
  DateTime? _selectedDate;

  moveToNextPage() {
    // Wrap the next page with CommonLayout as well
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CommonLayout(child: PageTwo()), // Wrap PageTwo
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    // Return the core content Column directly. Scaffold/SafeArea are in CommonLayout.
    // The GestureDetector for unfocus is removed; can be added to CommonLayout if needed globally.
    return Column( // This Column is now the root widget returned by PageOne's build method
      children: [
        // Expanded takes up available space, pushing footer down
        Expanded(
          // Removed the Container with margin, CommonLayout handles padding
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '1/9'),
                const SizedBox(height: 8.0),
                PageTitle(data: 'Identitas'),
                const SizedBox(height: 24.0), // Keep internal spacing
                LabeledTextField(
                  label: 'Nama Inspektor',
                  hintText: 'Masukkan nama inspektor',
                ),
                const SizedBox(height: 16.0), // Keep internal spacing
                LabeledTextField(
                  label: 'Nama Customer',
                  hintText: 'Masukkan nama customer',
                ),
                const SizedBox(height: 16.0), // Keep internal spacing
                LabeledTextField(
                  label: 'Cabang Inspeksi',
                  hintText: 'Contoh: Yogyakarta / Semarang',
                ),
                const SizedBox(height: 16.0), // Keep internal spacing
                LabeledDateField(
                  label: 'Tanggal Inspeksi',
                  hintText: 'Pilih tanggal inspeksi',
                  initialDate: _selectedDate,
                  onChanged: (date) {
                    setState(() {
                      _selectedDate = date;
                    });
                  },
                ),
                const SizedBox(height: 32.0), // Keep internal spacing
                // Pass isBackButtonEnabled: false for PageOne
                NavigationButtonRow(
                  onNextPressed: moveToNextPage,
                  isBackButtonEnabled: false, // Hide back button on page 1
                  // Add onBackPressed: null explicitly if needed, though it won't be used when hidden
                  // onBackPressed: null,
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0), // Optional padding between content and footer
        // Footer is placed outside Expanded, at the bottom of the main Column
        Footer(),
        // Add some padding below the footer if needed, e.g.,
        // const SizedBox(height: 16.0),
      ],
    );
  }
}
