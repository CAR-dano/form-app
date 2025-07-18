import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/models/form_data.dart'; // Import FormData
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_date_input_field.dart';
import 'package:form_app/widgets/labeled_text_field.dart';
import 'package:form_app/widgets/page_title.dart';

class DataKendaraanPage extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> formSubmitted; // New parameter

  const DataKendaraanPage({
    super.key,
    required this.formKey,
    required this.formSubmitted, // Update constructor
  });

  @override
  ConsumerState<DataKendaraanPage> createState() => _DataKendaraanPageState();
}

class _DataKendaraanPageState extends ConsumerState<DataKendaraanPage> with AutomaticKeepAliveClientMixin {
  late FocusScopeNode _focusScopeNode;
  bool _hasValidatedOnSubmit = false; // Declare the state variable

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _focusScopeNode = FocusScopeNode();
  }

  @override
  void dispose() {
    _focusScopeNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context); // Call super.build(context) for AutomaticKeepAliveClientMixin
    final formData = ref.watch(formProvider); // Watch the form data
    final formNotifier = ref.read(formProvider.notifier); // Read the notifier

    // Return the core content Column directly. Scaffold/SafeArea are in CommonLayout.
    return PopScope(
      // Wrap with PopScope
      onPopInvokedWithResult: (bool didPop, dynamic result) {
        if (didPop) {
          _focusScopeNode.unfocus(); // Unfocus when navigating back
        }
      },
      child: FocusScope(
        node: _focusScopeNode,
        child: ValueListenableBuilder<bool>( // Add ValueListenableBuilder here
          valueListenable: widget.formSubmitted,
          builder: (context, isFormSubmitted, child) {
            if (isFormSubmitted && !_hasValidatedOnSubmit) {
              WidgetsBinding.instance.addPostFrameCallback((_) {
                if (mounted) {
                  widget.formKey.currentState?.validate();
                  setState(() {
                    _hasValidatedOnSubmit = true;
                  });
                }
              });
            }
            return Form(
              key: widget.formKey, // Use the passed formKey
              child: child!, // Pass the original child
            );
          },
          child: GestureDetector(
            // Wrap with GestureDetector
            onTap: () {
              _focusScopeNode.unfocus(); // Unfocus on tap outside text fields
            },
          child: CustomScrollView(
            key: const PageStorageKey<String>('pageTwoScrollKey'),
            slivers: [
              const SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    PageTitle(data: 'Data Kendaraan'), // Updated Title
                    SizedBox(height: 6.0),
                  ],
                ),
              ),
              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final fieldData = _buildInputFields(formData, formNotifier)[index];
                    if (fieldData['isDateField'] == true) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: LabeledDateInputField(
                          label: fieldData['label'],
                          hintText: fieldData['hintText'],
                          onChanged: fieldData['onChanged'],
                          validator: fieldData['validator'],
                          initialValue: fieldData['initialValue'] != null
                              ? '${(fieldData['initialValue'] as DateTime).day.toString().padLeft(2, '0')}/${(fieldData['initialValue'] as DateTime).month.toString().padLeft(2, '0')}/${(fieldData['initialValue'] as DateTime).year}'
                              : null,
                          formSubmitted: widget.formSubmitted.value, // Pass the boolean value
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: LabeledTextField(
                          label: fieldData['label'],
                          hintText: fieldData['hintText'],
                          keyboardType: fieldData['keyboardType'],
                          onChanged: fieldData['onChanged'],
                          validator: fieldData['validator'],
                          initialValue: fieldData['initialValue'],
                          formSubmitted: widget.formSubmitted.value,
                          useThousandsSeparator: fieldData['useThousandsSeparator'] ?? true,
                          suffixText: fieldData['suffixText'],
                        ),
                      );
                    }
                  },
                  childCount: _buildInputFields(formData, formNotifier).length,
                ),
              ),
              const SliverToBoxAdapter(
                child: Column(
                  children: [
                    SizedBox(height: 32.0), // Spacing before buttons
                    SizedBox(height: 24.0),
                    Footer(),
                  ],
                ),
              ),
              SliverPadding(
                padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewPadding.bottom + 90),
              ),
            ],
          ),
          ),
        ),
      ),
    );
  }

  List<Map<String, dynamic>> _buildInputFields(FormData formData, FormNotifier formNotifier) {
    final List<Map<String, dynamic>> inputFieldsData = [
      {
        'label': 'Merek Kendaraan',
        'hintText': 'Misal : Honda',
        'keyboardType': TextInputType.text,
        'initialValue': formData.merekKendaraan,
        'onChanged': (value) => formNotifier.updateMerekKendaraan(value),
        'validator': (value) {
          if (widget.formSubmitted.value && (value == null || value.isEmpty)) {
            return 'Merek Kendaraan belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Tipe Kendaraan',
        'hintText': 'Misal : City 1.5 HB RS CVT',
        'keyboardType': TextInputType.text,
        'initialValue': formData.tipeKendaraan,
        'onChanged': (value) => formNotifier.updateTipeKendaraan(value),
        'validator': (value) {
          if (widget.formSubmitted.value && (value == null || value.isEmpty)) {
            return 'Tipe Kendaraan belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Tahun',
        'hintText': 'Misal : 2022',
        'keyboardType': TextInputType.number,
        'useThousandsSeparator': false,
        'initialValue': formData.tahun,
        'onChanged': (value) => formNotifier.updateTahun(value),
        'validator': (value) {
          if (widget.formSubmitted.value && (value == null || value.isEmpty)) {
            return 'Tahun belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Transmisi',
        'hintText': 'Misal : Automatis CVT',
        'keyboardType': TextInputType.text,
        'initialValue': formData.transmisi,
        'onChanged': (value) => formNotifier.updateTransmisi(value),
        'validator': (value) {
          if (widget.formSubmitted.value && (value == null || value.isEmpty)) {
            return 'Transmisi belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Warna Kendaraan',
        'hintText': 'Misal : Kuning',
        'keyboardType': TextInputType.text,
        'initialValue': formData.warnaKendaraan,
        'onChanged': (value) => formNotifier.updateWarnaKendaraan(value),
        'validator': (value) {
          if (widget.formSubmitted.value && (value == null || value.isEmpty)) {
            return 'Warna Kendaraan belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Odometer',
        'hintText': 'Misal : 43.456',
        'keyboardType': TextInputType.number,
        'suffixText': 'km',
        'initialValue': formData.odometer,
        'onChanged': (value) => formNotifier.updateOdometer(value),
        'validator': (value) {
          if (widget.formSubmitted.value && (value == null || value.isEmpty)) {
            return 'Odometer belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Kepemilikan',
        'hintText': 'Misal : Pribadi',
        'keyboardType': TextInputType.text,
        'initialValue': formData.kepemilikan,
        'onChanged': (value) => formNotifier.updateKepemilikan(value),
        'validator': (value) {
          if (widget.formSubmitted.value && (value == null || value.isEmpty)) {
            return 'Kepemilikan belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Plat Nomor',
        'hintText': 'Misal : AB 1234 CD',
        'keyboardType': TextInputType.text,
        'initialValue': formData.platNomor,
        'onChanged': (value) => formNotifier.updatePlatNomor(value),
        'validator': (value) {
          if (widget.formSubmitted.value && (value == null || value.isEmpty)) {
            return 'Plat Nomor belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Pajak 1 Tahun s.d.',
        'hintText': 'DD/MM/YYYY',
        'isDateField': true,
        'initialValue': formData.pajak1TahunDate,
        'onChanged': (date) {
          if (date != null) {
            formNotifier.updatePajak1TahunDate(DateTime(date.year, date.month, date.day, 12, 0, 0));
          } else {
            formNotifier.updatePajak1TahunDate(null);
          }
        },
        'validator': (value) {
          if (widget.formSubmitted.value && value == null) {
            return 'Pajak 1 Tahun s.d. belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Pajak 5 Tahun s.d.',
        'hintText': 'DD/MM/YYYY',
        'isDateField': true,
        'initialValue': formData.pajak5TahunDate,
        'onChanged': (date) {
          if (date != null) {
            formNotifier.updatePajak5TahunDate(DateTime(date.year, date.month, date.day, 12, 0, 0));
          } else {
            formNotifier.updatePajak5TahunDate(null);
          }
        },
        'validator': (value) {
          if (widget.formSubmitted.value && value == null) {
            return 'Pajak 5 Tahun s.d. belum terisi';
          }
          return null;
        },
      },
      {
        'label': 'Biaya Pajak',
        'hintText': 'Misal : 3.123.456',
        'suffixText': 'Rp',
        'keyboardType': TextInputType.number,
        'initialValue': formData.biayaPajak,
        'onChanged': (value) => formNotifier.updateBiayaPajak(value),
        'validator': (value) {
          if (widget.formSubmitted.value && (value == null || value.isEmpty)) {
            return 'Biaya Pajak belum terisi';
          }
          return null;
        },
      },
    ];

    return inputFieldsData;
  }
}
