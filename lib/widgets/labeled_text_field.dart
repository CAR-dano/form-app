import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/formatters/thousands_separator_input_formatter.dart';

class LabeledTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final int? maxLines;
  final FocusNode? focusNode;
  final bool formSubmitted;
  final String? initialValue;
  final bool useThousandsSeparator;
  final String? prefixText;
  final String? suffixText;

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.maxLines = 1,
    this.focusNode,
    this.formSubmitted = false,
    this.initialValue,
    this.useThousandsSeparator = true,
    this.prefixText,
    this.suffixText,
  });

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  final _formFieldKey = GlobalKey<FormFieldState<String>>(); // Changed to FormFieldState<String>
  late TextEditingController _internalController;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(LabeledTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && widget.initialValue != oldWidget.initialValue) {
      if (_internalController.text != widget.initialValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            // Check if the field has focus. Only update if it doesn't or if text differs.
            final bool hasFocus = widget.focusNode?.hasFocus ?? _formFieldKey.currentContext?.owner?.focusManager.primaryFocus?.context == _formFieldKey.currentContext;

            if (!hasFocus || _internalController.text != widget.initialValue) {
                final currentSelection = _internalController.selection;
                _internalController.text = widget.initialValue ?? '';
                // Restore selection if valid
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
     // If formSubmitted state changes to true, re-validate
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
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          onChanged: (value) {
            widget.onChanged?.call(value);
            // Validate on change if form has already been marked as submitted for this field
            if (widget.formSubmitted) { // Only validate if form has been submitted
               _formFieldKey.currentState?.validate();
            }
          },
          validator: (value) {
            // Directly return the error from the provided validator
            return widget.validator?.call(value);
          },
          maxLines: widget.maxLines,
          style: inputTextStyling,
          focusNode: widget.focusNode,
          textCapitalization: TextCapitalization.sentences,
          inputFormatters: widget.keyboardType == TextInputType.number && widget.useThousandsSeparator
              ? [ThousandsSeparatorInputFormatter()]
              : null,
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: hintTextStyling,
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            isDense: true,
            alignLabelWithHint: true,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: _formFieldKey.currentState?.hasError == true ? errorBorderColor : borderColor, // Use FormFieldState for border color
                width: 1.5
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: _formFieldKey.currentState?.hasError == true ? errorBorderColor : borderColor, // Use FormFieldState for border color
                width: 1.5
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: BorderSide(
                color: _formFieldKey.currentState?.hasError == true ? errorBorderColor : borderColor, // Use FormFieldState for border color
                width: 2.0
              ),
            ),
            errorBorder: OutlineInputBorder( // This will be used if validator returns non-null
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: errorBorderColor, width: 1.5),
            ),
            focusedErrorBorder: OutlineInputBorder( // This will be used if validator returns non-null
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: errorBorderColor, width: 2.0),
            ),
            // Hide default error text area
            errorStyle: const TextStyle(height: 0, fontSize: 0),
            prefix: widget.prefixText != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text(
                      widget.prefixText!,
                      style: hintTextStyle,
                    ),
                  )
                : null,
            suffix: widget.suffixText != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      widget.suffixText!,
                      style: hintTextStyle,
                    ),
                  )
                : null,
          ),
        ),
        // Custom error text display, similar to LabeledDateField
        if (_formFieldKey.currentState?.hasError == true && _formFieldKey.currentState?.errorText != null)
          Padding(
            padding: const EdgeInsets.only(top: 4.0, left: 12.0),
            child: Text(
              _formFieldKey.currentState!.errorText!,
              style: const TextStyle(color: errorBorderColor, fontSize: 12.0),
            ),
          ),
      ],
    );
  }
}
