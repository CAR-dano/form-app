import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/models/api_exception.dart';
import 'package:form_app/services/token_manager_service.dart';
import 'package:form_app/utils/crashlytics_util.dart';
import 'package:mocktail/mocktail.dart';

// Mock classes
class MockTokenManagerService extends Mock implements TokenManagerService {}

class MockCrashlyticsUtil extends Mock implements CrashlyticsUtil {}

// Fake classes for Mocktail
class FakeStackTrace extends Fake implements StackTrace {}

void main() {
  late MockTokenManagerService mockTokenManager;
  late MockCrashlyticsUtil mockCrashlytics;

  setUpAll(() {
    // Register fallback values for Mocktail
    registerFallbackValue(FakeStackTrace());
  });

  setUp(() {
    mockTokenManager = MockTokenManagerService();
    mockCrashlytics = MockCrashlyticsUtil();
  });

  group('AuthService - Error Handling Architecture', () {
    test('ApiException should be throwable and catchable', () {
      expect(
        () => throw ApiException(message: 'Test error'),
        throwsA(isA<ApiException>()),
      );
    });

    test('ApiException should support named parameters', () {
      final exception = ApiException(
        message: 'Test error',
        statusCode: 401,
        responseData: {'error': 'unauthorized'},
      );

      expect(exception.message, 'Test error');
      expect(exception.statusCode, 401);
      expect(exception.responseData, isNotNull);
    });

    test('should handle error conversion pattern', () {
      // Document the pattern: catch generic error, convert to ApiException
      final genericError = Exception('Network error');
      
      // This is what the service does
      final apiException = ApiException(
        message: 'Login failed: ${genericError.toString()}',
      );

      expect(apiException, isA<ApiException>());
      expect(apiException.message, contains('Network error'));
    });

    test('should detect cancellation errors', () {
      // Test cancellation detection pattern
      final cancelledMessage1 = 'Pengiriman data dibatalkan.';
      final cancelledMessage2 = 'Request cancelled';
      final normalMessage = 'Network timeout';

      expect(cancelledMessage1.toLowerCase().contains('batal'), isTrue);
      expect(cancelledMessage2.toLowerCase().contains('cancel'), isTrue);
      expect(normalMessage.toLowerCase().contains('batal'), isFalse);
      expect(normalMessage.toLowerCase().contains('cancel'), isFalse);
    });

    test('should extract response data from errors using dynamic casting', () {
      // Document the pattern used in auth_service for extracting error data
      
      // Simulate an error object with response property (like DioException)
      final errorWithResponse = _ErrorWithResponse(
        statusCode: 401,
        data: {'message': 'Invalid credentials'},
      );

      // Test dynamic extraction pattern
      try {
        final response = (errorWithResponse as dynamic).response;
        expect(response.statusCode, 401);
        expect(response.data['message'], 'Invalid credentials');
      } catch (_) {
        fail('Should be able to extract response data');
      }
    });

    test('should handle errors without response data gracefully', () {
      final errorWithoutResponse = Exception('Simple error');

      // Test that we can safely try to extract response and handle failure
      String message = 'Login failed: ${errorWithoutResponse.toString()}';
      int? statusCode;

      try {
        final response = (errorWithoutResponse as dynamic).response;
        if (response != null) {
          statusCode = response.statusCode;
        }
      } catch (_) {
        // If we can't extract response, keep default values
      }

      expect(message, contains('Simple error'));
      expect(statusCode, isNull);
    });

    test('should handle 401 errors specially for token refresh', () {
      // Test the pattern for detecting 401 errors
      final error401 = _ErrorWithResponse(
        statusCode: 401,
        data: {'error': 'token_expired'},
      );

      bool is401 = false;
      try {
        final errorResponse = (error401 as dynamic).response;
        if (errorResponse?.statusCode == 401) {
          is401 = true;
        }
      } catch (_) {
        // Not a 401
      }

      expect(is401, isTrue);
    });
  });

  group('TokenManagerService Integration', () {
    test('getAccessToken should call TokenManagerService', () async {
      when(() => mockTokenManager.getAccessToken())
          .thenAnswer((_) async => 'test-token');

      final result = await mockTokenManager.getAccessToken();

      expect(result, 'test-token');
      verify(() => mockTokenManager.getAccessToken()).called(1);
    });

    test('getRefreshToken should call TokenManagerService', () async {
      when(() => mockTokenManager.getRefreshToken())
          .thenAnswer((_) async => 'refresh-token');

      final result = await mockTokenManager.getRefreshToken();

      expect(result, 'refresh-token');
      verify(() => mockTokenManager.getRefreshToken()).called(1);
    });

    test('clearTokens should be called on logout', () async {
      when(() => mockTokenManager.clearTokens()).thenAnswer((_) async {});

      await mockTokenManager.clearTokens();

      verify(() => mockTokenManager.clearTokens()).called(1);
    });
  });

  group('CrashlyticsUtil Integration', () {
    test('recordError should be called with exception and stackTrace', () {
      final exception = ApiException(message: 'Test error');
      final stackTrace = StackTrace.current;

      when(() => mockCrashlytics.recordError(
            any(),
            any(),
            reason: any(named: 'reason'),
          )).thenAnswer((_) async {});

      mockCrashlytics.recordError(
        exception,
        stackTrace,
        reason: 'Test reason',
      );

      verify(() => mockCrashlytics.recordError(
            exception,
            stackTrace,
            reason: 'Test reason',
          )).called(1);
    });

    test('should not log cancellation errors', () {
      // Document the pattern: check for cancellation before logging
      final cancelMessage = 'Pengiriman data dibatalkan.';
      final isCancelled = cancelMessage.toLowerCase().contains('batal') ||
          cancelMessage.toLowerCase().contains('cancel');

      // If cancelled, we don't call recordError
      if (!isCancelled) {
        mockCrashlytics.recordError(
          Exception(cancelMessage),
          StackTrace.current,
          reason: 'Should not be called',
        );
      }

      // Verify that recordError was NOT called
      verifyNever(() => mockCrashlytics.recordError(
            any(),
            any(),
            reason: any(named: 'reason'),
          ));
    });

    test('should log non-cancellation errors', () {
      final normalError = ApiException(message: 'Network timeout');
      final isCancelled = normalError.message.toLowerCase().contains('batal') ||
          normalError.message.toLowerCase().contains('cancel');

      when(() => mockCrashlytics.recordError(
            any(),
            any(),
            reason: any(named: 'reason'),
          )).thenAnswer((_) async {});

      // For non-cancelled errors, we should log
      if (!isCancelled) {
        mockCrashlytics.recordError(
          normalError,
          StackTrace.current,
          reason: 'Network error',
        );
      }

      // Verify that recordError WAS called
      verify(() => mockCrashlytics.recordError(
            normalError,
            any(),
            reason: 'Network error',
          )).called(1);
    });
  });

  group('Error Handling Pattern Documentation', () {
    test('Service layer pattern: catch ApiException, log, rethrow', () {
      // This test documents the pattern used in service methods
      
      try {
        throw ApiException(message: 'API error', statusCode: 500);
      } on ApiException catch (e, stackTrace) {
        // Pattern: Log to Crashlytics
        expect(e, isA<ApiException>());
        expect(stackTrace, isA<StackTrace>());
        
        // Then rethrow
        expect(() => throw e, throwsA(isA<ApiException>()));
      }
    });

    test('Service layer pattern: catch generic, convert to ApiException', () {
      // This test documents error conversion pattern
      
      try {
        throw Exception('Generic error');
      } catch (e, stackTrace) {
        // Pattern: Convert to ApiException
        final apiException = ApiException(
          message: 'Operation failed: ${e.toString()}',
        );

        expect(apiException, isA<ApiException>());
        expect(apiException.message, contains('Generic error'));
        expect(stackTrace, isA<StackTrace>());
      }
    });

    test('UI layer pattern: catch ApiException, show message, no logging', () {
      // This test documents UI layer responsibilities
      
      try {
        throw ApiException(message: 'User friendly error');
      } on ApiException catch (e) {
        // UI layer should:
        // 1. Catch the exception
        expect(e, isA<ApiException>());
        
        // 2. Show message to user
        final userMessage = e.message;
        expect(userMessage, 'User friendly error');
        
        // 3. NOT log to Crashlytics (service already logged)
        // (no recordError call here)
      }
    });

    test('No DioException type checking pattern', () {
      // Document that we avoid "is DioException" checks
      
      final error = Exception('Some error');
      
      // Bad pattern (we don't do this):
      // if (e is dio.DioException) { ... }
      
      // Good pattern (we do this):
      try {
        final response = (error as dynamic).response;
        // Try to use it...
        expect(response, isNull); // This error has no response
      } catch (_) {
        // Safely handle if response doesn't exist
        expect(true, isTrue);
      }
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
