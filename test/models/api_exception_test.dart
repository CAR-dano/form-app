import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/models/api_exception.dart';

void main() {
  group('ApiException', () {
    group('Constructor', () {
      test('should create exception with required message parameter', () {
        final exception = ApiException(message: 'Test error');

        expect(exception.message, 'Test error');
        expect(exception.statusCode, isNull);
        expect(exception.responseData, isNull);
      });

      test('should create exception with all parameters', () {
        final responseData = {'error': 'Detailed error', 'code': 'ERR_001'};
        final exception = ApiException(
          message: 'Test error',
          statusCode: 400,
          responseData: responseData,
        );

        expect(exception.message, 'Test error');
        expect(exception.statusCode, 400);
        expect(exception.responseData, responseData);
        expect(exception.responseData['error'], 'Detailed error');
      });

      test('should accept null statusCode', () {
        final exception = ApiException(
          message: 'Test error',
          statusCode: null,
        );

        expect(exception.message, 'Test error');
        expect(exception.statusCode, isNull);
      });

      test('should accept null responseData', () {
        final exception = ApiException(
          message: 'Test error',
          responseData: null,
        );

        expect(exception.message, 'Test error');
        expect(exception.responseData, isNull);
      });

      test('should work with various HTTP status codes', () {
        final statusCodes = [200, 201, 400, 401, 403, 404, 500, 502, 503];

        for (final code in statusCodes) {
          final exception = ApiException(
            message: 'Error $code',
            statusCode: code,
          );

          expect(exception.statusCode, code);
          expect(exception.message, 'Error $code');
        }
      });
    });

    group('toString()', () {
      test('should include status code when present', () {
        final exception = ApiException(
          message: 'Not found',
          statusCode: 404,
        );

        final result = exception.toString();

        expect(result, contains('404'));
        expect(result, contains('Not found'));
        expect(result, contains('ApiException'));
      });

      test('should not include status code when null', () {
        final exception = ApiException(message: 'Generic error');

        final result = exception.toString();

        expect(result, contains('Generic error'));
        expect(result, contains('ApiException'));
        expect(result, isNot(contains('null')));
        expect(result, isNot(contains('(')));
      });

      test('should format correctly for 401 errors', () {
        final exception = ApiException(
          message: 'Unauthorized',
          statusCode: 401,
        );

        expect(exception.toString(), 'ApiException (401): Unauthorized');
      });

      test('should format correctly for 500 errors', () {
        final exception = ApiException(
          message: 'Internal server error',
          statusCode: 500,
        );

        expect(exception.toString(), 'ApiException (500): Internal server error');
      });
    });

    group('implements Exception', () {
      test('should be an instance of Exception', () {
        final exception = ApiException(message: 'Test');

        expect(exception, isA<Exception>());
      });

      test('should be throwable', () {
        expect(
          () => throw ApiException(message: 'Test error'),
          throwsA(isA<ApiException>()),
        );
      });

      test('should be catchable as Exception', () {
        try {
          throw ApiException(message: 'Test error');
        } on Exception catch (e) {
          expect(e, isA<ApiException>());
          expect((e as ApiException).message, 'Test error');
        }
      });
    });

    group('Real-world scenarios', () {
      test('should handle login failure scenario', () {
        final exception = ApiException(
          message: 'Invalid email or PIN',
          statusCode: 401,
          responseData: {
            'message': 'Invalid email or PIN',
            'error': 'authentication_failed',
          },
        );

        expect(exception.message, 'Invalid email or PIN');
        expect(exception.statusCode, 401);
        expect(exception.responseData['error'], 'authentication_failed');
      });

      test('should handle network timeout scenario', () {
        final exception = ApiException(
          message: 'Request timeout',
          statusCode: null,
          responseData: null,
        );

        expect(exception.message, 'Request timeout');
        expect(exception.statusCode, isNull);
        expect(exception.toString(), 'ApiException: Request timeout');
      });

      test('should handle server error scenario', () {
        final exception = ApiException(
          message: 'Internal server error',
          statusCode: 500,
          responseData: {
            'message': 'Database connection failed',
            'timestamp': '2024-01-01T00:00:00Z',
          },
        );

        expect(exception.statusCode, 500);
        expect(exception.responseData['message'], 'Database connection failed');
      });

      test('should handle validation error scenario', () {
        final exception = ApiException(
          message: 'Validation failed',
          statusCode: 422,
          responseData: {
            'errors': [
              {'field': 'email', 'message': 'Email is required'},
              {'field': 'pin', 'message': 'PIN must be 6 digits'},
            ],
          },
        );

        expect(exception.statusCode, 422);
        expect(exception.responseData['errors'], isA<List>());
        expect((exception.responseData['errors'] as List).length, 2);
      });

      test('should handle user cancellation scenario', () {
        final exception = ApiException(
          message: 'Pengiriman data dibatalkan.',
        );

        expect(exception.message.toLowerCase(), contains('batal'));
        expect(exception.statusCode, isNull);
      });

      test('should handle token expiry scenario', () {
        final exception = ApiException(
          message: 'Access token kedaluwarsa, mohon login ulang',
          statusCode: 401,
          responseData: {
            'error': 'token_expired',
            'message': 'JWT token has expired',
          },
        );

        expect(exception.statusCode, 401);
        expect(exception.responseData['error'], 'token_expired');
      });
    });

    group('Message variations', () {
      test('should handle Indonesian error messages', () {
        final messages = [
          'Gagal mengirim data',
          'Koneksi internet terputus',
          'Pengiriman data dibatalkan',
          'Token kedaluwarsa',
        ];

        for (final message in messages) {
          final exception = ApiException(message: message);
          expect(exception.message, message);
        }
      });

      test('should handle English error messages', () {
        final messages = [
          'Failed to submit form data',
          'Network connection lost',
          'Request cancelled by user',
          'Token expired',
        ];

        for (final message in messages) {
          final exception = ApiException(message: message);
          expect(exception.message, message);
        }
      });
    });

    group('Named parameters usage', () {
      test('parameters can be provided in any order', () {
        final exception1 = ApiException(
          message: 'Test',
          statusCode: 400,
          responseData: {'error': 'test'},
        );

        final exception2 = ApiException(
          statusCode: 400,
          responseData: {'error': 'test'},
          message: 'Test',
        );

        final exception3 = ApiException(
          responseData: {'error': 'test'},
          message: 'Test',
          statusCode: 400,
        );

        expect(exception1.message, exception2.message);
        expect(exception2.message, exception3.message);
        expect(exception1.statusCode, exception2.statusCode);
        expect(exception2.statusCode, exception3.statusCode);
      });

      test('only required parameter can be provided', () {
        final exception = ApiException(message: 'Required only');

        expect(exception.message, 'Required only');
        expect(exception.statusCode, isNull);
        expect(exception.responseData, isNull);
      });
    });
  });
}
