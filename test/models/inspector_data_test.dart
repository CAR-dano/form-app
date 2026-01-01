import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/models/inspector_data.dart';

void main() {
  group('Inspector', () {
    group('fromJson', () {
      test('creates instance from valid JSON', () {
        // Arrange
        final json = {
          'id': 'inspector-123',
          'name': 'John Doe',
        };

        // Act
        final inspector = Inspector.fromJson(json);

        // Assert
        expect(inspector.id, equals('inspector-123'));
        expect(inspector.name, equals('John Doe'));
      });

      test('casts types correctly (String validation)', () {
        // Arrange
        final json = {
          'id': 'inspector-456',
          'name': 'Jane Smith',
        };

        // Act
        final inspector = Inspector.fromJson(json);

        // Assert
        expect(inspector.id, isA<String>());
        expect(inspector.name, isA<String>());
      });

      test('throws when id is missing', () {
        // Arrange
        final json = {
          'name': 'John Doe',
        };

        // Act & Assert
        expect(
          () => Inspector.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when name is missing', () {
        // Arrange
        final json = {
          'id': 'inspector-123',
        };

        // Act & Assert
        expect(
          () => Inspector.fromJson(json),
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
          () => Inspector.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when name is null', () {
        // Arrange
        final json = {
          'id': 'inspector-123',
          'name': null,
        };

        // Act & Assert
        expect(
          () => Inspector.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('handles empty strings', () {
        // Arrange
        final json = {
          'id': '',
          'name': '',
        };

        // Act
        final inspector = Inspector.fromJson(json);

        // Assert
        expect(inspector.id, equals(''));
        expect(inspector.name, equals(''));
      });

      test('handles Indonesian names', () {
        // Arrange
        final json = {
          'id': 'inspector-001',
          'name': 'Budi Santoso',
        };

        // Act
        final inspector = Inspector.fromJson(json);

        // Assert
        expect(inspector.name, equals('Budi Santoso'));
      });

      test('handles names with special characters', () {
        // Arrange
        final json = {
          'id': 'inspector-002',
          'name': 'José María Ñoño-González',
        };

        // Act
        final inspector = Inspector.fromJson(json);

        // Assert
        expect(inspector.name, equals('José María Ñoño-González'));
      });

      test('handles long names', () {
        // Arrange
        final json = {
          'id': 'inspector-003',
          'name': 'Ahmad Dhani Prasetyo Kusuma Wijaya Santoso',
        };

        // Act
        final inspector = Inspector.fromJson(json);

        // Assert
        expect(inspector.name, equals('Ahmad Dhani Prasetyo Kusuma Wijaya Santoso'));
      });
    });

    group('toJson', () {
      test('converts instance to valid JSON', () {
        // Arrange
        final inspector = Inspector(
          id: 'inspector-123',
          name: 'John Doe',
        );

        // Act
        final json = inspector.toJson();

        // Assert
        expect(json, isA<Map<String, dynamic>>());
        expect(json['id'], equals('inspector-123'));
        expect(json['name'], equals('John Doe'));
      });

      test('round-trip: fromJson().toJson() equals original', () {
        // Arrange
        final originalJson = {
          'id': 'inspector-789',
          'name': 'Bob Johnson',
        };

        // Act
        final inspector = Inspector.fromJson(originalJson);
        final resultJson = inspector.toJson();

        // Assert
        expect(resultJson['id'], equals(originalJson['id']));
        expect(resultJson['name'], equals(originalJson['name']));
      });

      test('preserves empty strings in round-trip', () {
        // Arrange
        final originalJson = {
          'id': '',
          'name': '',
        };

        // Act
        final inspector = Inspector.fromJson(originalJson);
        final resultJson = inspector.toJson();

        // Assert
        expect(resultJson['id'], equals(''));
        expect(resultJson['name'], equals(''));
      });

      test('preserves special characters in round-trip', () {
        // Arrange
        final originalJson = {
          'id': 'inspector-123',
          'name': 'José María Ñoño-González',
        };

        // Act
        final inspector = Inspector.fromJson(originalJson);
        final resultJson = inspector.toJson();

        // Assert
        expect(resultJson['name'], equals(originalJson['name']));
      });

      test('preserves Indonesian names in round-trip', () {
        // Arrange
        final originalJson = {
          'id': 'inspector-001',
          'name': 'Siti Nurhaliza binti Abdullah',
        };

        // Act
        final inspector = Inspector.fromJson(originalJson);
        final resultJson = inspector.toJson();

        // Assert
        expect(resultJson['name'], equals(originalJson['name']));
      });
    });

    group('toString', () {
      test('returns the inspector name', () {
        // Arrange
        final inspector = Inspector(
          id: 'inspector-123',
          name: 'John Doe',
        );

        // Act
        final result = inspector.toString();

        // Assert
        expect(result, equals('John Doe'));
      });

      test('returns name without id', () {
        // Arrange
        final inspector = Inspector(
          id: 'inspector-very-long-uuid-12345',
          name: 'Jane',
        );

        // Act
        final result = inspector.toString();

        // Assert
        expect(result, equals('Jane'));
        expect(result, isNot(contains('inspector-very-long-uuid-12345')));
      });

      test('handles empty name', () {
        // Arrange
        final inspector = Inspector(
          id: 'inspector-123',
          name: '',
        );

        // Act
        final result = inspector.toString();

        // Assert
        expect(result, equals(''));
      });

      test('useful for dropdown display', () {
        // Arrange: Simulating dropdown items
        final inspectors = [
          Inspector(id: 'i1', name: 'Ahmad'),
          Inspector(id: 'i2', name: 'Budi'),
          Inspector(id: 'i3', name: 'Citra'),
        ];

        // Act: Get display strings
        final displayNames = inspectors.map((i) => i.toString()).toList();

        // Assert
        expect(displayNames, equals(['Ahmad', 'Budi', 'Citra']));
      });
    });

    group('Constructor', () {
      test('creates instance with required parameters', () {
        // Act
        final inspector = Inspector(
          id: 'inspector-123',
          name: 'John Doe',
        );

        // Assert
        expect(inspector.id, equals('inspector-123'));
        expect(inspector.name, equals('John Doe'));
      });

      test('stores values correctly', () {
        // Act
        final inspector = Inspector(
          id: 'test-id',
          name: 'Test Name',
        );

        // Assert
        expect(inspector.id, isNotNull);
        expect(inspector.name, isNotNull);
      });
    });

    group('Equality', () {
      test('two inspectors with same id are equal', () {
        // Arrange
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-123', name: 'John Doe');

        // Assert
        expect(inspector1, equals(inspector2));
        expect(inspector1 == inspector2, isTrue);
      });

      test('two inspectors with different id are not equal', () {
        // Arrange
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-456', name: 'John Doe');

        // Assert
        expect(inspector1, isNot(equals(inspector2)));
        expect(inspector1 == inspector2, isFalse);
      });

      test('equality ignores name differences (id-based)', () {
        // Arrange: Same id, different name
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-123', name: 'Jane Smith');

        // Assert: Should be equal because id is the same
        expect(inspector1, equals(inspector2));
        expect(inspector1 == inspector2, isTrue);
      });

      test('identical instances are equal', () {
        // Arrange
        final inspector = Inspector(id: 'inspector-123', name: 'John Doe');

        // Assert
        expect(inspector, equals(inspector));
        expect(inspector == inspector, isTrue);
      });

      test('equality with nullable inspector', () {
        // Arrange
        final inspector = Inspector(id: 'inspector-123', name: 'John Doe');
        Inspector? nullableInspector;

        // Assert
        expect(inspector == nullableInspector, isFalse);
      });

      test('equality with different type returns false', () {
        // Arrange
        final inspector = Inspector(id: 'inspector-123', name: 'John Doe');
        final dynamic notAnInspector = 'inspector-123';

        // Assert
        expect(inspector == notAnInspector, isFalse);
      });
    });

    group('HashCode', () {
      test('hashCode matches for equal inspectors', () {
        // Arrange
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-123', name: 'John Doe');

        // Assert
        expect(inspector1.hashCode, equals(inspector2.hashCode));
      });

      test('hashCode matches for same id different name', () {
        // Arrange: Same id should produce same hashCode
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-123', name: 'Jane Smith');

        // Assert
        expect(inspector1.hashCode, equals(inspector2.hashCode));
      });

      test('hashCode differs for different ids', () {
        // Arrange
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-456', name: 'John Doe');

        // Assert
        expect(inspector1.hashCode, isNot(equals(inspector2.hashCode)));
      });

      test('hashCode is consistent across multiple calls', () {
        // Arrange
        final inspector = Inspector(id: 'inspector-123', name: 'John Doe');

        // Act
        final hashCode1 = inspector.hashCode;
        final hashCode2 = inspector.hashCode;
        final hashCode3 = inspector.hashCode;

        // Assert
        expect(hashCode1, equals(hashCode2));
        expect(hashCode2, equals(hashCode3));
      });

      test('hashCode is based on id only', () {
        // Arrange
        final inspector = Inspector(id: 'unique-id', name: 'John Doe');
        
        // Act
        final hashCode = inspector.hashCode;
        final idHashCode = 'unique-id'.hashCode;

        // Assert: hashCode should equal id's hashCode
        expect(hashCode, equals(idHashCode));
      });
    });

    group('Collection Behavior', () {
      test('can be used in Set based on equality', () {
        // Arrange
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector3 = Inspector(id: 'inspector-456', name: 'Jane Smith');

        // Act
        final set = {inspector1, inspector2, inspector3};

        // Assert: inspector1 and inspector2 are equal, so set should have 2 items
        expect(set.length, equals(2));
        expect(set.contains(inspector1), isTrue);
        expect(set.contains(inspector2), isTrue);
        expect(set.contains(inspector3), isTrue);
      });

      test('can be used in Map as key', () {
        // Arrange
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-123', name: 'John Doe');
        
        // Act
        final map = <Inspector, String>{};
        map[inspector1] = 'first';
        map[inspector2] = 'second';

        // Assert: inspector1 and inspector2 are equal, so map should have 1 entry
        expect(map.length, equals(1));
        expect(map[inspector1], equals('second')); // Overwritten
        expect(map[inspector2], equals('second'));
      });

      test('can be found in List using contains', () {
        // Arrange
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-123', name: 'Jane Smith');
        final list = [inspector1];

        // Act & Assert: inspector2 has same id, so should be found
        expect(list.contains(inspector2), isTrue);
      });

      test('can be removed from List by equal object', () {
        // Arrange
        final inspector1 = Inspector(id: 'inspector-123', name: 'John Doe');
        final inspector2 = Inspector(id: 'inspector-123', name: 'Different Name');
        final list = [inspector1];

        // Act
        final removed = list.remove(inspector2);

        // Assert: Should remove inspector1 because inspector2 is equal (same id)
        expect(removed, isTrue);
        expect(list.isEmpty, isTrue);
      });
    });

    group('Real-World Scenarios', () {
      test('handles typical API response for inspectors', () {
        // Arrange: Typical API response
        final jsonList = [
          {'id': 'inspector-001', 'name': 'Ahmad Yani'},
          {'id': 'inspector-002', 'name': 'Budi Santoso'},
          {'id': 'inspector-003', 'name': 'Citra Dewi'},
        ];

        // Act
        final inspectors = jsonList.map((json) => Inspector.fromJson(json)).toList();

        // Assert
        expect(inspectors.length, equals(3));
        expect(inspectors[0].name, equals('Ahmad Yani'));
        expect(inspectors[1].name, equals('Budi Santoso'));
        expect(inspectors[2].name, equals('Citra Dewi'));
      });

      test('can be used in dropdown selection', () {
        // Arrange: Simulating user selecting from dropdown
        final availableInspectors = [
          Inspector(id: 'i1', name: 'Ahmad'),
          Inspector(id: 'i2', name: 'Budi'),
          Inspector(id: 'i3', name: 'Citra'),
        ];
        
        // Act: User selects Ahmad
        final selectedInspector = Inspector(id: 'i1', name: 'Ahmad');
        
        // Assert: Can find selected inspector in available list
        expect(availableInspectors.contains(selectedInspector), isTrue);
        final index = availableInspectors.indexOf(selectedInspector);
        expect(index, equals(0));
        expect(availableInspectors[index].name, equals('Ahmad'));
      });

      test('handles UUID-style ids', () {
        // Arrange: More realistic UUID format
        final json = {
          'id': '550e8400-e29b-41d4-a716-446655440000',
          'name': 'John Doe',
        };

        // Act
        final inspector = Inspector.fromJson(json);

        // Assert
        expect(inspector.id, equals('550e8400-e29b-41d4-a716-446655440000'));
        expect(inspector.id.length, equals(36)); // UUID length
      });

      test('handles common Indonesian naming patterns', () {
        // Arrange: Various Indonesian name formats
        final names = [
          'Ahmad Dhani',
          'Siti Nurhaliza',
          'Bambang Pamungkas',
          'Dewi Lestari S.',
          'Dr. H. Muhammad Ridwan, S.H., M.H.',
        ];

        for (final name in names) {
          final json = {
            'id': 'inspector-${name.hashCode}',
            'name': name,
          };

          // Act
          final inspector = Inspector.fromJson(json);

          // Assert
          expect(inspector.name, equals(name));
          expect(inspector.toString(), equals(name));
        }
      });

      test('supports nested in AuthResponse', () {
        // Arrange: This is how Inspector is typically used
        final json = {
          'id': 'inspector-123',
          'name': 'John Doe',
        };

        // Act
        final inspector = Inspector.fromJson(json);
        final serialized = inspector.toJson();

        // Assert: Can be serialized and used in AuthResponse
        expect(serialized['id'], equals('inspector-123'));
        expect(serialized['name'], equals('John Doe'));
      });
    });
  });
}
