import 'package:flutter/services.dart';

class DateInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
    TextEditingValue oldValue,
    TextEditingValue newValue,
  ) {
    final text = newValue.text;
    
    // Remove any non-digits
    final digitsOnly = text.replaceAll(RegExp(r'[^0-9]'), '');
    
    // Limit to 8 digits (DDMMYYYY)
    final limitedDigits = digitsOnly.length > 8 ? digitsOnly.substring(0, 8) : digitsOnly;
      // Format with slashes - add slash immediately after 2nd and 4th digits
    String formattedText = '';
    for (int i = 0; i < limitedDigits.length; i++) {
      formattedText += limitedDigits[i];
      if (i == 1 || i == 3) {
        formattedText += '/';
      }
    }
    
    // Calculate cursor position
    int cursorPosition = formattedText.length;
    
    // Adjust cursor position if user is typing in the middle
    if (newValue.selection.baseOffset < oldValue.text.length) {
      // User is editing in the middle, try to maintain relative position
      final oldCursorPos = newValue.selection.baseOffset;
      final oldDigitsBeforeCursor = oldValue.text.substring(0, oldCursorPos).replaceAll(RegExp(r'[^0-9]'), '').length;
      
      int newCursorPos = 0;
      int digitCount = 0;
      for (int i = 0; i < formattedText.length; i++) {
        if (formattedText[i] != '/') {
          digitCount++;
        }
        if (digitCount >= oldDigitsBeforeCursor + (digitsOnly.length > oldValue.text.replaceAll(RegExp(r'[^0-9]'), '').length ? 1 : 0)) {
          newCursorPos = i + 1;
          break;
        }
      }
      cursorPosition = newCursorPos.clamp(0, formattedText.length);
    }
    
    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: cursorPosition),
    );
  }
}