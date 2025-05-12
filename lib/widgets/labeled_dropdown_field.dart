import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/statics/app_styles.dart';

class LabeledDropdownField<T> extends ConsumerWidget {
  final String label;
  final ProviderBase<AsyncValue<List<T>>> itemsProvider;
  final String? initialHintText;
  final String? loadingHintText;
  final String? emptyDataHintText;
  final String? errorHintText;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final FormFieldValidator<T?>? validator;

  const LabeledDropdownField({
    super.key,
    required this.label,
    required this.itemsProvider,
    this.initialHintText,
    this.loadingHintText,
    this.emptyDataHintText,
    this.errorHintText,
    this.onChanged,
    this.value,
    this.validator,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncItems = ref.watch(itemsProvider);
    final formFieldKey = GlobalKey<FormFieldState<T>>();

    Widget buildDropdown({
      required List<T> items,
      required String? hint,
      bool isLoading = false,
      bool hasError = false,
      VoidCallback? onRetry,
    }) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: labelStyle),
          const SizedBox(height: 4.0),
          DropdownButtonFormField<T>(
            key: formFieldKey,
            value: value,
            hint: hint != null ? Text(hint, style: hintTextStyling.copyWith(color: hasError ? errorBorderColor : null)) : null,
            items: items.map((itemValue) {
              return DropdownMenuItem<T>(
                value: itemValue,
                child: Text(itemValue.toString()),
              );
            }).toList(),
            onChanged: isLoading ? null : onChanged,
            validator: validator,
            autovalidateMode: AutovalidateMode.onUserInteraction, // Explicitly set autovalidateMode
            style: inputTextStyling,
            dropdownColor: Colors.white,
            // Icon color will react to API error state (hasError)
            // To react to validation error, LabeledDropdownField would need to be StatefulWidget
            // and listen/rebuild based on formFieldKey.currentState.hasError.
            iconEnabledColor: hasError ? errorBorderColor : iconColor,
            iconDisabledColor: hasError ? errorBorderColor : iconColor,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: borderColor, width: 1.5),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: borderColor, width: 1.5),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(color: borderColor, width: 2.0),
              ),
              errorBorder: OutlineInputBorder( // Used by DropdownButtonFormField on validation error
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: errorBorderColor, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder( // Used by DropdownButtonFormField on validation error
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: errorBorderColor, width: 2.0),
              ),
              // The errorText (e.g., "Cabang Inspeksi belum terisi") will be displayed by the
              // DropdownButtonFormField itself when validator returns a non-null string.
            ),
          ),
          // if (isLoading) ...[ // Removed LinearProgressIndicator
          //   const SizedBox(height: 2),
          //   const LinearProgressIndicator(minHeight: 2),
          // ],
          if (onRetry != null) ...[
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Row(
                children: [
                  Text(errorHintText ?? 'Gagal memuat.', style: const TextStyle(color: Colors.red, fontSize: 12)),
                  const Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      textStyle: const TextStyle(fontSize: 12)
                    ),
                    onPressed: onRetry,
                    child: const Text('Coba Lagi'),
                  ),
                ],
              ),
            ),
          ]
        ],
      );
    }

    return asyncItems.when(
      data: (items) {
        String currentHint = initialHintText ?? 'Pilih item';
        if (items.isEmpty && value == null) {
          currentHint = emptyDataHintText ?? 'Tidak ada item tersedia';
        }
        return buildDropdown(
          items: items,
          hint: value != null ? null : currentHint,
        );
      },
      loading: () {
        return buildDropdown(
          items: [],
          hint: loadingHintText ?? 'Memuat...',
          isLoading: true,
        );
      },
      error: (err, stack) {
        return buildDropdown(
          items: [],
          hint: errorHintText ?? 'Gagal memuat',
          hasError: true,
          onRetry: () => ref.invalidate(itemsProvider),
        );
      },
    );
  }

  // _inputDecoration method is no longer needed here as the InputDecoration is defined inline
  // or DropdownButtonFormField handles its error state decoration internally.
}
