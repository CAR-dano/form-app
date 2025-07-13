import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/image_data.dart';
// Import dart:io and path_provider
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

final imageDataListProvider = StateNotifierProvider<ImageDataListNotifier, List<ImageData>>((ref) {
  return ImageDataListNotifier();
});

class ImageDataListNotifier extends StateNotifier<List<ImageData>> {
  // static const _storageKey = 'image_data_list'; // Old key
  static const String _fileName = 'wajib_image_data_list.json'; // Unique filename

  ImageDataListNotifier() : super([]) {
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
          // Use super.state to avoid triggering _saveData during initial load
          super.state = jsonList.map((json) => ImageData.fromJson(json)).toList();
        } else {
          super.state = [];
        }
      } else {
        super.state = [];
      }
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: 'Error loading ImageDataList from file');
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
      FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: 'Error saving ImageDataList to file');
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

  Future<void> clearImageData() async { // Made async
    state = []; // Clear in-memory state
    try {
      final file = await _file;
      if (await file.exists()) {
        await file.delete(); // Delete the persisted file
      }
    } catch (e, stackTrace) {
      FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: 'Error deleting ImageDataList file');
      if (kDebugMode) {
        print("Error deleting ImageDataList file: $e");
      }
    }
    // No need to call _saveImageDataList as we are clearing.
  }
}
