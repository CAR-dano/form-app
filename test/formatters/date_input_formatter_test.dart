import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/formatters/date_input_formatter.dart';

void main() {
  group('DateInputFormatter', () {
    late DateInputFormatter formatter;

    setUp(() {
      formatter = DateInputFormatter();
    });

    /// Helper function to create TextEditingValue
    TextEditingValue createValue(String text, [int? selectionOffset]) {
      return TextEditingValue(
        text: text,
        selection: TextSelection.collapsed(
          offset: selectionOffset ?? text.length,
        ),
      );
    }

    group('Basic Formatting', () {
      test('formats "01" as "01"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01'));
      });

      test('formats "0101" as "01/01"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('0101');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01'));
      });

      test('formats "01012024" as "01/01/2024"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01012024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01/2024'));
      });

      test('formats "15122023" as "15/12/2023"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('15122023');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('15/12/2023'));
      });

      test('formats "31121999" as "31/12/1999"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('31121999');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('31/12/1999'));
      });
    });

    group('Progressive Typing', () {
      test('adding first slash after 2 digits', () {
        // Arrange: User types "01" then "0"
        final oldValue = createValue('01');
        final newValue = createValue('010');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should add slash after day
        expect(result.text, equals('01/0'));
      });

      test('adding second slash after 4 digits', () {
        // Arrange: User types "0101" then "2"
        final oldValue = createValue('01/01');
        final newValue = createValue('01/012');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should add slash after month
        expect(result.text, equals('01/01/2'));
      });

      test('stops accepting input after 8 digits', () {
        // Arrange: User has full date and tries to add more
        final oldValue = createValue('01/01/2024');
        final newValue = createValue('01/01/20249'); // Extra digit

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should truncate to 8 digits
        expect(result.text, equals('01/01/2024'));
      });

      test('typing sequence 1-2-0-3-2-0-2-4', () {
        var value = createValue('');
        final inputs = ['1', '12', '120', '1203', '12032', '120320', '1203202', '12032024'];
        final expected = ['1', '12', '12/0', '12/03', '12/03/2', '12/03/20', '12/03/202', '12/03/2024'];

        for (var i = 0; i < inputs.length; i++) {
          final newValue = createValue(inputs[i]);
          value = formatter.formatEditUpdate(value, newValue);
          expect(value.text, equals(expected[i]), reason: 'Failed at step $i with input: ${inputs[i]}');
        }
      });
    });

    group('Digit Extraction', () {
      test('strips non-numeric characters', () {
        // Arrange: User pastes "01/01/2024" with slashes
        final oldValue = createValue('');
        final newValue = createValue('01/01/2024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should extract digits and reformat
        expect(result.text, equals('01/01/2024'));
      });

      test('ignores extra slashes in pasted text', () {
        // Arrange: User pastes malformed date with extra slashes
        final oldValue = createValue('');
        final newValue = createValue('01//01//2024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should extract digits and format correctly
        expect(result.text, equals('01/01/2024'));
      });

      test('strips letters from input', () {
        // Arrange: User accidentally types "01Jan2024"
        final oldValue = createValue('');
        final newValue = createValue('01Jan2024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should extract only digits (6 digits: 01, 20, 24)
        expect(result.text, equals('01/20/24'));
      });

      test('handles mixed alphanumeric input', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('15abc12xyz2023');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('15/12/2023'));
      });
    });

    group('Partial Dates', () {
      test('handles incomplete day (single digit)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('5');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('5'));
      });

      test('handles incomplete month', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('151');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('15/1'));
      });

      test('handles incomplete year (2 digits)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('151220');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('15/12/20'));
      });

      test('handles incomplete year (3 digits)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('1512202');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('15/12/202'));
      });
    });

    group('Cursor Positioning', () {
      test('cursor advances correctly as slashes are added', () {
        // Arrange: Typing third digit should add slash
        final oldValue = createValue('12', 2);
        final newValue = createValue('120', 3);

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('12/0'));
        // Cursor should be after the '0': position 4
        expect(result.selection.baseOffset, equals(4));
      });

      test('cursor is clamped to valid range', () {
        // Arrange: Edge case with cursor beyond text
        final oldValue = createValue('');
        final newValue = createValue('01012024', 100); // Invalid cursor position

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.selection.baseOffset, equals(result.text.length));
        expect(result.selection.baseOffset, lessThanOrEqualTo(result.text.length));
      });

      test('cursor at end after formatting', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01012024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.selection.baseOffset, equals(10)); // "01/01/2024".length
        expect(result.selection.isCollapsed, isTrue);
      });
    });

    group('Edge Cases', () {
      test('empty string returns empty', () {
        // Arrange
        final oldValue = createValue('01/01/2024');
        final newValue = createValue('');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals(''));
      });

      test('rejects all non-numeric input', () {
        // Arrange: Only letters
        final oldValue = createValue('');
        final newValue = createValue('abcdefgh');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: No digits extracted, returns empty
        expect(result.text, equals(''));
      });

      test('handles backspace across slashes', () {
        // Arrange: User has "01/01" and deletes
        final oldValue = createValue('01/01');
        final newValue = createValue('010'); // After backspace

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/0'));
      });

      test('handles paste of complete date "01/01/2024"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01/01/2024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01/2024'));
      });

      test('truncates input longer than 8 digits', () {
        // Arrange: 10 digits pasted
        final oldValue = createValue('');
        final newValue = createValue('0101202412'); // 10 digits

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should truncate to 8 digits
        expect(result.text, equals('01/01/2024'));
      });

      test('handles single digit input', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('1');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('1'));
      });

      test('handles two digit input (no slash yet)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('12');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('12'));
      });
    });

    group('Invalid Dates - Formatting Only', () {
      test('formats "99/99/9999" (no validation, just formatting)', () {
        // Arrange: Invalid date but valid format
        final oldValue = createValue('');
        final newValue = createValue('99999999');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Formatter doesn't validate, just formats
        expect(result.text, equals('99/99/9999'));
      });

      test('formats "00/00/0000"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('00000000');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('00/00/0000'));
      });

      test('formats "32/13/2024" (invalid day/month)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('32132024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: No validation, just formatting
        expect(result.text, equals('32/13/2024'));
      });
    });

    group('Real-World Scenarios', () {
      test('typical inspection date entry (15/06/2024)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('15062024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('15/06/2024'));
      });

      test('user enters pajak 1 tahun date', () {
        // Arrange: Common date format in Indonesia
        final oldValue = createValue('');
        final newValue = createValue('31122024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('31/12/2024'));
      });

      test('user enters pajak 5 tahun date', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01012025');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01/2025'));
      });

      test('user corrects typo by deleting and retyping', () {
        // Step 1: User has "15/06/2024" and wants "15/07/2024"
        var value = createValue('15/06/2024');
        
        // Step 2: Delete last 4 digits (year)
        value = formatter.formatEditUpdate(value, createValue('1506'));
        expect(value.text, equals('15/06'));

        // Step 3: Delete month
        value = formatter.formatEditUpdate(value, createValue('15'));
        expect(value.text, equals('15'));

        // Step 4: Type correct month and year
        value = formatter.formatEditUpdate(value, createValue('15072024'));
        expect(value.text, equals('15/07/2024'));
      });

      test('user pastes date from clipboard with various formats', () {
        // Test different paste formats
        final formats = [
          '01/01/2024',
          '01-01-2024',
          '01.01.2024',
          '01 01 2024',
        ];

        for (final format in formats) {
          final oldValue = createValue('');
          final newValue = createValue(format);
          final result = formatter.formatEditUpdate(oldValue, newValue);
          expect(result.text, equals('01/01/2024'), reason: 'Failed for format: $format');
        }
      });

      test('handles birth year (1990s)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('15081995');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('15/08/1995'));
      });

      test('handles future date (2030)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01012030');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01/2030'));
      });
    });

    group('Deletion Behavior', () {
      test('deleting from full date "01/01/2024" to "01/01/202"', () {
        // Arrange
        final oldValue = createValue('01/01/2024');
        final newValue = createValue('0101202'); // Deleted last digit

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01/202'));
      });

      test('deleting from "01/01" to "01/0"', () {
        // Arrange
        final oldValue = createValue('01/01');
        final newValue = createValue('010'); // Deleted last digit

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/0'));
      });

      test('deleting from "01/0" to "01"', () {
        // Arrange
        final oldValue = createValue('01/0');
        final newValue = createValue('01'); // Deleted month digit

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01'));
      });

      test('deleting all digits returns empty', () {
        // Arrange
        final oldValue = createValue('01/01/2024');
        final newValue = createValue('');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals(''));
      });
    });

    group('Special Characters Handling', () {
      test('handles date with dashes "01-01-2024"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01-01-2024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01/2024'));
      });

      test('handles date with dots "01.01.2024"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01.01.2024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01/2024'));
      });

      test('handles date with spaces "01 01 2024"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01 01 2024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01/2024'));
      });

      test('strips special characters and formats', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('01@01#2024');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('01/01/2024'));
      });
    });

    group('State Transitions', () {
      test('empty -> 1 digit', () {
        final result = formatter.formatEditUpdate(
          createValue(''),
          createValue('1'),
        );
        expect(result.text, equals('1'));
      });

      test('1 digit -> 2 digits (no slash)', () {
        final result = formatter.formatEditUpdate(
          createValue('1'),
          createValue('15'),
        );
        expect(result.text, equals('15'));
      });

      test('2 digits -> 3 digits (adds slash)', () {
        final result = formatter.formatEditUpdate(
          createValue('15'),
          createValue('150'),
        );
        expect(result.text, equals('15/0'));
      });

      test('4 digits -> 5 digits (adds second slash)', () {
        final result = formatter.formatEditUpdate(
          createValue('15/06'),
          createValue('15062'),
        );
        expect(result.text, equals('15/06/2'));
      });

      test('7 digits -> 8 digits (complete date)', () {
        final result = formatter.formatEditUpdate(
          createValue('15/06/202'),
          createValue('15062024'),
        );
        expect(result.text, equals('15/06/2024'));
      });
    });
  });
}
