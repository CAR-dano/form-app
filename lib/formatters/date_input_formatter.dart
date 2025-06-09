import 'package:flutter/services.dart';

/// Formats text for a date input in `DD/MM/YYYY` format.
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // 1. Extract and limit the number of digits.
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
    }

    // 2. Build the formatted string deterministically.
    final int digitCount = digitsOnly.length;
    final buffer = StringBuffer();

    // Add DD
    if (digitCount > 0) {
      buffer.write(digitsOnly.substring(0, digitCount < 2 ? digitCount : 2));
    }
    // Add first slash
    if (digitCount > 2) {
      buffer.write('/');
    }
    // Add MM
    if (digitCount > 2) {
      buffer.write(digitsOnly.substring(2, digitCount < 4 ? digitCount : 4));
    }
    // Add second slash
    if (digitCount > 4) {
      buffer.write('/');
    }
    // Add YYYY
    if (digitCount > 4) {
      buffer.write(digitsOnly.substring(4, digitCount));
    }

    final String formattedText = buffer.toString();

    // 3. Calculate the new cursor position.
    final int selectionIndex =
        newValue.selection.end + (formattedText.length - newValue.text.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: selectionIndex.clamp(0, formattedText.length),
      ),
    );
  }
}