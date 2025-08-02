import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:form_app/utils/crashlytics_util.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

final tambahanImageDataProvider = StateNotifierProvider.family<
    TambahanImageDataListNotifier, List<TambahanImageData>, String>(
  (ref, identifier) {
    final crashlytics = ref.watch(crashlyticsUtilProvider);
    return TambahanImageDataListNotifier(identifier, crashlytics);
  },
);

class TambahanImageDataListNotifier extends StateNotifier<List<TambahanImageData>> {
  final String identifier;
  final CrashlyticsUtil _crashlytics;

  TambahanImageDataListNotifier(this.identifier, this._crashlytics) : super([]) {
    _loadData();
  }

  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  // Corrected getter definition:
  // 1. Use the 'get' keyword.
  // 2. Renamed to '_file' for clarity and to avoid previous naming confusion.
  Future<File> get _file async {
    final path = await _localPath;
    return File('$path/tambahan_image_data_$identifier.json');
  }

  Future<void> _loadData() async {
    try {
      final file = await _file;
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = json.decode(jsonString);
        final loadedState = jsonList.map((jsonItem) => TambahanImageData.fromJson(jsonItem)).toList();

        // Migration logic: Check for old cache paths
        if (loadedState.any((img) => img.imagePath.contains('/cache/'))) {
          if (kDebugMode) {
            print("Old cache paths detected in $identifier. Clearing for a fresh start.");
          }
          // Clear the invalid state to prevent errors.
          await clearAll();
        } else {
          state = loadedState;
        }
      }
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error loading TambahanImageData for $identifier from file');
      state = [];
    }
  }

  Future<void> _saveData() async {
    try {
      // Correctly await the getter '_file'
      final file = await _file;
      final List<Map<String, dynamic>> jsonList = state.map((item) => item.toJson()).toList();
      await file.writeAsString(json.encode(jsonList), flush: true); // Ensure data is flushed to disk
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error saving TambahanImageData for $identifier to file');
    }
  }

  void addImage(TambahanImageData image) {
    state = [...state, image];
    _saveData();
  }

  void updateImageAtIndex(int index, TambahanImageData newImage) {
    if (index >= 0 && index < state.length) {
      final updatedList = List<TambahanImageData>.from(state);
      updatedList[index] = newImage;
      state = updatedList;
      _saveData();
    }
  }

  Future<void> removeImageAtIndex(int index) async {
    if (index >= 0 && index < state.length) {
      final imagePath = state[index].imagePath;

      final updatedList = List<TambahanImageData>.from(state);
      updatedList.removeAt(index);
      state = updatedList;
      await _saveData();

      // Delete the associated file
      await _deleteFile(imagePath);
    }
  }

  Future<void> clearAll() async {
    // Get all paths before clearing the state
    final pathsToDelete = state.map((img) => img.imagePath).toList();
    
    state = [];
    
    // Delete the JSON file
    try {
      final file = await _file;
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error deleting TambahanImageData file for $identifier');
    }

    // Delete all associated image files
    for (final path in pathsToDelete) {
      await _deleteFile(path);
    }
  }

  Future<void> _deleteFile(String path) async {
    try {
      final file = File(path);
      if (await file.exists()) {
        await file.delete();
        if (kDebugMode) {
          print("Deleted image file: $path");
        }
      }
    } catch (e, stackTrace) {
      _crashlytics.recordError(e, stackTrace, reason: 'Error deleting image file');
    }
  }
}