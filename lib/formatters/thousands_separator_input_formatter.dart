import 'package:flutter/services.dart';

// Custom TextInputFormatter for thousands separation
class ThousandsSeparatorInputFormatter extends TextInputFormatter {
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
