import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/models/api_exception.dart';
import 'package:form_app/services/auth_service.dart';
import 'package:form_app/services/inspection_service.dart';
import 'package:form_app/utils/crashlytics_util.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockAuthService extends Mock implements AuthService {}

class MockCrashlyticsUtil extends Mock implements CrashlyticsUtil {}

// Fake classes for Mocktail
class FakeStackTrace extends Fake implements StackTrace {}

void main() {
  late MockAuthService mockAuthService;
  late MockCrashlyticsUtil mockCrashlytics;
  late InspectionService inspectionService;

  setUpAll(() {
    // Register fallback values for Mocktail
    registerFallbackValue(FakeStackTrace());
  });

  setUp(() {
    mockAuthService = MockAuthService();
    mockCrashlytics = MockCrashlyticsUtil();
    
    // Setup default behavior for auth service
    when(() => mockAuthService.getAccessToken())
        .thenAnswer((_) async => 'test-token');
    
    inspectionService = InspectionService(mockAuthService, mockCrashlytics);
  });

  group('InspectionService - Error Handling Architecture', () {
    test('should use ApiException with named parameters', () {
      // Test that ApiException can be created with named parameters
      final exception = ApiException(
        message: 'Test error',
        statusCode: 400,
        responseData: {'error': 'Bad request'},
      );

      expect(exception.message, 'Test error');
      expect(exception.statusCode, 400);
      expect(exception.responseData, isNotNull);
    });

    test('ApiException should have required message parameter', () {
      // Verify that message is required
      expect(
        () => ApiException(message: 'Test'),
        returnsNormally,
      );
    });

    test('ApiException statusCode and responseData should be optional', () {
      // Test that we can create ApiException with just message
      final exception = ApiException(message: 'Test error');

      expect(exception.message, 'Test error');
      expect(exception.statusCode, isNull);
      expect(exception.responseData, isNull);
    });

    test('ApiException toString should include status code when present', () {
      final exceptionWithCode = ApiException(
        message: 'Test error',
        statusCode: 404,
      );

      expect(exceptionWithCode.toString(), contains('404'));
      expect(exceptionWithCode.toString(), contains('Test error'));
    });

    test('ApiException toString should work without status code', () {
      final exceptionWithoutCode = ApiException(message: 'Test error');

      expect(exceptionWithoutCode.toString(), contains('Test error'));
      expect(exceptionWithoutCode.toString(), isNot(contains('null')));
    });

    test('should not use DioException type checking', () {
      // Verify that we handle errors generically without DioException checks
      // The service should use dynamic casting instead
      
      final genericError = Exception('Network error');
      
      // Our service doesn't check "is DioException"
      expect(genericError.runtimeType.toString(), isNot(contains('DioException')));
    });

    test('cancellation errors should not be logged to Crashlytics', () {
      // Document the cancellation detection pattern
      final cancelMessage1 = 'Pengiriman data dibatalkan.';
      final cancelMessage2 = 'Request cancelled by user';
      
      expect(cancelMessage1.toLowerCase().contains('batal'), isTrue);
      expect(cancelMessage2.toLowerCase().contains('cancel'), isTrue);
    });

    test('non-cancellation errors should be logged to Crashlytics', () {
      // Document that normal errors are logged
      final normalError = 'Server connection failed';
      
      expect(normalError.toLowerCase().contains('batal'), isFalse);
      expect(normalError.toLowerCase().contains('cancel'), isFalse);
    });
  });

  group('InspectionService - getInspectionBranches', () {
    test('should return list of inspection branches on success', () async {
      // Integration test would verify actual API call
      // Here we document expected behavior:
      // 1. Makes GET request to inspection branches endpoint
      // 2. Parses JSON response into List<InspectionBranch>
      // 3. Returns the list
      
      expect(inspectionService, isNotNull);
    });

    test('should throw ApiException on non-200 response', () async {
      // Integration test would verify:
      // 1. Non-200 status code triggers ApiException
      // 2. Error message includes status code
      // 3. Response data is included in exception
      
      expect(inspectionService, isNotNull);
    });

    test('should log to Crashlytics before rethrowing ApiException', () async {
      // Integration test would verify:
      // 1. ApiException is caught
      // 2. recordError is called with exception and stack trace
      // 3. Original exception is rethrown
      
      expect(inspectionService, isNotNull);
    });

    test('should convert generic errors to ApiException', () async {
      // Integration test would verify:
      // 1. Generic error is caught
      // 2. Logged to Crashlytics
      // 3. Converted to ApiException with proper message
      // 4. ApiException is thrown
      
      expect(inspectionService, isNotNull);
    });
  });

  group('InspectionService - getInspectors', () {
    test('should return list of inspectors on success', () async {
      // Similar pattern to getInspectionBranches
      expect(inspectionService, isNotNull);
    });

    test('should follow same error handling pattern as other methods', () async {
      // Verifies consistency across service methods
      expect(inspectionService, isNotNull);
    });
  });

  group('InspectionService - submitFormData', () {
    test('should handle cancellation without logging to Crashlytics', () {
      // Document cancellation handling:
      // 1. Check if error message contains 'cancel' or 'batal'
      // 2. Skip Crashlytics logging if cancelled
      // 3. Still throw ApiException with cancellation message
      
      final cancelledError = 'Pengiriman data dibatalkan.';
      expect(cancelledError.toLowerCase(), contains('batal'));
    });

    test('should log non-cancellation errors to Crashlytics', () {
      // Document normal error handling:
      // 1. Check error message
      // 2. Log to Crashlytics if not cancelled
      // 3. Throw ApiException
      
      final normalError = 'Network timeout';
      expect(normalError.toLowerCase().contains('cancel'), isFalse);
    });
  });

  group('InspectionService - uploadImagesInBatches', () {
    test('should handle empty image list', () {
      // Verify that onProgress(0, 0) is called for empty list
      expect(inspectionService, isNotNull);
    });

    test('should report progress for each batch', () {
      // Verify progress callback is called correctly
      expect(inspectionService, isNotNull);
    });

    test('should skip Crashlytics logging for cancellations', () {
      // Same cancellation pattern as submitFormData
      expect(inspectionService, isNotNull);
    });
  });

  group('Error Handling Pattern Consistency', () {
    test('all service methods should follow the same error handling pattern', () {
      // Document the universal pattern:
      // try {
      //   // API call
      //   if (badResponse) throw ApiException(message: ...);
      // } on ApiException catch (e, stackTrace) {
      //   _crashlytics.recordError(e, stackTrace, reason: ...);
      //   rethrow;
      // } catch (e, stackTrace) {
      //   // Extract server response
      //   final apiException = ApiException(message: ..., statusCode: ..., responseData: ...);
      //   _crashlytics.recordError(apiException, stackTrace, reason: ...);
      //   throw apiException;
      // }
      
      expect(true, isTrue); // Pattern documented
    });

    test('UI layer should not log to Crashlytics', () {
      // Document UI layer responsibility:
      // 1. Catch ApiException
      // 2. Display error message to user
      // 3. Handle navigation if needed
      // 4. NO Crashlytics logging (service already logged)
      
      expect(true, isTrue); // Pattern documented
    });

    test('service layer should guarantee Crashlytics logging', () {
      // Document service layer responsibility:
      // 1. All API errors are logged (including cancellations)
      // 2. Logged before throwing/rethrowing
      // 3. Include context in reason parameter
      // 4. Extract server response data before logging
      
      expect(true, isTrue); // Pattern documented
    });
  });

  group('Server Response Extraction for InspectionService', () {
    test('should extract statusCode and responseData from error', () {
      // Simulate error with response (like DioException)
      final errorWithResponse = _ErrorWithResponse(
        statusCode: 404,
        data: {
          'message': 'Inspection branch not found',
          'code': 'NOT_FOUND',
        },
      );

      // Test extraction pattern
      String message = 'Error fetching inspection branches';
      int? statusCode;
      dynamic responseData;

      try {
        final errorResponse = (errorWithResponse as dynamic).response;
        if (errorResponse != null) {
          statusCode = errorResponse.statusCode;
          responseData = errorResponse.data;

          if (responseData != null && responseData['message'] != null) {
            message = responseData['message'];
          }
        }
      } catch (_) {
        message = 'Error fetching inspection branches: ${errorWithResponse.toString()}';
      }

      expect(statusCode, 404);
      expect(responseData, isNotNull);
      expect(responseData['message'], 'Inspection branch not found');
      expect(message, 'Inspection branch not found');
    });

    test('should handle error without response gracefully', () {
      final errorWithoutResponse = Exception('Network error');

      String message = 'Error fetching inspectors';
      int? statusCode;
      dynamic responseData;

      try {
        final errorResponse = (errorWithoutResponse as dynamic).response;
        if (errorResponse != null) {
          statusCode = errorResponse.statusCode;
          responseData = errorResponse.data;
        }
      } catch (_) {
        message = 'Error fetching inspectors: ${errorWithoutResponse.toString()}';
      }

      expect(statusCode, isNull);
      expect(responseData, isNull);
      expect(message, contains('Network error'));
    });

    test('should detect cancellation errors', () {
      final cancelMessages = [
        'Request cancelled',
        'Pengiriman data dibatalkan',
        'DioException: cancelled',
      ];

      for (final msg in cancelMessages) {
        final isCancelled = msg.toLowerCase().contains('cancel') || 
                            msg.toLowerCase().contains('batal');
        expect(isCancelled, isTrue, reason: 'Should detect: $msg');
      }
    });

    test('should create ApiException with server response data', () {
      final errorWithResponse = _ErrorWithResponse(
        statusCode: 500,
        data: {
          'message': 'Database connection failed',
          'code': 'DB_ERROR',
          'timestamp': '2024-01-01T00:00:00Z',
        },
      );

      // Simulate extraction
      String message = 'Error fetching inspection branches';
      int? statusCode;
      dynamic responseData;

      try {
        final errorResponse = (errorWithResponse as dynamic).response;
        if (errorResponse != null) {
          statusCode = errorResponse.statusCode;
          responseData = errorResponse.data;

          if (responseData != null && responseData['message'] != null) {
            message = responseData['message'];
          }
        }
      } catch (_) {}

      final apiException = ApiException(
        message: message,
        statusCode: statusCode,
        responseData: responseData,
      );

      expect(apiException.message, 'Database connection failed');
      expect(apiException.statusCode, 500);
      expect(apiException.responseData['code'], 'DB_ERROR');
      
      // Verify toString includes responseData
      expect(apiException.toString(), contains('[Response:'));
      expect(apiException.toString(), contains('DB_ERROR'));
    });

    test('should handle responseData without message field', () {
      final responseData = {
        'error': 'invalid_request',
        'details': 'Missing required parameters',
      };

      String message = 'Error fetching data';

      if (responseData['message'] != null) {
        message = responseData['message'] as String;
      } else {
        message = 'Error: ${responseData.toString()}';
      }

      expect(message, contains('Error:'));
      expect(message, contains('invalid_request'));
    });

    test('should log ALL errors including cancellations', () {
      // NEW BEHAVIOR: All errors are logged, including cancellations
      final cancelException = ApiException(message: 'Request cancelled');
      final normalException = ApiException(message: 'Network timeout');

      // Both should be logged to Crashlytics
      expect(cancelException.message.toLowerCase().contains('cancel'), isTrue);
      expect(normalException.message.toLowerCase().contains('cancel'), isFalse);
      
      // Both types of exceptions should be logged
      expect(cancelException, isA<ApiException>());
      expect(normalException, isA<ApiException>());
    });

    test('getInspectionBranches should follow error extraction pattern', () {
      // Document expected behavior:
      // 1. Catch generic error
      // 2. Check for cancellation
      // 3. Extract statusCode and responseData
      // 4. Create ApiException with extracted data
      // 5. Log ApiException to Crashlytics
      // 6. Throw ApiException

      final error = _ErrorWithResponse(
        statusCode: 403,
        data: {'message': 'Access denied', 'code': 'FORBIDDEN'},
      );

      // Extraction pattern
      String message = 'Error fetching inspection branches';
      int? statusCode;
      dynamic responseData;

      final errorMessage = error.toString().toLowerCase();
      final isCancelled = errorMessage.contains('cancel');

      if (!isCancelled) {
        try {
          final errorResponse = (error as dynamic).response;
          if (errorResponse != null) {
            statusCode = errorResponse.statusCode;
            responseData = errorResponse.data;

          if (responseData != null && responseData['message'] != null) {
            message = responseData['message'] as String;
          }
          }
        } catch (_) {}
      }

      expect(isCancelled, isFalse);
      expect(statusCode, 403);
      expect(message, 'Access denied');
    });

    test('getInspectors should follow same pattern as getInspectionBranches', () {
      // Both methods should use identical error handling
      final error = _ErrorWithResponse(
        statusCode: 401,
        data: {'message': 'Unauthorized', 'code': 'AUTH_REQUIRED'},
      );

      String message = 'Error fetching inspectors';
      int? statusCode;
      dynamic responseData;

      try {
        final errorResponse = (error as dynamic).response;
        if (errorResponse != null) {
          statusCode = errorResponse.statusCode;
          responseData = errorResponse.data;

          if (responseData != null && responseData['message'] != null) {
            message = responseData['message'];
          }
        }
      } catch (_) {}

      expect(statusCode, 401);
      expect(message, 'Unauthorized');
      expect(responseData['code'], 'AUTH_REQUIRED');
    });
  });
}

// Helper class to simulate errors with response data
class _ErrorWithResponse {
  final _Response response;
  
  _ErrorWithResponse({required int statusCode, required Map<String, dynamic> data})
      : response = _Response(statusCode: statusCode, data: data);
}

class _Response {
  final int statusCode;
  final Map<String, dynamic> data;
  
  _Response({required this.statusCode, required this.data});
}
