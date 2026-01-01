import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/models/user_data.dart';

void main() {
  group('UserData', () {
    group('fromJson', () {
      test('creates instance from valid JSON', () {
        // Arrange
        final json = {
          'id': 'user123',
          'name': 'Budi Santoso',
        };

        // Act
        final user = UserData.fromJson(json);

        // Assert
        expect(user.id, equals('user123'));
        expect(user.name, equals('Budi Santoso'));
      });

      test('handles Indonesian names with special characters', () {
        // Arrange
        final json = {
          'id': '456',
          'name': 'Siti Nur\'aini',
        };

        // Act
        final user = UserData.fromJson(json);

        // Assert
        expect(user.name, equals('Siti Nur\'aini'));
      });

      test('handles empty strings', () {
        // Arrange
        final json = {
          'id': '',
          'name': '',
        };

        // Act
        final user = UserData.fromJson(json);

        // Assert
        expect(user.id, equals(''));
        expect(user.name, equals(''));
      });

      test('throws when id is missing', () {
        // Arrange
        final json = {
          'name': 'John Doe',
        };

        // Act & Assert
        expect(
          () => UserData.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when name is missing', () {
        // Arrange
        final json = {
          'id': '123',
        };

        // Act & Assert
        expect(
          () => UserData.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when id is null', () {
        // Arrange
        final json = {
          'id': null,
          'name': 'John Doe',
        };

        // Act & Assert
        expect(
          () => UserData.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when name is null', () {
        // Arrange
        final json = {
          'id': '123',
          'name': null,
        };

        // Act & Assert
        expect(
          () => UserData.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });
    });

    group('fromAuthResponse', () {
      test('creates instance from auth response JSON structure', () {
        // Arrange: Simulates actual API response structure
        final json = {
          'user': {
            'id': 'inspector789',
            'name': 'Ahmad Rahman',
          },
          'accessToken': 'eyJhbGc...',
          'refreshToken': 'eyJhbGc...',
        };

        // Act
        final user = UserData.fromAuthResponse(json);

        // Assert
        expect(user.id, equals('inspector789'));
        expect(user.name, equals('Ahmad Rahman'));
      });

      test('handles nested user object with Indonesian names', () {
        // Arrange
        final json = {
          'user': {
            'id': 'usr-456',
            'name': 'Dewi Lestari',
          },
          'accessToken': 'token123',
        };

        // Act
        final user = UserData.fromAuthResponse(json);

        // Assert
        expect(user.id, equals('usr-456'));
        expect(user.name, equals('Dewi Lestari'));
      });

      test('handles empty strings in nested user object', () {
        // Arrange
        final json = {
          'user': {
            'id': '',
            'name': '',
          },
        };

        // Act
        final user = UserData.fromAuthResponse(json);

        // Assert
        expect(user.id, equals(''));
        expect(user.name, equals(''));
      });

      test('throws when user object is missing', () {
        // Arrange
        final json = {
          'accessToken': 'token123',
          'refreshToken': 'refresh456',
        };

        // Act & Assert
        expect(
          () => UserData.fromAuthResponse(json),
          throwsA(isA<NoSuchMethodError>()),
        );
      });

      test('throws when user.id is missing', () {
        // Arrange
        final json = {
          'user': {
            'name': 'John Doe',
          },
        };

        // Act & Assert
        expect(
          () => UserData.fromAuthResponse(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when user.name is missing', () {
        // Arrange
        final json = {
          'user': {
            'id': '123',
          },
        };

        // Act & Assert
        expect(
          () => UserData.fromAuthResponse(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when user object is null', () {
        // Arrange
        final json = {
          'user': null,
        };

        // Act & Assert
        expect(
          () => UserData.fromAuthResponse(json),
          throwsA(isA<NoSuchMethodError>()),
        );
      });

      test('ignores extra fields in auth response', () {
        // Arrange: Extra fields should not affect parsing
        final json = {
          'user': {
            'id': 'usr-999',
            'name': 'Test User',
            'email': 'test@example.com',
            'role': 'inspector',
          },
          'accessToken': 'token',
          'refreshToken': 'refresh',
          'expiresIn': 3600,
        };

        // Act
        final user = UserData.fromAuthResponse(json);

        // Assert: Should only extract id and name
        expect(user.id, equals('usr-999'));
        expect(user.name, equals('Test User'));
      });
    });

    group('toJson', () {
      test('converts instance to valid JSON', () {
        // Arrange
        final user = UserData(
          id: 'user123',
          name: 'Budi Santoso',
        );

        // Act
        final json = user.toJson();

        // Assert
        expect(json['id'], equals('user123'));
        expect(json['name'], equals('Budi Santoso'));
        expect(json.length, equals(2));
      });

      test('round-trip: fromJson().toJson() equals original', () {
        // Arrange
        final originalJson = {
          'id': 'test-789',
          'name': 'Rina Kusuma',
        };

        // Act
        final user = UserData.fromJson(originalJson);
        final resultJson = user.toJson();

        // Assert
        expect(resultJson, equals(originalJson));
      });

      test('preserves empty strings in round-trip', () {
        // Arrange
        final originalJson = {
          'id': '',
          'name': '',
        };

        // Act
        final user = UserData.fromJson(originalJson);
        final resultJson = user.toJson();

        // Assert
        expect(resultJson, equals(originalJson));
      });

      test('preserves Indonesian names in round-trip', () {
        // Arrange
        final originalJson = {
          'id': 'usr-001',
          'name': 'Muhammad Al-Fajri',
        };

        // Act
        final user = UserData.fromJson(originalJson);
        final resultJson = user.toJson();

        // Assert
        expect(resultJson['name'], equals('Muhammad Al-Fajri'));
      });
    });

    group('Constructor', () {
      test('creates instance with required parameters', () {
        // Act
        final user = UserData(
          id: '123',
          name: 'Test User',
        );

        // Assert
        expect(user.id, equals('123'));
        expect(user.name, equals('Test User'));
      });

      test('stores values correctly', () {
        // Arrange
        const testId = 'inspector-456';
        const testName = 'Agus Setiawan';

        // Act
        final user = UserData(
          id: testId,
          name: testName,
        );

        // Assert
        expect(user.id, same(testId));
        expect(user.name, same(testName));
      });

      test('allows empty strings', () {
        // Act
        final user = UserData(
          id: '',
          name: '',
        );

        // Assert
        expect(user.id, equals(''));
        expect(user.name, equals(''));
      });
    });

    group('Real-World Scenarios', () {
      test('handles typical login response workflow', () {
        // Arrange: Simulate receiving auth response from API
        final authResponseJson = {
          'user': {
            'id': 'insp-12345',
            'name': 'Yanto Prasetyo',
          },
          'accessToken': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
          'refreshToken': 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...',
        };

        // Act: Parse from auth response
        final user = UserData.fromAuthResponse(authResponseJson);

        // Assert: User data extracted correctly
        expect(user.id, equals('insp-12345'));
        expect(user.name, equals('Yanto Prasetyo'));

        // Act: Serialize for storage
        final storedJson = user.toJson();

        // Assert: Can be stored as simpler structure
        expect(storedJson, equals({
          'id': 'insp-12345',
          'name': 'Yanto Prasetyo',
        }));
      });

      test('handles user data persistence workflow', () {
        // Arrange: User data previously stored in local storage
        final storedJson = {
          'id': 'usr-789',
          'name': 'Sinta Wijaya',
        };

        // Act: Restore from storage
        final user = UserData.fromJson(storedJson);

        // Assert: User restored correctly
        expect(user.id, equals('usr-789'));
        expect(user.name, equals('Sinta Wijaya'));
      });

      test('handles UUID-style user ids', () {
        // Arrange: Modern APIs often use UUIDs
        final json = {
          'id': '550e8400-e29b-41d4-a716-446655440000',
          'name': 'Inspector Gadget',
        };

        // Act
        final user = UserData.fromJson(json);

        // Assert
        expect(user.id, equals('550e8400-e29b-41d4-a716-446655440000'));
        expect(user.id.length, equals(36));
      });

      test('handles long Indonesian names', () {
        // Arrange: Some Indonesians have very long names
        final json = {
          'id': 'usr-999',
          'name': 'Raden Mas Adipati Surya Kencana Wijaya Kusuma',
        };

        // Act
        final user = UserData.fromJson(json);

        // Assert
        expect(user.name, contains('Raden Mas'));
        expect(user.name.split(' ').length, greaterThan(5));
      });

      test('dual factory method consistency', () {
        // Arrange: Same data in both formats
        final directJson = {
          'id': 'test-123',
          'name': 'Test User',
        };

        final authResponseJson = {
          'user': {
            'id': 'test-123',
            'name': 'Test User',
          },
        };

        // Act
        final userFromDirect = UserData.fromJson(directJson);
        final userFromAuth = UserData.fromAuthResponse(authResponseJson);

        // Assert: Both methods produce equivalent data
        expect(userFromDirect.id, equals(userFromAuth.id));
        expect(userFromDirect.name, equals(userFromAuth.name));
        expect(userFromDirect.toJson(), equals(userFromAuth.toJson()));
      });
    });
  });
}
