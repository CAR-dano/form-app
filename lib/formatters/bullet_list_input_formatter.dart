import 'package:flutter/services.dart';

// Formats text input for bulleted lists, handling newlines and backspaces on bullets.
class BulletListInputFormatter extends TextInputFormatter {
  // Called when text is edited; processes changes for bullet list behavior.
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    
    // --- Handles adding a bullet point ('• ') after a newline character is inserted. ---
    // Check if a newline character is being inserted
    if (newValue.text.length == oldValue.text.length - (oldValue.selection.end - oldValue.selection.start) + 1 &&
        newValue.selection.isCollapsed &&
        newValue.selection.baseOffset == oldValue.selection.start + 1 &&
        oldValue.selection.start < newValue.text.length &&
        newValue.text[oldValue.selection.start] == '\n') {

      final int newlinePosition = oldValue.selection.start;
      final String textBeforeNewline = oldValue.text.substring(0, newlinePosition);

      // Check if the line before the newline is empty (only contains bullet and optional space)
      if (textBeforeNewline.trim() == '•' || textBeforeNewline.trim().isEmpty) {
         // If the line is empty, prevent the newline and return the old value
         return oldValue;
      }

      const String bulletAndSpace = '• ';
      // Inserts '• ' after the newline.
      final String textWithBullet =
          newValue.text.substring(0, newlinePosition + 1) +
          bulletAndSpace +
          newValue.text.substring(newlinePosition + 1);
      // Returns modified text with cursor after the bullet.
      return TextEditingValue(
        text: textWithBullet,
        selection: TextSelection.collapsed(offset: newlinePosition + 1 + bulletAndSpace.length),
      );
    }

    // --- Handles backspace on an empty bullet line or immediately after a bullet. ---
    if (newValue.text.length < oldValue.text.length && 
        oldValue.selection.isCollapsed && 
        newValue.selection.isCollapsed &&
        oldValue.selection.baseOffset == newValue.selection.baseOffset + (oldValue.text.length - newValue.text.length)
       ) {
      
      final int cursorPos = newValue.selection.baseOffset;

      // Detects if backspace resulted in '•' (from '• ') or '\n•' (from '\n• ').
      if ( (cursorPos > 0 && newValue.text[cursorPos -1] == '•') && 
           (oldValue.text.length > cursorPos && oldValue.text[cursorPos] == ' ') 
         ) {
        // Completely removes the bullet if it was an empty line.
        if (cursorPos == 1 && newValue.text == '•') { // Case: "•" at start.
          return TextEditingValue.empty; 
        } else if (cursorPos > 1 && newValue.text.substring(cursorPos - 2, cursorPos) == '\n•') { // Case: "...\n•".
          final newTextVal = newValue.text.substring(0, cursorPos - 2);
          return TextEditingValue(
            text: newTextVal,
            selection: TextSelection.collapsed(offset: newTextVal.length),
          );
        }
      }
      // Handles direct deletion of "• " or "\n• " by a single backspace.
      if (oldValue.selection.baseOffset == oldValue.text.length) { 
          if (oldValue.text.endsWith('\n• ') && newValue.text == oldValue.text.substring(0, oldValue.text.length - 3)) {
              return newValue; 
          } else if (oldValue.text == ('• ') && newValue.text.isEmpty) {
              return newValue; 
          }
      }
    }
    // Returns the input unchanged if no bullet formatting rules apply.
    return newValue;
  }
}
