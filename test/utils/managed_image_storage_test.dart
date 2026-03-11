import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:form_app/utils/crashlytics_util.dart';
import 'package:form_app/utils/managed_image_storage.dart';
import 'package:mocktail/mocktail.dart';

class MockCrashlyticsUtil extends Mock implements CrashlyticsUtil {}

class FakeStackTrace extends Fake implements StackTrace {}

void main() {
  late Directory tempDir;
  late MockCrashlyticsUtil mockCrashlytics;

  setUpAll(() {
    registerFallbackValue(FakeStackTrace());
  });

  setUp(() async {
    tempDir = await Directory.systemTemp.createTemp('managed_image_storage_test');
    mockCrashlytics = MockCrashlyticsUtil();

    when(
      () => mockCrashlytics.recordError(
        any(),
        any(),
        reason: any(named: 'reason'),
        fatal: any(named: 'fatal'),
      ),
    ).thenReturn(null);
  });

  tearDown(() async {
    if (await tempDir.exists()) {
      await tempDir.delete(recursive: true);
    }
  });

  group('ManagedImageStorage', () {
    test('deleteSupersededManagedImage deletes old managed generated file', () async {
      final managedDir = await ManagedImageStorage.getManagedImageDirectory(
        documentsDirectory: tempDir,
      );
      await managedDir.create(recursive: true);

      final oldFile = File('${managedDir.path}/old_compressed.jpg');
      final newFile = File('${managedDir.path}/new_compressed.jpg');
      await oldFile.writeAsString('old');
      await newFile.writeAsString('new');

      await ManagedImageStorage.deleteSupersededManagedImage(
        previousPath: oldFile.path,
        nextPath: newFile.path,
        crashlytics: mockCrashlytics,
        reason: 'test cleanup',
        documentsDirectory: tempDir,
      );

      expect(await oldFile.exists(), isFalse);
      expect(await newFile.exists(), isTrue);
    });

    test('deleteSupersededManagedImage does not delete gallery original outside managed directory', () async {
      final managedDir = await ManagedImageStorage.getManagedImageDirectory(
        documentsDirectory: tempDir,
      );
      await managedDir.create(recursive: true);

      final originalFile = File('${tempDir.path}/gallery_original.jpg');
      final newFile = File('${managedDir.path}/new_compressed.jpg');
      await originalFile.writeAsString('original');
      await newFile.writeAsString('new');

      await ManagedImageStorage.deleteSupersededManagedImage(
        previousPath: originalFile.path,
        nextPath: newFile.path,
        crashlytics: mockCrashlytics,
        reason: 'test cleanup',
        documentsDirectory: tempDir,
      );

      expect(await originalFile.exists(), isTrue);
      expect(await newFile.exists(), isTrue);
    });

    test('cleanupOrphanedGeneratedImages deletes only untracked generated files', () async {
      final managedDir = await ManagedImageStorage.getManagedImageDirectory(
        documentsDirectory: tempDir,
      );
      await managedDir.create(recursive: true);

      final trackedFile = File('${managedDir.path}/tracked_compressed.jpg');
      final orphanFile = File('${managedDir.path}/orphan_rotated.jpg');
      await trackedFile.writeAsString('tracked');
      await orphanFile.writeAsString('orphan');

      final wajibDataFile = File('${tempDir.path}/wajib_image_data_list.json');
      final trackedPathForJson = trackedFile.path.replaceAll('\\', '/');
      await wajibDataFile.writeAsString(
        '[{"label":"Tampak Depan","imagePath":"$trackedPathForJson","needAttention":false,"category":"General Wajib","isMandatory":true,"rotationAngle":0,"originalRawPath":"/gallery/original.jpg"}]',
      );

      await ManagedImageStorage.cleanupOrphanedGeneratedImages(
        crashlytics: mockCrashlytics,
        documentsDirectory: tempDir,
      );

      expect(await trackedFile.exists(), isTrue);
      expect(await orphanFile.exists(), isFalse);
    });
  });
}
