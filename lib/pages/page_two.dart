import 'package:flutter/material.dart';
import 'package:form_app/pages/page_three.dart'; // Assuming PageThree exists or will be created
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_date_field.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';

class PageTwo extends StatefulWidget {
  const PageTwo({super.key});

  @override
  State<PageTwo> createState() => _PageTwoState();
}

class _PageTwoState extends State<PageTwo> {
  DateTime? _pajak1TahunDate;
  DateTime? _pajak5TahunDate;

  void moveToNextPage() {
    // Navigate to Page Three, wrapped in CommonLayout
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const CommonLayout(child: PageThree()), // Wrap PageThree
      ),
    );
  }

  void moveToPreviousPage() {
    Navigator.pop(context); // Simple pop to go back to the previous page (PageOne)
  }

  @override
  Widget build(BuildContext context) {
    // Return the core content Column directly. Scaffold/SafeArea are in CommonLayout.
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                PageNumber(data: '2/9'), // Updated Page Number
                const SizedBox(height: 8.0),
                PageTitle(data: 'Data Kendaraan'), // Updated Title
                const SizedBox(height: 24.0),

                // Input Fields based on user request
                LabeledTextField(
                  label: 'Merek Kendaraan',
                  hintText: 'Masukkan merek kendaraan',
                ),
                const SizedBox(height: 16.0),
                LabeledTextField(
                  label: 'Tipe Kendaraan',
                  hintText: 'Masukkan tipe kendaraan',
                ),
                const SizedBox(height: 16.0),
                 LabeledTextField(
                  label: 'Tahun',
                  hintText: 'Masukkan tahun pembuatan',
                  keyboardType: TextInputType.number, // Use number keyboard
                ),
                const SizedBox(height: 16.0),
                LabeledTextField(
                  label: 'Transmisi',
                  hintText: 'Contoh: Otomatis / Manual',
                ),
                 const SizedBox(height: 16.0),
                LabeledTextField(
                  label: 'Warna Kendaraan',
                  hintText: 'Masukkan warna kendaraan',
                ),
                const SizedBox(height: 16.0),
                 LabeledTextField(
                  label: 'Odometer',
                  hintText: 'Masukkan angka odometer (km)',
                   keyboardType: TextInputType.number, // Use number keyboard
                ),
                const SizedBox(height: 16.0),
                 LabeledTextField(
                  label: 'Kepemilikan',
                  hintText: 'Contoh: Pribadi / Perusahaan',
                ),
                const SizedBox(height: 16.0),
                 LabeledTextField(
                  label: 'Plat Nomor',
                  hintText: 'Masukkan plat nomor',
                ),
                const SizedBox(height: 16.0),
                LabeledDateField(
                  label: 'Pajak 1 Tahun s.d.',
                  hintText: 'Pilih tanggal',
                  initialDate: _pajak1TahunDate,
                  onChanged: (date) {
                    setState(() {
                      _pajak1TahunDate = date;
                    });
                  },
                ),
                 const SizedBox(height: 16.0),
                 LabeledDateField(
                  label: 'Pajak 5 Tahun s.d.',
                  hintText: 'Pilih tanggal',
                  initialDate: _pajak5TahunDate,
                  onChanged: (date) {
                    setState(() {
                      _pajak5TahunDate = date;
                    });
                  },
                ),
                const SizedBox(height: 16.0),
                 LabeledTextField(
                  label: 'Biaya Pajak',
                  hintText: 'Masukkan biaya pajak (Rp)',
                  keyboardType: TextInputType.number, // Use number keyboard
                ),

                const SizedBox(height: 32.0), // Spacing before buttons

                // Navigation Row - Back button is enabled here
                NavigationButtonRow(
                  onBackPressed: moveToPreviousPage, // Enable back navigation
                  onNextPressed: moveToNextPage,
                  // isBackButtonEnabled: true, // Default is true, so can be omitted
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: 16.0), // Optional spacing below the content
        // Footer
        Footer(),
      ],
    );
  }
}
