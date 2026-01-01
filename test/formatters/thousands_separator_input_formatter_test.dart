import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/formatters/thousands_separator_input_formatter.dart';

void main() {
  group('ThousandsSeparatorInputFormatter', () {
    late ThousandsSeparatorInputFormatter formatter;

    setUp(() {
      formatter = ThousandsSeparatorInputFormatter();
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
      test('formats 1000 as "1.000"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('1000');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('1.000'));
      });

      test('formats 1000000 as "1.000.000"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('1000000');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('1.000.000'));
      });

      test('formats 123 as "123" (no separator)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('123');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('123'));
      });

      test('formats 12345 as "12.345"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('12345');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('12.345'));
      });

      test('formats 123456789 as "123.456.789"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('123456789');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('123.456.789'));
      });
    });

    group('Empty and Edge Cases', () {
      test('allows empty string', () {
        // Arrange
        final oldValue = createValue('1.000');
        final newValue = createValue('');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals(''));
      });

      test('allows single dot', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('.');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('.'));
      });

      test('returns old value on invalid input (letters)', () {
        // Arrange
        final oldValue = createValue('1.000');
        final newValue = createValue('1000abc');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should reject and return old value
        expect(result.text, equals('1.000'));
        expect(result, equals(oldValue));
      });

      test('returns old value on special characters', () {
        // Arrange
        final oldValue = createValue('500');
        final newValue = createValue('500@#\$');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('500'));
        expect(result, equals(oldValue));
      });

      test('handles zero', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('0');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('0'));
      });

      test('handles leading zeros removed by parsing', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('00123');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Leading zeros are stripped by int.parse
        expect(result.text, equals('123'));
      });
    });

    group('Progressive Typing', () {
      test('typing "1" shows "1"', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('1');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('1'));
      });

      test('typing "12" shows "12"', () {
        // Arrange
        final oldValue = createValue('1');
        final newValue = createValue('12');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('12'));
      });

      test('typing "123" shows "123"', () {
        // Arrange
        final oldValue = createValue('12');
        final newValue = createValue('123');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('123'));
      });

      test('typing "1234" shows "1.234"', () {
        // Arrange
        final oldValue = createValue('123');
        final newValue = createValue('1234');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('1.234'));
      });

      test('typing "12345" shows "12.345"', () {
        // Arrange
        final oldValue = createValue('1.234');
        final newValue = createValue('12345');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('12.345'));
      });

      test('typing "1234567" progressively formats correctly', () {
        // Simulate typing each digit
        var oldValue = createValue('');
        
        final inputs = ['1', '12', '123', '1234', '12345', '123456', '1234567'];
        final expected = ['1', '12', '123', '1.234', '12.345', '123.456', '1.234.567'];

        for (var i = 0; i < inputs.length; i++) {
          final newValue = createValue(inputs[i]);
          final result = formatter.formatEditUpdate(oldValue, newValue);
          expect(result.text, equals(expected[i]), reason: 'Failed at input: ${inputs[i]}');
          oldValue = result;
        }
      });
    });

    group('Deletion', () {
      test('handles backspace from formatted number', () {
        // Arrange: User has "1.234" and deletes last digit
        final oldValue = createValue('1.234');
        final newValue = createValue('123'); // After removing dot and 4

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('123'));
      });

      test('handles deleting to empty', () {
        // Arrange
        final oldValue = createValue('5');
        final newValue = createValue('');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals(''));
      });

      test('removes separator when digits are deleted', () {
        // Arrange: "12.345" -> "12345" (user deletes dot)
        final oldValue = createValue('12.345');
        final newValue = createValue('12345');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should reformat to same "12.345"
        expect(result.text, equals('12.345'));
      });

      test('handles deletion from middle (dot is stripped)', () {
        // Arrange: "123.456" with dots removed becomes "123456"
        final oldValue = createValue('123.456');
        final newValue = createValue('12356'); // Deleted '4'

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('12.356'));
      });
    });

    group('Cursor Positioning', () {
      test('cursor moves to end after formatting', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('1234');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Cursor should be at end
        expect(result.selection.baseOffset, equals(result.text.length));
        expect(result.selection.baseOffset, equals(5)); // "1.234" length
      });

      test('cursor at end after adding separator', () {
        // Arrange
        final oldValue = createValue('999');
        final newValue = createValue('9999');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('9.999'));
        expect(result.selection.baseOffset, equals(5));
      });

      test('selection is collapsed (not a range)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('1000');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.selection.isCollapsed, isTrue);
        expect(result.selection.baseOffset, equals(result.selection.extentOffset));
      });
    });

    group('Invalid Input Rejection', () {
      test('rejects alphabetic characters', () {
        // Arrange
        final oldValue = createValue('123');
        final newValue = createValue('123abc');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('123'));
        expect(result, equals(oldValue));
      });

      test('rejects mixed numbers and letters', () {
        // Arrange
        final oldValue = createValue('50');
        final newValue = createValue('50a5');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('50'));
      });

      test('rejects special characters except dot', () {
        // Arrange
        final oldValue = createValue('100');
        final newValue = createValue('100!@#');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('100'));
      });

      test('handles paste of invalid text', () {
        // Arrange: User pastes "abc123def"
        final oldValue = createValue('');
        final newValue = createValue('abc123def');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Should return empty (old value)
        expect(result.text, equals(''));
        expect(result, equals(oldValue));
      });

      test('accepts paste of valid numbers', () {
        // Arrange: User pastes "1234567"
        final oldValue = createValue('');
        final newValue = createValue('1234567');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('1.234.567'));
      });
    });

    group('Large Numbers', () {
      test('formats very large numbers correctly', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('1234567890');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('1.234.567.890'));
      });

      test('handles maximum realistic car price (billions)', () {
        // Arrange: 5 billion rupiah
        final oldValue = createValue('');
        final newValue = createValue('5000000000');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('5.000.000.000'));
      });

      test('formats 999999999 correctly', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('999999999');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('999.999.999'));
      });
    });

    group('Real-World Scenarios', () {
      test('handles typical car price input (500 million rupiah)', () {
        // Arrange: User types 500000000
        final oldValue = createValue('');
        final newValue = createValue('500000000');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('500.000.000'));
      });

      test('handles odometer reading (100k km)', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('100000');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('100.000'));
      });

      test('handles tax cost input', () {
        // Arrange: 2.5 million rupiah (input as 2500000)
        final oldValue = createValue('');
        final newValue = createValue('2500000');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('2.500.000'));
      });

      test('user corrects typo by deleting and retyping', () {
        // Arrange: User has "12.345" and wants "12.346"
        // Step 1: Delete last digit
        final step1Old = createValue('12.345');
        final step1New = createValue('1234'); // Dots removed by user/system
        
        final step1Result = formatter.formatEditUpdate(step1Old, step1New);
        expect(step1Result.text, equals('1.234'));

        // Step 2: Add '6'
        final step2Old = step1Result;
        final step2New = createValue('12346');
        
        final step2Result = formatter.formatEditUpdate(step2Old, step2New);
        expect(step2Result.text, equals('12.346'));
      });
    });

    group('Dot Handling', () {
      test('user can input single dot', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('.');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert
        expect(result.text, equals('.'));
      });

      test('existing dots are stripped before formatting', () {
        // Arrange: User somehow has dots in input
        final oldValue = createValue('');
        final newValue = createValue('1.2.3.4');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Dots stripped, becomes "1234", then formatted to "1.234"
        expect(result.text, equals('1.234'));
      });

      test('multiple dots are handled', () {
        // Arrange
        final oldValue = createValue('');
        final newValue = createValue('.....');

        // Act
        final result = formatter.formatEditUpdate(oldValue, newValue);

        // Assert: Dots stripped becomes empty, parsing fails, returns oldValue
        expect(result.text, equals(''));
        expect(result, equals(oldValue));
      });
    });

    group('State Transitions', () {
      test('empty -> single digit', () {
        final old = createValue('');
        final new$ = createValue('5');
        final result = formatter.formatEditUpdate(old, new$);
        expect(result.text, equals('5'));
      });

      test('three digits -> four digits (adds separator)', () {
        final old = createValue('999');
        final new$ = createValue('9999');
        final result = formatter.formatEditUpdate(old, new$);
        expect(result.text, equals('9.999'));
      });

      test('four digits -> three digits (removes separator)', () {
        final old = createValue('9.999');
        final new$ = createValue('999');
        final result = formatter.formatEditUpdate(old, new$);
        expect(result.text, equals('999'));
      });

      test('preserves formatting across edits', () {
        var value = createValue('');
        
        // Type 1
        value = formatter.formatEditUpdate(value, createValue('1'));
        expect(value.text, equals('1'));
        
        // Type 2
        value = formatter.formatEditUpdate(value, createValue('12'));
        expect(value.text, equals('12'));
        
        // Type 3
        value = formatter.formatEditUpdate(value, createValue('123'));
        expect(value.text, equals('123'));
        
        // Type 4 (separator appears)
        value = formatter.formatEditUpdate(value, createValue('1234'));
        expect(value.text, equals('1.234'));
        
        // Delete one
        value = formatter.formatEditUpdate(value, createValue('123'));
        expect(value.text, equals('123'));
      });
    });
  });
}
