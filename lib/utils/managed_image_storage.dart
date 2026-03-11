import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:form_app/utils/crashlytics_util.dart';

class ManagedImageStorage {
  static const String _managedDirectoryName = 'tambahan_images';
  static const String _wajibImageDataFileName = 'wajib_image_data_list.json';
  static const String _tambahanImageDataPrefix = 'tambahan_image_data_';
  static const String _jsonSuffix = '.json';

  static Future<Directory> getManagedImageDirectory({
    Directory? documentsDirectory,
  }) async {
    final directory = documentsDirectory ??
        await getApplicationDocumentsDirectory();
    return Directory('${directory.path}/$_managedDirectoryName');
  }

  static Future<void> deleteSupersededManagedImage({
    required String previousPath,
    required String nextPath,
    required CrashlyticsUtil crashlytics,
    required String reason,
    Directory? documentsDirectory,
  }) async {
    if (previousPath.isEmpty || previousPath == nextPath) {
      return;
    }

    await deleteManagedGeneratedImageIfExists(
      previousPath,
      crashlytics: crashlytics,
      reason: reason,
      documentsDirectory: documentsDirectory,
    );
  }

  static Future<void> deleteManagedGeneratedImageIfExists(
    String path, {
    required CrashlyticsUtil crashlytics,
    required String reason,
    Directory? documentsDirectory,
  }) async {
    if (path.isEmpty) {
      return;
    }

    try {
      if (!await isManagedGeneratedImagePath(
        path,
        documentsDirectory: documentsDirectory,
      )) {
        return;
      }

      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        debugPrint('ManagedImageStorage: Deleted generated image file: $path');
      }
    } catch (e, stackTrace) {
      crashlytics.recordError(e, stackTrace, reason: reason);
    }
  }

  static Future<bool> isManagedGeneratedImagePath(
    String path, {
    Directory? documentsDirectory,
  }) async {
    if (path.isEmpty) {
      return false;
    }

    final managedDir = await getManagedImageDirectory(
      documentsDirectory: documentsDirectory,
    );
    final List<String> managedSegments = managedDir.absolute.path
        .split(RegExp(r'[\\/]'))
        .where((segment) => segment.isNotEmpty)
        .toList();
    final List<String> pathSegments = File(path).absolute.path
        .split(RegExp(r'[\\/]'))
        .where((segment) => segment.isNotEmpty)
        .toList();

    if (pathSegments.length < managedSegments.length) {
      return false;
    }

    final String expectedManagedTail = managedSegments.last;
    return pathSegments.contains(expectedManagedTail);
  }

  static Future<void> cleanupOrphanedGeneratedImages({
    required CrashlyticsUtil crashlytics,
    Directory? documentsDirectory,
  }) async {
    try {
      final managedDir = await getManagedImageDirectory(
        documentsDirectory: documentsDirectory,
      );
      if (!await managedDir.exists()) {
        return;
      }

      final trackedPaths = await _loadTrackedManagedImagePaths(
        documentsDirectory: documentsDirectory,
      );
      final List<File> managedFiles = await managedDir
          .list(followLinks: false)
          .where((entity) => entity is File)
          .cast<File>()
          .toList();

      for (final entity in managedFiles) {
        final entityPath = _normalizePath(entity.path);
        if (!trackedPaths.contains(entityPath)) {
          debugPrint('ManagedImageStorage: Deleting orphaned generated image: ${entity.path}');
          await entity.delete();
        }
      }
    } catch (e, stackTrace) {
      crashlytics.recordError(
        e,
        stackTrace,
        reason: 'Error cleaning orphaned generated images',
      );
    }
  }

  static Future<Set<String>> _loadTrackedManagedImagePaths({
    Directory? documentsDirectory,
  }) async {
    final documentsDir = documentsDirectory ??
        await getApplicationDocumentsDirectory();
    final Set<String> trackedPaths = <String>{};

    Future<void> collectFromFile(File file) async {
      if (!await file.exists()) {
        return;
      }

      final String raw = await file.readAsString();
      if (raw.trim().isEmpty) {
        return;
      }

      final dynamic decoded = json.decode(raw);
      if (decoded is! List) {
        return;
      }

      for (final dynamic item in decoded) {
        if (item is! Map) {
          continue;
        }

        final Map<String, dynamic> normalizedItem =
            item.map((key, value) => MapEntry(key.toString(), value));

        final dynamic imagePath = normalizedItem['imagePath'];
        if (imagePath is! String || imagePath.isEmpty) {
          continue;
        }

        if (await isManagedGeneratedImagePath(
          imagePath,
          documentsDirectory: documentsDir,
        )) {
          trackedPaths.add(_normalizePath(imagePath));
        }
      }
    }

    await collectFromFile(File('${documentsDir.path}/$_wajibImageDataFileName'));

    await for (final entity in documentsDir.list(followLinks: false)) {
      if (entity is! File) {
        continue;
      }

      final fileName = entity.uri.pathSegments.isNotEmpty
          ? entity.uri.pathSegments.last
          : entity.path.split(Platform.pathSeparator).last;
      final bool isTambahanDataFile = fileName.startsWith(_tambahanImageDataPrefix) &&
          fileName.endsWith(_jsonSuffix);
      if (isTambahanDataFile) {
        await collectFromFile(entity);
      }
    }

    return trackedPaths;
  }

  static String _normalizePath(String path) {
    final String normalized = File(path).absolute.path.replaceAll('\\', '/');
    return Platform.isWindows ? normalized.toLowerCase() : normalized;
  }
}
