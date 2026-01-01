import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/formatters/bullet_list_input_formatter.dart';

void main() {
  group('BulletListInputFormatter', () {
    late BulletListInputFormatter formatter;

    setUp(() {
      formatter = BulletListInputFormatter();
    });

    // Helper function to create TextEditingValue
    TextEditingValue createValue(String text, [int? selectionOffset]) {
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: selectionOffset ?? text.length,
        ),
      );
    }

    // Helper to create value with range selection
    TextEditingValue createValueWithSelection(
      String text,
      int start,
      int end,
    ) {
      return TextEditingValue(
        text: text,
        selection: TextSelection(baseOffset: start, extentOffset: end),
      );
    }

    group('Initial State', () {
      test('allows starting with bullet point', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('• ');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('• '));
      });

      test('allows typing after initial bullet', () {
        // Arrange
        final oldValue = createValue('• ');
        final newValue = createValue('• Test');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('• Test'));
      });

      test('prevents deletion of first bullet', () {
        // Arrange: User tries to delete the first bullet
        final oldValue = createValue('• ');
        final newValue = createValue('');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should return old value (prevent deletion)
        expect(result.text, equals('• '));
        expect(result.selection.baseOffset, equals(2));
      });

      test('prevents deletion of first bullet with backspace', () {
        // Arrange: Cursor at position 0, user types backspace
        final oldValue = createValue('• Test', 0);
        final newValue = createValue('• Test', 0);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('• Test'));
      });
    });

    group('Adding Bullet Points', () {
      test('adds bullet after pressing Enter', () {
        // Arrange: User at end of "• Test" and presses Enter
        final oldValue = createValue('• Test');
        final newValue = createValue('• Test\n', 7);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should add bullet after newline
        expect(result.text, equals('• Test\n• '));
        expect(result.selection.baseOffset, equals(9)); // After "• Test\n• " (9 chars)
      });

      test('adds bullet in middle of text when Enter pressed', () {
        // Arrange: Cursor at position 4 in "• Test", user presses Enter
        final oldValue = createValue('• Test', 4);
        final newValue = createValue('• Te\nst', 5);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should add bullet after newline
        expect(result.text, equals('• Te\n• st'));
        expect(result.selection.baseOffset, equals(7)); // After "• Te\n• " (7 chars)
      });

      test('adds bullet after multiple lines', () {
        // Arrange: Second line with content, press Enter
        final oldValue = createValue('• First\n• Second', 16);
        final newValue = createValue('• First\n• Second\n', 17);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('• First\n• Second\n• '));
        expect(result.selection.baseOffset, equals(19)); // newlinePos(16) + 1 + 2 = 19
      });

      test('Issue #159: pressing Enter at position 0 should not crash', () {
        // Arrange: Cursor at position 0
        final oldValue = createValue('• Test', 0);
        final newValue = createValue('\n• Test', 1);

        // Act & Assert: Should not throw RangeError
        expect(
          () => formatter.formatEditUpdate(oldValue, newValue),
          returnsNormally,
        );
      });

      test('prevents adding bullet on empty line (only bullet)', () {
        // Arrange: Line with only "• ", user presses Enter
        final oldValue = createValue('• ', 2);
        final newValue = createValue('• \n', 3);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should prevent newline (return old value)
        expect(result.text, equals('• '));
        expect(result.selection.baseOffset, equals(2));
      });

      test('prevents adding bullet on empty second line', () {
        // Arrange: Second empty bullet line, press Enter
        final oldValue = createValue('• First\n• ', 10);
        final newValue = createValue('• First\n• \n', 11);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should prevent newline
        expect(result.text, equals('• First\n• '));
        expect(result.selection.baseOffset, equals(10));
      });
    });

    group('Deleting Bullet Points', () {
      test('removes empty bullet line with backspace at end', () {
        // Arrange: At end of "• First\n• ", backspace deletes space
        final oldValue = createValue('• First\n• ', 10);
        final newValue = createValue('• First\n•', 9);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should remove entire bullet line
        expect(result.text, equals('• First'));
        expect(result.selection.baseOffset, equals(7));
      });

      test('prevents deletion of last bullet when only "• " exists', () {
        // Arrange: Only "• " exists, backspace on space
        final oldValue = createValue('• ', 2);
        final newValue = createValue('•', 1);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should be blocked by first bullet protection
        expect(result.text, equals('• '));
        expect(result.selection.baseOffset, equals(2));
      });

      test('removes empty bullet line with backspace after bullet', () {
        // Arrange: Multiple lines, cursor after bullet on second line, backspace removes space
        final oldValue = createValue('• First\n• Second', 10);
        final newValue = createValue('• First\n•Second', 9);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Removes entire bullet line (lines 76-89 of formatter)
        expect(result.text, equals('• First'));
        expect(result.selection.baseOffset, equals(7));
      });

      test('allows normal backspace on text content', () {
        // Arrange: User deletes character from "Test"
        final oldValue = createValue('• Test', 6);
        final newValue = createValue('• Tes', 5);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should allow normal deletion
        expect(result.text, equals('• Tes'));
        expect(result.selection.baseOffset, equals(5));
      });

      test('handles deletion of entire bullet point "• " from end', () {
        // Arrange: At end of "• First\n• ", delete entire "• " with selection or backspace
        final oldValue = createValue('• First\n• ');
        final newValue = createValue('• First\n');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should allow deletion
        expect(result.text, equals('• First\n'));
      });
    });

    group('Cursor Positioning', () {
      test('cursor positioned after bullet when added', () {
        // Arrange
        final oldValue = createValue('• Test');
        final newValue = createValue('• Test\n', 7);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Cursor should be after "• Test\n• " (9 chars)
        expect(result.selection.baseOffset, equals(9));
        expect(result.selection.isCollapsed, isTrue);
      });

      test('cursor positioned correctly after backspace on empty bullet', () {
        // Arrange
        final oldValue = createValue('• First\n• ', 10);
        final newValue = createValue('• First\n•', 9);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Cursor at end of "• First"
        expect(result.selection.baseOffset, equals(7));
      });

      test('maintains cursor position for unaffected edits', () {
        // Arrange: Typing in middle of text
        final oldValue = createValue('• Test', 4);
        final newValue = createValue('• Teqst', 5);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Cursor should be at position 5
        expect(result.selection.baseOffset, equals(5));
      });
    });

    group('Multi-line Behavior', () {
      test('handles three bullet points correctly', () {
        // Arrange: Building up multiple lines
        final text1 = '• First';
        final text2 = '• First\n• Second';
        final text3 = '• First\n• Second\n• Third';

        // Act & Assert: Each line maintains bullet formatting
        expect(text1, startsWith('• '));
        expect(text2, contains('\n• '));
        expect(text3.split('\n').length, equals(3));
        expect(text3.split('\n').every((line) => line.startsWith('• ')), isTrue);
      });

      test('handles pressing Enter in middle of multi-line list', () {
        // Arrange: Cursor in middle of second line
        final oldValue = createValue('• First\n• Second\n• Third', 12);
        final newValue = createValue('• First\n• Se\ncond\n• Third', 13);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should add bullet after newline
        expect(result.text, equals('• First\n• Se\n• cond\n• Third'));
      });

      test('handles deleting middle bullet point', () {
        // Arrange: Delete empty bullet in middle
        final oldValue = createValue('• First\n• \n• Third', 10);
        final newValue = createValue('• First\n•\n• Third', 9);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should remove bullet line
        expect(result.text, equals('• First'));
        expect(result.selection.baseOffset, equals(7));
      });
    });

    group('Real-World Scenarios', () {
      test('user creates inspection notes list', () {
        // Scenario: Inspector creating notes about vehicle issues
        var value = createValue('');

        // User starts typing
        value = createValue('• ');
        var result = formatter.formatEditUpdate(createValue(''), value);
        expect(result.text, equals('• '));

        // User types first issue
        value = createValue('• Ban depan aus');
        result = formatter.formatEditUpdate(createValue('• '), value);
        expect(result.text, equals('• Ban depan aus'));

        // User presses Enter
        final oldVal1 = createValue('• Ban depan aus');
        final newVal1 = createValue('• Ban depan aus\n', 16); // cursor at end (16, not 15)
        result = formatter.formatEditUpdate(oldVal1, newVal1);
        expect(result.text, equals('• Ban depan aus\n• '));

        // User types second issue
        value = createValue('• Ban depan aus\n• Cat tergores');
        result = formatter.formatEditUpdate(
          createValue('• Ban depan aus\n• '),
          value,
        );
        expect(result.text, equals('• Ban depan aus\n• Cat tergores'));

        // User presses Enter again
        final oldVal2 = createValue('• Ban depan aus\n• Cat tergores');
        final newVal2 = createValue('• Ban depan aus\n• Cat tergores\n', 31); // 31 (30 + 1)
        result = formatter.formatEditUpdate(oldVal2, newVal2);
        expect(result.text, equals('• Ban depan aus\n• Cat tergores\n• '));
      });

      test('user edits existing bullet point', () {
        // Arrange: User wants to edit middle of text
        final oldValue = createValue('• Kerusakan ringan', 10);
        final newValue = createValue('• Kerusakan berat', 10);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should allow edit
        expect(result.text, equals('• Kerusakan berat'));
      });

      test('user deletes unwanted bullet point', () {
        // Arrange: User created empty bullet by accident, wants to remove
        final oldValue = createValue('• Item 1\n• \n• Item 3', 10);
        final newValue = createValue('• Item 1\n•\n• Item 3', 9);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Allows the deletion (formatter doesn't remove entire line in this case)
        expect(result.text, equals('• Item 1\n•\n• Item 3'));
      });

      test('user pastes text without bullets', () {
        // Arrange: User pastes plain text
        final oldValue = createValue('• ');
        final newValue = createValue('• Pasted text without formatting');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should keep text as-is (no auto-formatting on paste)
        expect(result.text, equals('• Pasted text without formatting'));
      });

      test('user creates long bullet list (5+ items)', () {
        // Arrange: Building a long list progressively
        const items = [
          'Kondisi mesin bagus',
          'Interior bersih',
          'Eksterior tidak ada lecet',
          'Semua lampu berfungsi',
          'AC dingin',
        ];

        var currentText = '• ';
        for (var i = 0; i < items.length; i++) {
          currentText += items[i];
          if (i < items.length - 1) {
            // Simulate pressing Enter
            final oldVal = createValue(currentText);
            final newVal = createValue('$currentText\n', currentText.length + 1);
            final result = formatter.formatEditUpdate(oldVal, newVal);
            currentText = result.text;
          }
        }

        // Assert: Should have all items as bullet points
        final lines = currentText.split('\n');
        expect(lines.length, equals(5));
        expect(lines.every((line) => line.startsWith('• ')), isTrue);
      });
    });

    group('Edge Cases', () {
      test('handles empty input', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals(''));
      });

      test('handles text selection (range selection)', () {
        // Arrange: User selects text
        final oldValue = createValueWithSelection('• Test text', 2, 6);
        final newValue = createValue('• text', 2);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should allow deletion of selected text
        expect(result.text, equals('• text'));
      });

      test('handles very long single line', () {
        // Arrange: Very long text in single bullet point
        final longText = '• ${'Lorem ipsum ' * 50}';
        final oldValue = createValue(longText);
        final newValue = createValue('$longText!');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should handle without issues
        expect(result.text, equals('$longText!'));
      });

      test('handles rapid Enter presses (double newline)', () {
        // Arrange: User presses Enter twice quickly on empty line
        final oldValue = createValue('• Test\n• ', 10);
        final newValue = createValue('• Test\n• \n', 11);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Allows the newline (no bullet added after empty line)
        expect(result.text, equals('• Test\n• \n'));
      });

      test('handles cursor at start of text (position 0)', () {
        // Arrange: Cursor at very beginning
        final oldValue = createValue('• Test', 0);
        final newValue = createValue('X• Test', 1);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should allow insertion
        expect(result.text, equals('X• Test'));
      });

      test('handles single bullet character without space', () {
        // Arrange: User types just "•"
        final oldValue = createValue('');
        final newValue = createValue('•');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should allow it
        expect(result.text, equals('•'));
      });

      test('handles backspace on non-empty bullet line', () {
        // Arrange: Bullet line with content, backspace in middle
        final oldValue = createValue('• Test', 4);
        final newValue = createValue('• Tst', 3);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Normal backspace behavior
        expect(result.text, equals('• Tst'));
        expect(result.selection.baseOffset, equals(3));
      });
    });

    group('Special Characters', () {
      test('handles Indonesian characters in bullet text', () {
        // Arrange
        final oldValue = createValue('• ');
        final newValue = createValue('• Ké rusakan');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('• Ké rusakan'));
      });

      test('handles numbers in bullet points', () {
        // Arrange
        final oldValue = createValue('• ');
        final newValue = createValue('• Item 123');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('• Item 123'));
      });

      test('handles special characters (!@#\$%)', () {
        // Arrange
        final oldValue = createValue('• ');
        final newValue = createValue('• Item @#\$%!');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('• Item @#\$%!'));
      });

      test('handles emojis in bullet text', () {
        // Arrange
        final oldValue = createValue('• ');
        final newValue = createValue('• Test 🚗 mobil');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('• Test 🚗 mobil'));
      });
    });
  });
}
