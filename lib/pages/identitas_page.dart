import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_provider.dart'; // Import the provider
import 'package:form_app/providers/user_info_provider.dart';
import 'package:form_app/widgets/footer.dart';
import 'package:form_app/widgets/labeled_text.dart';
import 'package:form_app/widgets/page_title.dart';
import 'package:form_app/widgets/labeled_text_field.dart';

class IdentitasPage extends ConsumerStatefulWidget {
  final GlobalKey<FormState> formKey;
  final ValueNotifier<bool> formSubmitted;

  const IdentitasPage({
    super.key,
    required this.formKey,
    required this.formSubmitted,
  });

  @override
  ConsumerState<IdentitasPage> createState() => _IdentitasPageState();
}

class _IdentitasPageState extends ConsumerState<IdentitasPage>
    with AutomaticKeepAliveClientMixin {
  bool _hasValidatedOnSubmit = false; // Declare the state variable

  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final formData = ref.watch(formProvider);
    final formNotifier = ref.read(formProvider.notifier);
    final userInfo = ref.watch(userInfoProvider);

    var hariIni = '${DateTime.now().day.toString().padLeft(2, '0')}/'
        '${DateTime.now().month.toString().padLeft(2, '0')}/'
        '${DateTime.now().year}';

    return ValueListenableBuilder<bool>(
      // Add ValueListenableBuilder here
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
          key: widget.formKey,
          child: child!, // Pass the original child
        );
      },
      child: SingleChildScrollView(
        clipBehavior: Clip.none,
        key: const PageStorageKey<String>(
            'pageOneScrollKey'), // Add PageStorageKey here
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const PageTitle(data: 'Identitas'),
            const SizedBox(height: 6.0),
            LabeledText(
              label: 'Nama Inspektor',
              value: userInfo.asData?.value?.name ?? 'Memuat...',
            ),
            const SizedBox(height: 16.0),
            LabeledTextField(
              label: 'Nama Customer',
              hintText: 'Masukkan nama customer',
              initialValue: formData.namaCustomer,
              onChanged: (value) {
                formNotifier.updateNamaCustomer(value);
              },
              validator: (value) {
                if (widget.formSubmitted.value &&
                    (value == null || value.isEmpty)) {
                  return 'Nama Customer belum terisi';
                }
                return null;
              },
              formSubmitted: widget.formSubmitted.value,
            ),
            const SizedBox(height: 16.0),
            LabeledText(
              label: 'Cabang Inspeksi',
              value: formData.cabangInspeksi?.city ?? 'Memuat...',
            ),
            const SizedBox(height: 16.0),
            LabeledText(
              label: 'Tanggal Inspeksi',
              value: hariIni,
            ),
            const SizedBox(height: 32.0),
            const Footer()
          ],
        ),
      ),
    );
  }
}
