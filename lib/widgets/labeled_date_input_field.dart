import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/formatters/date_input_formatter.dart';

class LabeledDateInputField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
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
  State<LabeledDateInputField> createState() => _LabeledDateInputFieldState();
}

class _LabeledDateInputFieldState extends State<LabeledDateInputField> {
  final _formFieldKey = GlobalKey<FormFieldState<String>>();
  late TextEditingController _internalController;
  String? _errorText;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController(text: widget.initialValue);
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
    if (widget.formSubmitted && !oldWidget.formSubmitted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          _formFieldKey.currentState?.validate();
        }
      });
    }
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _internalController.dispose();
    }
    super.dispose();
  }

  String? _validateDate(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Let other validators handle empty validation
    }

    // Check if format matches DD/MM/YYYY
    final RegExp dateRegex = RegExp(r'^\d{2}/\d{2}/\d{4}$');
    if (!dateRegex.hasMatch(value)) {
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
    } catch (e) {
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
            widget.onChanged?.call(value);
            if (widget.formSubmitted || (_errorText != null && widget.validator != null)) {
              _formFieldKey.currentState?.validate();
            }
          },
          validator: (value) {
            String? error;
            
            // First run custom date validation
            final dateError = _validateDate(value);
            if (dateError != null) {
              error = dateError;
            } else {
              // Then run user-provided validator
              error = widget.validator?.call(value);
            }

            WidgetsBinding.instance.addPostFrameCallback((_) {
              if (mounted && _errorText != error) {
                setState(() {
                  _errorText = error;
                });
              }
            });
            return null;
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
              borderSide: BorderSide(
                color: _errorText != null ? errorBorderColor : borderColor,
                width: 1.5
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: _errorText != null ? errorBorderColor : borderColor,
                width: 1.5
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: _errorText != null ? errorBorderColor : borderColor,
                width: 2.0
              ),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: errorBorderColor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: errorBorderColor, width: 2.0),
            ),
            errorStyle: const TextStyle(height: 0, fontSize: 0),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              _errorText!,
              style: const TextStyle(color: errorBorderColor, fontSize: 12.0),
            ),
          ),      ],
    );
  }
}