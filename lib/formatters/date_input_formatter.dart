import 'package:flutter/services.dart';

/// Formats text for a date input in `DD/MM/YYYY` format.
class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    // Determine if the user is adding or removing text.
    final bool isAdding = newValue.text.length > oldValue.text.length;

    // 1. Extract and limit the number of digits.
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    if (digitsOnly.length > 8) {
      digitsOnly = digitsOnly.substring(0, 8);
    }

    // 2. Build the formatted string with slashes.
    final buffer = StringBuffer();
    for (int i = 0; i < digitsOnly.length; i++) {
      buffer.write(digitsOnly[i]);
      // Add a slash after the day (i=1) and month (i=3).
      // The condition `isAdding || digitsOnly.length > i + 1` ensures a slash
      // is added immediately when the 2nd or 4th digit is typed, but not
      // when a user is deleting a slash.
      if ((i == 1 && (isAdding || digitsOnly.length > 2)) ||
          (i == 3 && (isAdding || digitsOnly.length > 4))) {
        buffer.write('/');
      }
    }

    final String formattedText = buffer.toString();

    // 3. Calculate the new cursor position.
    // This simple calculation adjusts the cursor's position based on the
    // difference in length between the raw input and the final formatted text.
    final int selectionIndex =
        newValue.selection.end + (formattedText.length - newValue.text.length);

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        // Ensure the cursor position is within the valid range of the text.
        offset: selectionIndex.clamp(0, formattedText.length),
      ),
    );
  }
}