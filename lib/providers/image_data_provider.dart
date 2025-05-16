import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/image_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Define a StateNotifierProvider for managing a list of ImageData
final imageDataListProvider = StateNotifierProvider<ImageDataListNotifier, List<ImageData>>((ref) {
  return ImageDataListNotifier();
});

// Define the StateNotifier to manage the list of ImageData
class ImageDataListNotifier extends StateNotifier<List<ImageData>> {
  static const _storageKey = 'image_data_list';

  ImageDataListNotifier() : super([]) {
    _loadImageDataList();
  }

  // Method to add new ImageData
  void addImageData(ImageData imageData) {
    state = [...state, imageData];
  }

  // Method to load image data list from SharedPreferences
  Future<void> _loadImageDataList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      final List<dynamic> jsonList = json.decode(jsonString);
      state = jsonList.map((json) => ImageData.fromJson(json)).toList();
    }
  }

  // Method to save image data list to SharedPreferences
  Future<void> _saveImageDataList() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonList = state.map((image) => image.toJson()).toList();
    final jsonString = json.encode(jsonList);
    await prefs.setString(_storageKey, jsonString);
  }

  @override
  set state(List<ImageData> value) {
    super.state = value;
    _saveImageDataList();
  }

  // Method to update existing ImageData by label
  void updateImageDataByLabel(String label, {String? imagePath, String? formId}) {
    state = [
      for (final img in state)
        if (img.label == label)
          ImageData(
            label: img.label,
            imagePath: imagePath ?? img.imagePath,
            formId: formId ?? img.formId,
          )
        else
          img,
    ];
  }

  // Method to remove ImageData by label
  void removeImageDataByLabel(String label) {
    state = state.where((img) => img.label != label).toList();
  }

  // Method to clear all ImageData
  void clearImageData() {
    state = [];
  }
}
