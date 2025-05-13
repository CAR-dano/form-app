import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/statics/app_styles.dart';

class LabeledDropdownField<T> extends ConsumerStatefulWidget {
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
  ConsumerState<LabeledDropdownField<T>> createState() => _LabeledDropdownFieldState<T>();
}

class _LabeledDropdownFieldState<T> extends ConsumerState<LabeledDropdownField<T>> {
  final GlobalKey<FormFieldState<T>> _formFieldKey = GlobalKey<FormFieldState<T>>();
  bool _hasValidationOrApiError = false;

  String? _internalValidator(T? value) {
    final errorString = widget.validator?.call(value);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        final currentErrorState = errorString != null;
        if (_hasValidationOrApiError != currentErrorState) {
          if (_hasValidationOrApiError != currentErrorState && ref.read(widget.itemsProvider) is! AsyncError) {
             setState(() {
                _hasValidationOrApiError = currentErrorState;
             });
          }
        }
      }
    });
    return errorString;
  }

  void _handleChanged(T? newValue) {
    widget.onChanged?.call(newValue);
    // Validate after change to update error state if autovalidateMode is onUserInteraction
    // and to allow _internalValidator to update _hasValidationError
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted && _formFieldKey.currentState != null) {
        _formFieldKey.currentState!.validate(); 
      }
    });
  }

  Widget _buildDropdownUI({
    required List<T> items,
    required String? hint,
    bool isLoading = false,
    bool isApiError = false,
    VoidCallback? onRetry,
  }) {
    bool showErrorStyling = _hasValidationOrApiError || isApiError;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: 4.0),
        DropdownButtonFormField<T>(
          key: _formFieldKey,
          value: widget.value,
          hint: hint != null ? Text(hint, style: hintTextStyling.copyWith(color: isApiError ? errorBorderColor : null)) : null,
          items: items.map((itemValue) {
            return DropdownMenuItem<T>(
              value: itemValue,
              child: Text(itemValue.toString()),
            );
          }).toList(),
          onChanged: isLoading ? null : _handleChanged,
          validator: _internalValidator, // Use the wrapped validator
          autovalidateMode: AutovalidateMode.onUserInteraction,
          style: inputTextStyling,
          dropdownColor: Colors.white,
          iconEnabledColor: showErrorStyling ? errorBorderColor : iconColor,
          iconDisabledColor: showErrorStyling ? errorBorderColor : iconColor,
          decoration: _inputDecoration(showErrorStyling),
        ),
        if (isApiError && onRetry != null) ...[
          Padding(
            padding: const EdgeInsets.only(top: 8.0),
            child: Row(
              children: [
                Text(widget.errorHintText ?? 'Gagal memuat data.', style: const TextStyle(color: Colors.red, fontSize: 12)),
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

  @override
  Widget build(BuildContext context) {
    final asyncItems = ref.watch(widget.itemsProvider);

    final bool currentApiError = asyncItems is AsyncError;
    if (currentApiError && !_hasValidationOrApiError) {
      if (mounted && _hasValidationOrApiError != currentApiError) {
         WidgetsBinding.instance.addPostFrameCallback((_) {
            if(mounted) {
                 setState(() {
                    _hasValidationOrApiError = currentApiError;
                 });
            }
         });
      }
    }


    return asyncItems.when(
      data: (items) {
        String currentHint = widget.initialHintText ?? 'Pilih item';
        if (items.isEmpty && widget.value == null) {
          currentHint = widget.emptyDataHintText ?? 'Tidak ada item tersedia';
        }
        return _buildDropdownUI(
          items: items,
          hint: widget.value != null ? null : currentHint,
          isApiError: false,
        );
      },
      loading: () {
        return _buildDropdownUI(
          items: [],
          hint: widget.loadingHintText ?? 'Memuat...',
          isLoading: true,
          isApiError: false,
        );
      },
      error: (err, stack) {
        return _buildDropdownUI(
          items: [],
          hint: widget.errorHintText ?? 'Gagal memuat',
          isApiError: true,
          onRetry: () {
            if(mounted) {
                setState(() {
                    _hasValidationOrApiError = false;
                });
            }
            ref.invalidate(widget.itemsProvider);
          }
        );
      },
    );
  }

  InputDecoration _inputDecoration(bool isError) {
    return InputDecoration(
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: isError ? errorBorderColor : borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: isError ? errorBorderColor : borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: BorderSide(color: isError ? errorBorderColor : borderColor, width: 2.0),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorBorderColor, width: 1.5),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: errorBorderColor, width: 2.0),
      ),
    );
  }
}
