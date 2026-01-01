import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/models/inspection_branch.dart';

void main() {
  group('InspectionBranch', () {
    group('fromJson', () {
      test('creates instance from valid JSON', () {
        // Arrange
        final json = {
          'id': 'branch-123',
          'city': 'Jakarta',
        };

        // Act
        final branch = InspectionBranch.fromJson(json);

        // Assert
        expect(branch.id, equals('branch-123'));
        expect(branch.city, equals('Jakarta'));
      });

      test('handles all Indonesian cities', () {
        // Arrange
        final cities = [
          'Jakarta',
          'Surabaya',
          'Bandung',
          'Medan',
          'Semarang',
          'Palembang',
          'Makassar',
          'Yogyakarta',
        ];

        for (final city in cities) {
          final json = {
            'id': 'branch-${city.toLowerCase()}',
            'city': city,
          };

          // Act
          final branch = InspectionBranch.fromJson(json);

          // Assert
          expect(branch.city, equals(city));
        }
      });

      test('casts types correctly (String validation)', () {
        // Arrange
        final json = {
          'id': 'branch-456',
          'city': 'Surabaya',
        };

        // Act
        final branch = InspectionBranch.fromJson(json);

        // Assert
        expect(branch.id, isA<String>());
        expect(branch.city, isA<String>());
      });

      test('throws when id is missing', () {
        // Arrange
        final json = {
          'city': 'Jakarta',
        };

        // Act & Assert
        expect(
          () => InspectionBranch.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when city is missing', () {
        // Arrange
        final json = {
          'id': 'branch-123',
        };

        // Act & Assert
        expect(
          () => InspectionBranch.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when id is null', () {
        // Arrange
        final json = {
          'id': null,
          'city': 'Jakarta',
        };

        // Act & Assert
        expect(
          () => InspectionBranch.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('throws when city is null', () {
        // Arrange
        final json = {
          'id': 'branch-123',
          'city': null,
        };

        // Act & Assert
        expect(
          () => InspectionBranch.fromJson(json),
          throwsA(isA<TypeError>()),
        );
      });

      test('handles empty strings', () {
        // Arrange
        final json = {
          'id': '',
          'city': '',
        };

        // Act
        final branch = InspectionBranch.fromJson(json);

        // Assert
        expect(branch.id, equals(''));
        expect(branch.city, equals(''));
      });

      test('handles city names with spaces', () {
        // Arrange
        final json = {
          'id': 'branch-001',
          'city': 'Kota Bandung',
        };

        // Act
        final branch = InspectionBranch.fromJson(json);

        // Assert
        expect(branch.city, equals('Kota Bandung'));
      });

      test('handles city names with special characters', () {
        // Arrange
        final json = {
          'id': 'branch-002',
          'city': 'D.I. Yogyakarta',
        };

        // Act
        final branch = InspectionBranch.fromJson(json);

        // Assert
        expect(branch.city, equals('D.I. Yogyakarta'));
      });
    });

    group('Constructor', () {
      test('creates instance with required parameters', () {
        // Act
        final branch = InspectionBranch(
          id: 'branch-123',
          city: 'Jakarta',
        );

        // Assert
        expect(branch.id, equals('branch-123'));
        expect(branch.city, equals('Jakarta'));
      });

      test('stores values correctly', () {
        // Act
        final branch = InspectionBranch(
          id: 'test-id',
          city: 'Test City',
        );

        // Assert
        expect(branch.id, isNotNull);
        expect(branch.city, isNotNull);
      });
    });

    group('Equality', () {
      test('two branches with same id are equal', () {
        // Arrange
        final branch1 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch2 = InspectionBranch(id: 'branch-123', city: 'Jakarta');

        // Assert
        expect(branch1, equals(branch2));
        expect(branch1 == branch2, isTrue);
      });

      test('two branches with different id are not equal', () {
        // Arrange
        final branch1 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch2 = InspectionBranch(id: 'branch-456', city: 'Jakarta');

        // Assert
        expect(branch1, isNot(equals(branch2)));
        expect(branch1 == branch2, isFalse);
      });

      test('equality ignores city differences (id-based)', () {
        // Arrange: Same id, different city
        final branch1 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch2 = InspectionBranch(id: 'branch-123', city: 'Surabaya');

        // Assert: Should be equal because id is the same
        expect(branch1, equals(branch2));
        expect(branch1 == branch2, isTrue);
      });

      test('identical instances are equal', () {
        // Arrange
        final branch = InspectionBranch(id: 'branch-123', city: 'Jakarta');

        // Assert
        expect(branch, equals(branch));
        expect(branch == branch, isTrue);
      });

      test('equality with nullable branch', () {
        // Arrange
        final branch = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        InspectionBranch? nullableBranch;

        // Assert
        expect(branch == nullableBranch, isFalse);
      });

      test('equality with different type returns false', () {
        // Arrange
        final branch = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final dynamic notABranch = 'branch-123';

        // Assert
        expect(branch == notABranch, isFalse);
      });
    });

    group('HashCode', () {
      test('hashCode matches for equal branches', () {
        // Arrange
        final branch1 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch2 = InspectionBranch(id: 'branch-123', city: 'Jakarta');

        // Assert
        expect(branch1.hashCode, equals(branch2.hashCode));
      });

      test('hashCode matches for same id different city', () {
        // Arrange: Same id should produce same hashCode
        final branch1 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch2 = InspectionBranch(id: 'branch-123', city: 'Surabaya');

        // Assert
        expect(branch1.hashCode, equals(branch2.hashCode));
      });

      test('hashCode differs for different ids', () {
        // Arrange
        final branch1 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch2 = InspectionBranch(id: 'branch-456', city: 'Jakarta');

        // Assert
        expect(branch1.hashCode, isNot(equals(branch2.hashCode)));
      });

      test('hashCode is consistent across multiple calls', () {
        // Arrange
        final branch = InspectionBranch(id: 'branch-123', city: 'Jakarta');

        // Act
        final hashCode1 = branch.hashCode;
        final hashCode2 = branch.hashCode;
        final hashCode3 = branch.hashCode;

        // Assert
        expect(hashCode1, equals(hashCode2));
        expect(hashCode2, equals(hashCode3));
      });

      test('hashCode is based on id only', () {
        // Arrange
        final branch = InspectionBranch(id: 'unique-id', city: 'Jakarta');
        
        // Act
        final hashCode = branch.hashCode;
        final idHashCode = 'unique-id'.hashCode;

        // Assert: hashCode should equal id's hashCode
        expect(hashCode, equals(idHashCode));
      });
    });

    group('Collection Behavior', () {
      test('can be used in Set based on equality', () {
        // Arrange
        final branch1 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch2 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch3 = InspectionBranch(id: 'branch-456', city: 'Surabaya');

        // Act
        final set = {branch1, branch2, branch3};

        // Assert: branch1 and branch2 are equal, so set should have 2 items
        expect(set.length, equals(2));
        expect(set.contains(branch1), isTrue);
        expect(set.contains(branch2), isTrue);
        expect(set.contains(branch3), isTrue);
      });

      test('can be used in Map as key', () {
        // Arrange
        final branch1 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch2 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        
        // Act
        final map = <InspectionBranch, String>{};
        map[branch1] = 'first';
        map[branch2] = 'second';

        // Assert: branch1 and branch2 are equal, so map should have 1 entry
        expect(map.length, equals(1));
        expect(map[branch1], equals('second')); // Overwritten
        expect(map[branch2], equals('second'));
      });

      test('can be found in List using contains', () {
        // Arrange
        final branch1 = InspectionBranch(id: 'branch-123', city: 'Jakarta');
        final branch2 = InspectionBranch(id: 'branch-123', city: 'Surabaya');
        final list = [branch1];

        // Act & Assert: branch2 has same id, so should be found
        expect(list.contains(branch2), isTrue);
      });
    });

    group('Real-World Scenarios', () {
      test('handles typical API response for inspection branches', () {
        // Arrange: Typical API response
        final jsonList = [
          {'id': 'branch-jkt-001', 'city': 'Jakarta'},
          {'id': 'branch-sby-001', 'city': 'Surabaya'},
          {'id': 'branch-bdg-001', 'city': 'Bandung'},
        ];

        // Act
        final branches = jsonList.map((json) => InspectionBranch.fromJson(json)).toList();

        // Assert
        expect(branches.length, equals(3));
        expect(branches[0].city, equals('Jakarta'));
        expect(branches[1].city, equals('Surabaya'));
        expect(branches[2].city, equals('Bandung'));
      });

      test('can be used in dropdown selection', () {
        // Arrange: Simulating user selecting from dropdown
        final availableBranches = [
          InspectionBranch(id: 'branch-1', city: 'Jakarta'),
          InspectionBranch(id: 'branch-2', city: 'Surabaya'),
          InspectionBranch(id: 'branch-3', city: 'Bandung'),
        ];
        
        // Act: User selects Jakarta branch
        final selectedBranch = InspectionBranch(id: 'branch-1', city: 'Jakarta');
        
        // Assert: Can find selected branch in available list
        expect(availableBranches.contains(selectedBranch), isTrue);
        final index = availableBranches.indexOf(selectedBranch);
        expect(index, equals(0));
        expect(availableBranches[index].city, equals('Jakarta'));
      });

      test('handles UUID-style ids', () {
        // Arrange: More realistic UUID format
        final json = {
          'id': '550e8400-e29b-41d4-a716-446655440000',
          'city': 'Jakarta Pusat',
        };

        // Act
        final branch = InspectionBranch.fromJson(json);

        // Assert
        expect(branch.id, equals('550e8400-e29b-41d4-a716-446655440000'));
        expect(branch.id.length, equals(36)); // UUID length
      });

      test('handles Indonesian city names with regions', () {
        // Arrange: Cities with region specifiers
        final cities = [
          'Jakarta Selatan',
          'Jakarta Pusat',
          'Jakarta Timur',
          'Jakarta Barat',
          'Jakarta Utara',
        ];

        for (final city in cities) {
          final json = {
            'id': 'branch-${city.toLowerCase().replaceAll(' ', '-')}',
            'city': city,
          };

          // Act
          final branch = InspectionBranch.fromJson(json);

          // Assert
          expect(branch.city, equals(city));
        }
      });
    });
  });
}
