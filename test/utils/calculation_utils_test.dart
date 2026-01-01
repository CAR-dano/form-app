import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/models/form_data.dart';
import 'package:form_app/utils/calculation_utils.dart';

void main() {
  group('calculateOverallRating', () {
    group('Basic Functionality', () {
      test('calculates average correctly with all scores present', () {
        // Arrange: All scores are 80
        final formData = FormData(
          interiorSelectedValue: 80,
          eksteriorSelectedValue: 80,
          kakiKakiSelectedValue: 80,
          mesinSelectedValue: 80,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (80 + 80 + 80 + 80) / 4 = 320 / 4 = 80
        expect(result, equals(80));
      });

      test('calculates average correctly with mixed scores', () {
        // Arrange: Different scores
        final formData = FormData(
          interiorSelectedValue: 90,
          eksteriorSelectedValue: 70,
          kakiKakiSelectedValue: 85,
          mesinSelectedValue: 75,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (90 + 70 + 85 + 75) / 4 = 320 / 4 = 80
        expect(result, equals(80));
      });

      test('returns 0 when all scores are 0', () {
        // Arrange
        final formData = FormData(
          interiorSelectedValue: 0,
          eksteriorSelectedValue: 0,
          kakiKakiSelectedValue: 0,
          mesinSelectedValue: 0,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert
        expect(result, equals(0));
      });

      test('calculates with minimum and maximum scores', () {
        // Arrange: One max score, rest are zero
        final formData = FormData(
          interiorSelectedValue: 100,
          eksteriorSelectedValue: 0,
          kakiKakiSelectedValue: 0,
          mesinSelectedValue: 0,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: 100 / 4 = 25
        expect(result, equals(25));
      });
    });

    group('Null Handling', () {
      test('returns 0 when all scores are null (defaults to 0)', () {
        // Arrange: All scores are null (not provided)
        final formData = FormData(
          interiorSelectedValue: null,
          eksteriorSelectedValue: null,
          kakiKakiSelectedValue: null,
          mesinSelectedValue: null,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: All null values default to 0, so (0 + 0 + 0 + 0) / 4 = 0
        expect(result, equals(0));
      });

      test('treats null scores as 0 in calculation', () {
        // Arrange: Mixed null and non-null values
        final formData = FormData(
          interiorSelectedValue: 80,
          eksteriorSelectedValue: null, // defaults to 0
          kakiKakiSelectedValue: 60,
          mesinSelectedValue: null, // defaults to 0
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (80 + 0 + 60 + 0) / 4 = 140 / 4 = 35
        expect(result, equals(35));
      });

      test('handles single null value among non-null scores', () {
        // Arrange
        final formData = FormData(
          interiorSelectedValue: 90,
          eksteriorSelectedValue: 80,
          kakiKakiSelectedValue: null, // defaults to 0
          mesinSelectedValue: 70,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (90 + 80 + 0 + 70) / 4 = 240 / 4 = 60
        expect(result, equals(60));
      });

      test('handles three null values with one score', () {
        // Arrange
        final formData = FormData(
          interiorSelectedValue: null,
          eksteriorSelectedValue: null,
          kakiKakiSelectedValue: 100,
          mesinSelectedValue: null,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (0 + 0 + 100 + 0) / 4 = 100 / 4 = 25
        expect(result, equals(25));
      });
    });

    group('Integer Division Behavior', () {
      test('rounds down with integer division (e.g., 19/4 = 4, not 5)', () {
        // Arrange: Sum that doesn't divide evenly
        final formData = FormData(
          interiorSelectedValue: 5,
          eksteriorSelectedValue: 5,
          kakiKakiSelectedValue: 5,
          mesinSelectedValue: 4,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (5 + 5 + 5 + 4) / 4 = 19 / 4 = 4 (integer division)
        expect(result, equals(4));
      });

      test('handles exact division', () {
        // Arrange: Sum divides evenly
        final formData = FormData(
          interiorSelectedValue: 20,
          eksteriorSelectedValue: 20,
          kakiKakiSelectedValue: 20,
          mesinSelectedValue: 20,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (20 + 20 + 20 + 20) / 4 = 80 / 4 = 20
        expect(result, equals(20));
      });

      test('rounds down when sum is 1 less than next integer result', () {
        // Arrange: 39 / 4 = 9.75, should round down to 9
        final formData = FormData(
          interiorSelectedValue: 10,
          eksteriorSelectedValue: 10,
          kakiKakiSelectedValue: 10,
          mesinSelectedValue: 9,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (10 + 10 + 10 + 9) / 4 = 39 / 4 = 9
        expect(result, equals(9));
      });

      test('rounds down when sum has remainder of 3', () {
        // Arrange: 23 / 4 = 5.75, should round down to 5
        final formData = FormData(
          interiorSelectedValue: 6,
          eksteriorSelectedValue: 6,
          kakiKakiSelectedValue: 6,
          mesinSelectedValue: 5,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (6 + 6 + 6 + 5) / 4 = 23 / 4 = 5
        expect(result, equals(5));
      });
    });

    group('Edge Cases', () {
      test('handles very large scores', () {
        // Arrange: Large integer values (though unlikely in real usage)
        final formData = FormData(
          interiorSelectedValue: 1000000,
          eksteriorSelectedValue: 1000000,
          kakiKakiSelectedValue: 1000000,
          mesinSelectedValue: 1000000,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: 4000000 / 4 = 1000000
        expect(result, equals(1000000));
      });

      test('handles single high score with three zeros', () {
        // Arrange: Only interior has score
        final formData = FormData(
          interiorSelectedValue: 100,
          eksteriorSelectedValue: 0,
          kakiKakiSelectedValue: 0,
          mesinSelectedValue: 0,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: 100 / 4 = 25
        expect(result, equals(25));
      });

      test('handles all maximum realistic scores (100)', () {
        // Arrange: All scores at maximum realistic value
        final formData = FormData(
          interiorSelectedValue: 100,
          eksteriorSelectedValue: 100,
          kakiKakiSelectedValue: 100,
          mesinSelectedValue: 100,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: 400 / 4 = 100
        expect(result, equals(100));
      });

      test('handles asymmetric score distribution', () {
        // Arrange: One very low, rest are high
        final formData = FormData(
          interiorSelectedValue: 10,
          eksteriorSelectedValue: 90,
          kakiKakiSelectedValue: 90,
          mesinSelectedValue: 90,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (10 + 90 + 90 + 90) / 4 = 280 / 4 = 70
        expect(result, equals(70));
      });

      test('handles score of 1 for each category', () {
        // Arrange: Minimum non-zero scores
        final formData = FormData(
          interiorSelectedValue: 1,
          eksteriorSelectedValue: 1,
          kakiKakiSelectedValue: 1,
          mesinSelectedValue: 1,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: 4 / 4 = 1
        expect(result, equals(1));
      });
    });

    group('Real-World Scenarios', () {
      test('typical good condition vehicle (scores in 80-90 range)', () {
        // Arrange: Realistic "good condition" scores
        final formData = FormData(
          interiorSelectedValue: 85,
          eksteriorSelectedValue: 88,
          kakiKakiSelectedValue: 82,
          mesinSelectedValue: 87,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (85 + 88 + 82 + 87) / 4 = 342 / 4 = 85
        expect(result, equals(85));
      });

      test('typical fair condition vehicle (scores in 60-70 range)', () {
        // Arrange: Realistic "fair condition" scores
        final formData = FormData(
          interiorSelectedValue: 65,
          eksteriorSelectedValue: 60,
          kakiKakiSelectedValue: 70,
          mesinSelectedValue: 68,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (65 + 60 + 70 + 68) / 4 = 263 / 4 = 65
        expect(result, equals(65));
      });

      test('typical poor condition vehicle (scores in 30-50 range)', () {
        // Arrange: Realistic "poor condition" scores
        final formData = FormData(
          interiorSelectedValue: 45,
          eksteriorSelectedValue: 35,
          kakiKakiSelectedValue: 40,
          mesinSelectedValue: 38,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (45 + 35 + 40 + 38) / 4 = 158 / 4 = 39
        expect(result, equals(39));
      });

      test('vehicle with excellent interior but poor mechanical (mixed quality)', () {
        // Arrange: Good appearance, poor mechanical
        final formData = FormData(
          interiorSelectedValue: 95,
          eksteriorSelectedValue: 90,
          kakiKakiSelectedValue: 45,
          mesinSelectedValue: 40,
        );

        // Act
        final result = calculateOverallRating(formData);

        // Assert: (95 + 90 + 45 + 40) / 4 = 270 / 4 = 67
        expect(result, equals(67));
      });
    });
  });
}
