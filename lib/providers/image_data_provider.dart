import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/image_data.dart';
import 'package:form_app/utils/crashlytics_util.dart'; // Import CrashlyticsUtil
// Import dart:io and path_provider
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

final imageDataListProvider = StateNotifierProvider<ImageDataListNotifier, List<ImageData>>((ref) {
  final crashlytics = ref.watch(crashlyticsUtilProvider); // Get CrashlyticsUtil instance
  return ImageDataListNotifier(crashlytics);
});

class ImageDataListNotifier extends StateNotifier<List<ImageData>> {
  final CrashlyticsUtil _crashlytics; // Add CrashlyticsUtil dependency
  // static const _storageKey = 'image_data_list'; // Old key
  static const String _fileName = 'wajib_image_data_list.json'; // Unique filename

  ImageDataListNotifier(this._crashlytics) : super([]) {
    _loadImageDataList();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _file async {
    final path = await _localPath;
    return File('$path/$_fileName');
  }

  Future<void> _loadImageDataList() async {
    try {
      final file = await _file;
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        if (jsonString.isNotEmpty) {
          final List<dynamic> jsonList = json.decode(jsonString);
          final loadedState = jsonList.map((json) => ImageData.fromJson(json)).toList();

          // Migration logic: Check for old cache paths and clear if found
          if (loadedState.any((img) => img.imagePath.contains('/cache/'))) {
            if (kDebugMode) {
              print("Old cache paths detected in wajib_image_data_list. Clearing for a fresh start.");
            }
            // This will clear the state and delete the invalid JSON file.
            // The old image files in cache will be cleared by the OS eventually.
            await clearImageData();
          } else {
            super.state = loadedState;
          }
        } else {
          super.state = [];
        }
      } else {
        super.state = [];
      }
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error loading ImageDataList from file');
      if (kDebugMode) {
        print("Error loading ImageDataList from file: $e");
      }
      super.state = [];
    }
  }

  Future<void> _saveImageDataList() async {
    try {
      final file = await _file;
      final jsonList = state.map((image) => image.toJson()).toList();
      final jsonString = json.encode(jsonList);
      await file.writeAsString(jsonString, flush: true); // Ensure data is flushed to disk
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error saving ImageDataList to file');
      if (kDebugMode) {
        print("Error saving ImageDataList to file: $e");
      }
    }
  }

  @override
  set state(List<ImageData> value) {
    super.state = value;
    _saveImageDataList();
  }

  void addImageData(ImageData imageData) {
    // The 'state' setter will automatically call _saveImageDataList
    state = [...state, imageData];
  }

  void updateImageDataByLabel(String label, {String? imagePath, int? rotationAngle, String? originalRawPath}) {
    state = [
      for (final img in state)
        if (img.label == label)
          img.copyWith(
            imagePath: imagePath,
            rotationAngle: rotationAngle,
            originalRawPath: originalRawPath,
          )
        else
          img,
    ];
  }

  void updateImageDataByPath(String imagePath, {String? label, bool? needAttention, String? category, bool? isMandatory, int? rotationAngle, String? originalRawPath}) {
    state = [
      for (final img in state)
        if (img.imagePath == imagePath)
          img.copyWith(
            label: label,
            needAttention: needAttention,
            category: category,
            isMandatory: isMandatory,
            rotationAngle: rotationAngle,
            originalRawPath: originalRawPath,
          )
        else
          img,
    ];
  }

  void removeImageDataByLabel(String label) {
    state = state.where((img) => img.label != label).toList();
    // The 'state' setter handles saving
  }

  Future<void> clearImageData() async {
    // Get all paths before clearing the state
    final pathsToDelete = state
        .map((img) => img.imagePath)
        .where((path) => path.isNotEmpty)
        .toList();

    state = []; // Clear in-memory state

    // Delete the JSON database file
    try {
      final file = await _file;
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error deleting ImageDataList file');
      if (kDebugMode) {
        print("Error deleting ImageDataList file: $e");
      }
    }

    // Delete all associated image files
    for (final path in pathsToDelete) {
      try {
        final fileToDelete = File(path);
        if (await fileToDelete.exists()) {
          await fileToDelete.delete();
        }
      } catch (e, stackTrace) {
        _crashlytics.recordError(e, stackTrace, reason: 'Error deleting image file during clear');
        // Continue trying to delete other files
      }
    }
  }
}
