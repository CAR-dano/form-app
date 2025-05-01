import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for input formatters
import 'package:form_app/statics/app_styles.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller; // Allow passing a controller
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged; // Callback for changes
  final FormFieldValidator<String>? validator; // For form validation
  final int? maxLines;
  final FocusNode? focusNode; // Optional focus node

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
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 8.0), // Consistent spacing
        TextFormField( // Use TextFormField for validation integration
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          maxLines: maxLines,
          style: inputTextStyling,
          focusNode: focusNode, // Pass the focus node to TextFormField
          inputFormatters: keyboardType == TextInputType.number
              ? [_ThousandsSeparatorInputFormatter()] // Apply formatter for numbers
              : null, // No formatter for other types
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintTextStyling,
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
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
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
             focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
        ),
        // No SizedBox needed here usually, as the next LabeledTextField
        // will have its own top label and spacing.
        // Add if separating from non-LabeledTextField widgets
      ],
    );
  }
}

// Custom TextInputFormatter for thousands separation
class _ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Allow empty string or just a dot
    if (newValue.text.isEmpty || newValue.text == '.') {
      return newValue;
    }

    // Remove existing dots for parsing
    String cleanedText = newValue.text.replaceAll('.', '');

    // Parse as integer (or double if needed)
    int? value = int.tryParse(cleanedText);

    if (value == null) {
      // If parsing fails, return the old value to prevent invalid input
      return oldValue;
    }

    // Format the number with thousands separators
    String formattedText = value.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
      (Match m) => '${m[1]}.',
    );

    // Calculate the new cursor position
    TextSelection newSelection = newValue.selection.copyWith(
      baseOffset: formattedText.length,
      extentOffset: formattedText.length,
    );

    return TextEditingValue(
      text: formattedText,
      selection: newSelection,
    );
  }
}
