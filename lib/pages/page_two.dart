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

  late FocusScopeNode _focusScopeNode;
  late FocusNode _merekKendaraanFocusNode;
  late FocusNode _tipeKendaraanFocusNode;
  late FocusNode _tahunFocusNode;
  late FocusNode _transmisiFocusNode;
  late FocusNode _warnaKendaraanFocusNode;
  late FocusNode _odometerFocusNode;
  late FocusNode _kepemilikanFocusNode;
  late FocusNode _platNomorFocusNode;
  late FocusNode _pajak1TahunFocusNode;
  late FocusNode _pajak5TahunFocusNode;
  late FocusNode _biayaPajakFocusNode;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
    _merekKendaraanFocusNode = FocusNode();
    _tipeKendaraanFocusNode = FocusNode();
    _tahunFocusNode = FocusNode();
    _transmisiFocusNode = FocusNode();
    _warnaKendaraanFocusNode = FocusNode();
    _odometerFocusNode = FocusNode();
    _kepemilikanFocusNode = FocusNode();
    _platNomorFocusNode = FocusNode();
    _pajak1TahunFocusNode = FocusNode();
    _pajak5TahunFocusNode = FocusNode();
    _biayaPajakFocusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    _merekKendaraanFocusNode.dispose();
    _tipeKendaraanFocusNode.dispose();
    _tahunFocusNode.dispose();
    _transmisiFocusNode.dispose();
    _warnaKendaraanFocusNode.dispose();
    _odometerFocusNode.dispose();
    _kepemilikanFocusNode.dispose();
    _platNomorFocusNode.dispose();
    _pajak1TahunFocusNode.dispose();
    _pajak5TahunFocusNode.dispose();
    _biayaPajakFocusNode.dispose();
    super.dispose();
  }


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
    return FocusScope(
      node: _focusScopeNode,
      child: Column(
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
                    focusNode: _merekKendaraanFocusNode,
                  ),
                  const SizedBox(height: 16.0),
                  LabeledTextField(
                    label: 'Tipe Kendaraan',
                    hintText: 'Masukkan tipe kendaraan',
                    focusNode: _tipeKendaraanFocusNode,
                  ),
                  const SizedBox(height: 16.0),
                   LabeledTextField(
                    label: 'Tahun',
                    hintText: 'Masukkan tahun pembuatan',
                    keyboardType: TextInputType.number, // Use number keyboard
                    focusNode: _tahunFocusNode,
                  ),
                  const SizedBox(height: 16.0),
                  LabeledTextField(
                    label: 'Transmisi',
                    hintText: 'Contoh: Otomatis / Manual',
                    focusNode: _transmisiFocusNode,
                  ),
                   const SizedBox(height: 16.0),
                  LabeledTextField(
                    label: 'Warna Kendaraan',
                    hintText: 'Masukkan warna kendaraan',
                    focusNode: _warnaKendaraanFocusNode,
                  ),
                  const SizedBox(height: 16.0),
                   LabeledTextField(
                    label: 'Odometer',
                    hintText: 'Masukkan angka odometer (km)',
                     keyboardType: TextInputType.number, // Use number keyboard
                     focusNode: _odometerFocusNode,
                  ),
                  const SizedBox(height: 16.0),
                   LabeledTextField(
                    label: 'Kepemilikan',
                    hintText: 'Contoh: Pribadi / Perusahaan',
                    focusNode: _kepemilikanFocusNode,
                  ),
                  const SizedBox(height: 16.0),
                   LabeledTextField(
                    label: 'Plat Nomor',
                    hintText: 'Masukkan plat nomor',
                    focusNode: _platNomorFocusNode,
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
                    focusNode: _pajak1TahunFocusNode,
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
                    focusNode: _pajak5TahunFocusNode,
                  ),
                  const SizedBox(height: 16.0),
                   LabeledTextField(
                    label: 'Biaya Pajak',
                    hintText: 'Masukkan biaya pajak (Rp)',
                    keyboardType: TextInputType.number, // Use number keyboard
                    focusNode: _biayaPajakFocusNode,
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
      ),
    );
  }
}
