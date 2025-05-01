import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/providers/form_provider.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/widgets/page_number.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/numbered_button_list.dart';
import 'package:form_app/widgets/common_layout.dart';
import 'package:form_app/widgets/expandable_text_field.dart';

// Placeholder for Page Four
class PageFour extends ConsumerStatefulWidget {
  const PageFour({super.key});

  @override
  ConsumerState<PageFour> createState() => _PageFourState();
}

class _PageFourState extends ConsumerState<PageFour> {
  late int _interiorSelectedIndex;
  late int _eksteriorSelectedIndex;
  late int _kakiKakiSelectedIndex;
  late int _mesinSelectedIndex;
  late int _penilaianKeseluruhanSelectedIndex;

  late TextEditingController _keteranganInteriorController;
  late TextEditingController _keteranganEksteriorController;
  late TextEditingController _keteranganKakiKakiController;
  late TextEditingController _keteranganMesinController;
  late TextEditingController _keteranganPenilaianKeseluruhanController;

  @override
  void initState() {
    super.initState();
    final formData = ref.read(formProvider);
    _interiorSelectedIndex = formData.interiorSelectedIndex;
    _eksteriorSelectedIndex = formData.eksteriorSelectedIndex;
    _kakiKakiSelectedIndex = formData.kakiKakiSelectedIndex;
    _mesinSelectedIndex = formData.mesinSelectedIndex;
    _penilaianKeseluruhanSelectedIndex = formData.penilaianKeseluruhanSelectedIndex;

    _keteranganInteriorController = TextEditingController(text: formData.keteranganInterior.join('\n'));
    _keteranganEksteriorController = TextEditingController(text: formData.keteranganEksterior.join('\n'));
    _keteranganKakiKakiController = TextEditingController(text: formData.keteranganKakiKaki.join('\n'));
    _keteranganMesinController = TextEditingController(text: formData.keteranganMesin.join('\n'));
    _keteranganPenilaianKeseluruhanController = TextEditingController(text: formData.keteranganPenilaianKeseluruhan.join('\n'));
  }

  @override
  void dispose() {
    _keteranganInteriorController.dispose();
    _keteranganEksteriorController.dispose();
    _keteranganKakiKakiController.dispose();
    _keteranganMesinController.dispose();
    _keteranganPenilaianKeseluruhanController.dispose();
    super.dispose();
  }

  void _onInteriorItemSelected(int index) {
    setState(() {
      if (_interiorSelectedIndex == index) {
        _interiorSelectedIndex = -1; // Unselect if already selected
      } else {
        _interiorSelectedIndex = index; // Select the tapped index
      }
    });
    ref.read(formProvider.notifier).updateInteriorSelectedIndex(_interiorSelectedIndex);
  }

  void _onEksteriorItemSelected(int index) {
    setState(() {
      if (_eksteriorSelectedIndex == index) {
        _eksteriorSelectedIndex = -1; // Unselect if already selected
      } else {
        _eksteriorSelectedIndex = index; // Select the tapped index
      }
    });
    ref.read(formProvider.notifier).updateEksteriorSelectedIndex(_eksteriorSelectedIndex);
  }

  void _onKakiKakiItemSelected(int index) {
    setState(() {
      if (_kakiKakiSelectedIndex == index) {
        _kakiKakiSelectedIndex = -1; // Unselect if already selected
      } else {
        _kakiKakiSelectedIndex = index; // Select the tapped index
      }
    });
    ref.read(formProvider.notifier).updateKakiKakiSelectedIndex(_kakiKakiSelectedIndex);
  }

  void _onMesinItemSelected(int index) {
    setState(() {
      if (_mesinSelectedIndex == index) {
        _mesinSelectedIndex = -1; // Unselect if already selected
      } else {
        _mesinSelectedIndex = index; // Select the tapped index
      }
    });
    ref.read(formProvider.notifier).updateMesinSelectedIndex(_mesinSelectedIndex);
  }

  void _onPenilaianKeseluruhanItemSelected(int index) {
    setState(() {
      if (_penilaianKeseluruhanSelectedIndex == index) {
        _penilaianKeseluruhanSelectedIndex = -1; // Unselect if already selected
      } else {
        _penilaianKeseluruhanSelectedIndex = index; // Select the tapped index
      }
    });
    ref.read(formProvider.notifier).updatePenilaianKeseluruhanSelectedIndex(_penilaianKeseluruhanSelectedIndex);
  }

  void _onKeteranganInteriorChanged(String value) {
    ref.read(formProvider.notifier).updateKeteranganInterior(value.split('\n'));
  }

  void _onKeteranganEksteriorChanged(String value) {
    ref.read(formProvider.notifier).updateKeteranganEksterior(value.split('\n'));
  }

  void _onKeteranganKakiKakiChanged(String value) {
    ref.read(formProvider.notifier).updateKeteranganKakiKaki(value.split('\n'));
  }

  void _onKeteranganMesinChanged(String value) {
    ref.read(formProvider.notifier).updateKeteranganMesin(value.split('\n'));
  }

  void _onKeteranganPenilaianKeseluruhanChanged(String value) {
    ref.read(formProvider.notifier).updateKeteranganPenilaianKeseluruhan(value.split('\n'));
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
                    controller: _keteranganInteriorController,
                    onChanged: _onKeteranganInteriorChanged,
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
                    controller: _keteranganEksteriorController,
                    onChanged: _onKeteranganEksteriorChanged,
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
                    controller: _keteranganKakiKakiController,
                    onChanged: _onKeteranganKakiKakiChanged,
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
                    controller: _keteranganMesinController,
                    onChanged: _onKeteranganMesinChanged,
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
                    label: 'Keterangan Penilaian Keseluruhan', // Placeholder label
                    hintText: 'keterangan 1\nketerangan 2\nketerangan 3', // Multi-line hint text
                    controller: _keteranganPenilaianKeseluruhanController,
                    onChanged: _onKeteranganPenilaianKeseluruhanChanged,
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
