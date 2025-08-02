import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/formatters/date_input_formatter.dart';
import 'package:form_app/utils/crashlytics_util.dart';

class LabeledDateInputField extends ConsumerStatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<DateTime?>? onChanged;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool formSubmitted;
  final String? initialValue;

  const LabeledDateInputField({
    super.key,
    required this.label,
    this.hintText = 'DD/MM/YYYY',
    this.controller,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.formSubmitted = false,
    this.initialValue,
  });

  @override
  ConsumerState<LabeledDateInputField> createState() => _LabeledDateInputFieldState();
}

class _LabeledDateInputFieldState extends ConsumerState<LabeledDateInputField> {
  final _formFieldKey = GlobalKey<FormFieldState<String>>();
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  DateTime? _parseDateString(String? dateString) {
    if (dateString == null || dateString.isEmpty || dateString.length != 10) {
      return null;
    }
    try {
      final parts = dateString.split('/');
      if (parts.length == 3) {
        final day = int.parse(parts[0]);
        final month = int.parse(parts[1]);
        final year = int.parse(parts[2]);
        return DateTime(year, month, day);
      }
    } catch (e, s) {
      ref.read(crashlyticsUtilProvider).recordError(e, s, reason: 'Error parsing date string in LabeledDateInputField');
      // Invalid date format, return null
    }
    return null;
  }

  @override
  void didUpdateWidget(LabeledDateInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && widget.initialValue != oldWidget.initialValue) {
      if (_internalController.text != widget.initialValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final bool hasFocus = widget.focusNode?.hasFocus ?? _formFieldKey.currentContext?.owner?.focusManager.primaryFocus?.context == _formFieldKey.currentContext;

            if (!hasFocus || _internalController.text != widget.initialValue) {
              final currentSelection = _internalController.selection;
              _internalController.text = widget.initialValue ?? '';
              if (currentSelection.start <= _internalController.text.length &&
                  currentSelection.end <= _internalController.text.length) {
                _internalController.selection = currentSelection;
              } else {
                _internalController.selection = TextSelection.fromPosition(
                    TextPosition(offset: _internalController.text.length));
              }
            }
          }
        });
      }
    }
    // The formSubmitted logic is now handled by the validator directly
  }

  String? _validateDate(String? value) {
    if (widget.formSubmitted && (value == null || value.isEmpty)) {
      return 'Tanggal belum terisi'; // Return error for empty
    }

    // Check if format matches DD/MM/YYYY
    final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (value == null || !dateRegex.hasMatch(value)) {
      return 'Format tanggal harus DD/MM/YYYY';
    }

    // Parse and validate the actual date
    try {
      final parts = value.split('/');
      final day = int.parse(parts[0]);
      final month = int.parse(parts[1]);
      final year = int.parse(parts[2]);

      // Basic validation
      if (month < 1 || month > 12) {
        return 'Bulan tidak valid (01-12)';
      }
      if (day < 1 || day > 31) {
        return 'Tanggal tidak valid (01-31)';
      }
      if (year < 1900 || year > 2100) {
        return 'Tahun tidak valid';
      }

      // Create DateTime to validate the actual date
      final date = DateTime(year, month, day);
      if (date.day != day || date.month != month || date.year != year) {
        return 'Tanggal tidak valid';
      }
    } catch (e, s) {
      ref.read(crashlyticsUtilProvider).recordError(e, s, reason: 'Error validating date in LabeledDateInputField');
      return 'Format tanggal tidak valid';
    }

    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: 4.0),
        TextFormField(
          key: _formFieldKey,
          controller: _internalController,
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
            DateInputFormatter(),
          ],
          onChanged: (value) {
            final parsedDate = _parseDateString(value);
            widget.onChanged?.call(parsedDate);
            // Validate on change if form has already been marked as submitted
            if (widget.formSubmitted) {
              _formFieldKey.currentState?.validate();
            }
          },
          validator: (value) {
            // First run custom date validation
            final dateError = _validateDate(value);
            if (dateError != null) {
              return dateError;
            }
            // Then run user-provided validator
            // Pass the formSubmitted value to the page_two validator
            return widget.validator?.call(value);
          },
          style: inputTextStyling,
          focusNode: widget.focusNode,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: hintTextStyling,
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            isDense: true,
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: borderColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: borderColor, width: 2.0),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: errorBorderColor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: errorBorderColor, width: 2.0),
            ),
            errorStyle: const TextStyle(color: errorBorderColor, fontSize: 12.0, height: 1.2),
            errorMaxLines: 2,
          ),
        ),
      ],
    );
  }
}
