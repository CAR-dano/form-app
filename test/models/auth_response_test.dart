import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/models/auth_response.dart';
import 'package:form_app/models/inspector_data.dart';

void main() {
  group('AuthResponse', () {
    group('fromJson', () {
      test('creates instance from valid JSON', () {
        // Arrange
        final json = {
          'accessToken': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
          'refreshToken': 'refresh_token_xyz123',
          'user': {
            'id': 'inspector-123',
            'name': 'John Doe',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(json);

        // Assert
        expect(authResponse.accessToken, equals('eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...'));
        expect(authResponse.refreshToken, equals('refresh_token_xyz123'));
        expect(authResponse.user, isA<Inspector>());
        expect(authResponse.user.id, equals('inspector-123'));
        expect(authResponse.user.name, equals('John Doe'));
      });

      test('correctly parses nested Inspector object', () {
        // Arrange
        final json = {
          'accessToken': 'access_token',
          'refreshToken': 'refresh_token',
          'user': {
            'id': 'inspector-456',
            'name': 'Jane Smith',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(json);

        // Assert
        expect(authResponse.user, isA<Inspector>());
        expect(authResponse.user.id, equals('inspector-456'));
        expect(authResponse.user.name, equals('Jane Smith'));
      });

      test('handles all required fields', () {
        // Arrange
        final json = {
          'accessToken': 'token123',
          'refreshToken': 'refresh456',
          'user': {
            'id': 'inspector-789',
            'name': 'Bob Johnson',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(json);

        // Assert
        expect(authResponse.accessToken, isNotNull);
        expect(authResponse.refreshToken, isNotNull);
        expect(authResponse.user, isNotNull);
        expect(authResponse.user.id, isNotNull);
        expect(authResponse.user.name, isNotNull);
      });

      test('throws when accessToken is missing', () {
        // Arrange
        final json = {
          'refreshToken': 'refresh_token',
          'user': {
            'id': 'inspector-123',
            'name': 'John Doe',
          },
        };

        // Act & Assert
        expect(
          () => AuthResponse.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when refreshToken is missing', () {
        // Arrange
        final json = {
          'accessToken': 'access_token',
          'user': {
            'id': 'inspector-123',
            'name': 'John Doe',
          },
        };

        // Act & Assert
        expect(
          () => AuthResponse.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when user object is missing', () {
        // Arrange
        final json = {
          'accessToken': 'access_token',
          'refreshToken': 'refresh_token',
        };

        // Act & Assert
        expect(
          () => AuthResponse.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when user object is null', () {
        // Arrange
        final json = {
          'accessToken': 'access_token',
          'refreshToken': 'refresh_token',
          'user': null,
        };

        // Act & Assert
        expect(
          () => AuthResponse.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when user.id is missing', () {
        // Arrange
        final json = {
          'accessToken': 'access_token',
          'refreshToken': 'refresh_token',
          'user': {
            'name': 'John Doe',
          },
        };

        // Act & Assert
        expect(
          () => AuthResponse.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when user.name is missing', () {
        // Arrange
        final json = {
          'accessToken': 'access_token',
          'refreshToken': 'refresh_token',
          'user': {
            'id': 'inspector-123',
          },
        };

        // Act & Assert
        expect(
          () => AuthResponse.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('handles empty strings for tokens', () {
        // Arrange: Empty strings are valid (though unusual)
        final json = {
          'accessToken': '',
          'refreshToken': '',
          'user': {
            'id': 'inspector-123',
            'name': 'John Doe',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(json);

        // Assert
        expect(authResponse.accessToken, equals(''));
        expect(authResponse.refreshToken, equals(''));
      });

      test('handles special characters in inspector name', () {
        // Arrange
        final json = {
          'accessToken': 'token123',
          'refreshToken': 'refresh456',
          'user': {
            'id': 'inspector-123',
            'name': 'José María Ñoño-González',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(json);

        // Assert
        expect(authResponse.user.name, equals('José María Ñoño-González'));
      });
    });

    group('toJson', () {
      test('converts instance to valid JSON', () {
        // Arrange
        final inspector = Inspector(
          id: 'inspector-123',
          name: 'John Doe',
        );
        final authResponse = AuthResponse(
          accessToken: 'access_token_xyz',
          refreshToken: 'refresh_token_abc',
          user: inspector,
        );

        // Act
        final json = authResponse.toJson();

        // Assert
        expect(json, isA<Map<String, dynamic>>());
        expect(json['accessToken'], equals('access_token_xyz'));
        expect(json['refreshToken'], equals('refresh_token_abc'));
        expect(json['user'], isA<Map<String, dynamic>>());
        expect(json['user']['id'], equals('inspector-123'));
        expect(json['user']['name'], equals('John Doe'));
      });

      test('includes nested Inspector object', () {
        // Arrange
        final inspector = Inspector(
          id: 'inspector-456',
          name: 'Jane Smith',
        );
        final authResponse = AuthResponse(
          accessToken: 'token',
          refreshToken: 'refresh',
          user: inspector,
        );

        // Act
        final json = authResponse.toJson();

        // Assert
        expect(json.containsKey('user'), isTrue);
        expect(json['user'], isA<Map<String, dynamic>>());
        expect(json['user']['id'], equals('inspector-456'));
        expect(json['user']['name'], equals('Jane Smith'));
      });

      test('round-trip: fromJson().toJson() equals original', () {
        // Arrange
        final originalJson = {
          'accessToken': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
          'refreshToken': 'refresh_token_xyz123',
          'user': {
            'id': 'inspector-789',
            'name': 'Bob Johnson',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(originalJson);
        final resultJson = authResponse.toJson();

        // Assert
        expect(resultJson['accessToken'], equals(originalJson['accessToken']));
        expect(resultJson['refreshToken'], equals(originalJson['refreshToken']));
        expect(resultJson['user']['id'], equals((originalJson['user'] as Map)['id']));
        expect(resultJson['user']['name'], equals((originalJson['user'] as Map)['name']));
      });

      test('preserves empty strings in round-trip', () {
        // Arrange
        final originalJson = {
          'accessToken': '',
          'refreshToken': '',
          'user': {
            'id': '',
            'name': '',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(originalJson);
        final resultJson = authResponse.toJson();

        // Assert
        expect(resultJson['accessToken'], equals(''));
        expect(resultJson['refreshToken'], equals(''));
        expect(resultJson['user']['id'], equals(''));
        expect(resultJson['user']['name'], equals(''));
      });

      test('preserves special characters in round-trip', () {
        // Arrange
        final originalJson = {
          'accessToken': 'token!@#\$%^&*()',
          'refreshToken': 'refresh/+=\\|<>?',
          'user': {
            'id': 'inspector-123',
            'name': 'José María Ñoño-González',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(originalJson);
        final resultJson = authResponse.toJson();

        // Assert
        expect(resultJson['accessToken'], equals(originalJson['accessToken']));
        expect(resultJson['refreshToken'], equals(originalJson['refreshToken']));
        expect(resultJson['user']['name'], equals((originalJson['user'] as Map)['name']));
      });
    });

    group('Constructor', () {
      test('creates instance with required parameters', () {
        // Arrange
        final inspector = Inspector(
          id: 'inspector-123',
          name: 'John Doe',
        );

        // Act
        final authResponse = AuthResponse(
          accessToken: 'access_token',
          refreshToken: 'refresh_token',
          user: inspector,
        );

        // Assert
        expect(authResponse.accessToken, equals('access_token'));
        expect(authResponse.refreshToken, equals('refresh_token'));
        expect(authResponse.user, equals(inspector));
      });

      test('stores Inspector reference correctly', () {
        // Arrange
        final inspector = Inspector(
          id: 'inspector-456',
          name: 'Jane Smith',
        );

        // Act
        final authResponse = AuthResponse(
          accessToken: 'token',
          refreshToken: 'refresh',
          user: inspector,
        );

        // Assert
        expect(authResponse.user, same(inspector));
        expect(authResponse.user.id, equals('inspector-456'));
        expect(authResponse.user.name, equals('Jane Smith'));
      });
    });

    group('Real-World Scenarios', () {
      test('handles typical authentication response from API', () {
        // Arrange: Realistic JWT tokens and user data
        final json = {
          'accessToken': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyfQ.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c',
          'refreshToken': 'b7e4f3c2a1d9e8f7a6b5c4d3e2f1a0b9c8d7e6f5a4b3c2d1e0f9a8b7c6d5e4f3',
          'user': {
            'id': 'uuid-4f3d2e1c-5a6b-7c8d-9e0f-1a2b3c4d5e6f',
            'name': 'Ahmad Dhani Prasetyo',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(json);

        // Assert
        expect(authResponse.accessToken, isNotEmpty);
        expect(authResponse.accessToken.length, greaterThan(100));
        expect(authResponse.refreshToken, isNotEmpty);
        expect(authResponse.user.name, equals('Ahmad Dhani Prasetyo'));
      });

      test('handles Indonesian inspector names', () {
        // Arrange
        final json = {
          'accessToken': 'token123',
          'refreshToken': 'refresh456',
          'user': {
            'id': 'inspector-001',
            'name': 'Budi Santoso',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(json);

        // Assert
        expect(authResponse.user.name, equals('Budi Santoso'));
      });

      test('handles long tokens (realistic JWT length)', () {
        // Arrange: Typical JWT token length is 200-500 characters
        final longToken = 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.'
            'eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkpvaG4gRG9lIiwiaWF0IjoxNTE2MjM5MDIyLCJleHAiOjE1MTYyMzkwMjIsImF1ZCI6InVzZXJzIiwiaXNzIjoiYXV0aC1zZXJ2aWNlIn0.'
            'SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c';
        
        final json = {
          'accessToken': longToken,
          'refreshToken': 'refresh_token',
          'user': {
            'id': 'inspector-123',
            'name': 'John Doe',
          },
        };

        // Act
        final authResponse = AuthResponse.fromJson(json);

        // Assert
        expect(authResponse.accessToken, equals(longToken));
        expect(authResponse.accessToken.length, greaterThan(200));
      });
    });
  });
}
