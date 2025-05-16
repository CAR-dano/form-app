import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/formatters/thousands_separator_input_formatter.dart'; // Import thousands separator formatter

class LabeledTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller; // Allow passing a controller
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged; // Callback for changes
  final FormFieldValidator<String>? validator; // For form validation
  final int? maxLines;
  final FocusNode? focusNode; // Optional focus node
  final bool formSubmitted; // Add formSubmitted parameter
  final String? initialValue; // Add initialValue parameter
  final bool useThousandsSeparator; // Add parameter to control thousands separator
  final String? prefixText; // Add prefixText parameter
  final String? suffixText; // Add suffixText parameter

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text, // Default to text
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.maxLines = 1, // Default to single line
    this.focusNode, // Accept optional focus node
    this.formSubmitted = false, // Default to false
    this.initialValue, // Accept initialValue
    this.useThousandsSeparator = true, // Default to true
    this.prefixText, // Accept prefixText
    this.suffixText, // Accept suffixText
  });

  @override
  State<LabeledTextField> createState() => _LabeledTextFieldState();
}

class _LabeledTextFieldState extends State<LabeledTextField> {
  final _formFieldKey = GlobalKey<FormFieldState>(); // Key for managing form field state
  late TextEditingController _internalController; // Internal controller

  @override
  void initState() {
    super.initState();
    // Use the provided controller or create an internal one
    _internalController = widget.controller ?? TextEditingController(text: widget.initialValue);
  }

  @override
  void didUpdateWidget(LabeledTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller == null && widget.initialValue != oldWidget.initialValue) {
      if (_internalController.text != widget.initialValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) { // Ensure update after build
          if (mounted) {
            if (widget.focusNode?.hasFocus == false || _internalController.text != widget.initialValue) {
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
  }


  @override
  void dispose() {
    // Dispose the internal controller if it was created
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
        const SizedBox(height: 4.0), // Consistent spacing
        TextFormField( // Use TextFormField for validation integration
          key: _formFieldKey, // Assign the key
          controller: _internalController, // Use the internal controller
          keyboardType: widget.keyboardType,
          obscureText: widget.obscureText,
          onChanged: (value) {
            // Call the original onChanged callback
            widget.onChanged?.call(value);
            // Trigger validation if the form has been submitted
            if (widget.formSubmitted) {
              _formFieldKey.currentState?.validate();
            }
          },
          validator: widget.validator,
          maxLines: widget.maxLines,
          style: inputTextStyling,
          focusNode: widget.focusNode, // Pass the focus node to TextFormField
          textCapitalization: TextCapitalization.sentences, // Auto-capitalize the first letter
          inputFormatters: widget.keyboardType == TextInputType.number && widget.useThousandsSeparator
              ? [ThousandsSeparatorInputFormatter()] // Apply formatter for numbers if enabled
              : null, // No formatter for other types or if disabled
          decoration: InputDecoration(
            hintText: widget.hintText,
            hintStyle: hintTextStyling,
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0), // Keep original padding
            isDense: true, // Make the input decorator more compact
            alignLabelWithHint: true, // Align hint text with label
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
            // Add error border style if needed based on validation feedback
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: errorBorderColor, width: 1.5),
            ),
             focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: errorBorderColor, width: 2.0),
            ),
            prefix: widget.prefixText != null
                ? Padding(
                    padding: const EdgeInsets.only(right: 8.0), // Add padding after the prefix
                    child: Text(
                      widget.prefixText!,
                      style: hintTextStyle, // Use the same style as input text
                    ),
                  )
                : null,
            suffix: widget.suffixText != null
                ? Padding(
                    padding: const EdgeInsets.only(left: 8.0), // Add padding before the suffix
                    child: Text(
                      widget.suffixText!,
                      style: hintTextStyle, // Use the same style as hint text
                    ),
                  )
                : null,
          ),
        ),
        // No SizedBox needed here usually, as the next LabeledTextField
        // will have its own top label and spacing.
        // Add if separating from non-LabeledTextField widgets
      ],
    );
  }
}
