import 'package:flutter/material.dart';
import 'package:form_app/pages/page_two.dart';
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
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const PageTwo(), // Replace with your next page
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(
          context,
        ).unfocus(); // Dismiss the keyboard when tapping outside
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          // Main Column to structure the page with a sticky footer
          child: Column(
            children: [
              // Expanded takes up available space, pushing footer down
              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(16), // Keep the overall margin
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        PageNumber(data: '1/9'),
                        const SizedBox(height: 8.0),
                        PageTitle(data: 'Identitas'),
                        const SizedBox(height: 24.0),
                        LabeledTextField(
                          label: 'Nama Inspektor',
                          hintText: 'Masukkan nama inspektor',
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Nama Customer',
                          hintText: 'Masukkan nama customer',
                        ),
                        const SizedBox(height: 16.0),
                        LabeledTextField(
                          label: 'Cabang Inspeksi',
                          hintText: 'Contoh: Yogyakarta / Semarang',
                        ),
                        const SizedBox(height: 16.0),
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
                        const SizedBox(height: 32.0),
                        NavigationButtonRow(onNextPressed: moveToNextPage),
                        // Removed Spacer() here
                      ],
                    ),
                  ),
                ),
              ),
              // Footer is placed outside Expanded, at the bottom of the main Column
              Footer(),
              // Add some padding below the footer if needed, e.g.,
              // const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }
}

