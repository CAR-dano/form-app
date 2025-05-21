import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/tambahan_image_data.dart';
// Import dart:io for File operations
import 'dart:io';
// Import path_provider to get documents directory
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

final tambahanImageDataProvider = StateNotifierProvider.family<
    TambahanImageDataListNotifier, List<TambahanImageData>, String>(
  (ref, identifier) {
    return TambahanImageDataListNotifier(identifier);
  },
);

class TambahanImageDataListNotifier extends StateNotifier<List<TambahanImageData>> {
  final String identifier;

  TambahanImageDataListNotifier(this.identifier) : super([]) {
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
      // Correctly await the getter '_file'
      final file = await _file;
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> jsonList = json.decode(jsonString);
        state = jsonList.map((jsonItem) => TambahanImageData.fromJson(jsonItem)).toList();
      }
    } catch (e) {
      // print("Error loading TambahanImageData for $identifier from file: $e");
      state = [];
    }
  }

  Future<void> _saveData() async {
    try {
      // Correctly await the getter '_file'
      final file = await _file;
      final List<Map<String, dynamic>> jsonList = state.map((item) => item.toJson()).toList();
      await file.writeAsString(json.encode(jsonList));
    } catch (e) {
      // print("Error saving TambahanImageData for $identifier to file: $e");
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

  void removeImageAtIndex(int index) {
    if (index >= 0 && index < state.length) {
      final updatedList = List<TambahanImageData>.from(state);
      updatedList.removeAt(index);
      state = updatedList;
      _saveData();
    }
  }

  Future<void> clearAll() async {
    state = [];
    try {
      // Correctly await the getter '_file'
      final file = await _file;
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      // print("Error deleting TambahanImageData file for $identifier: $e");
    }
  }
}