import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

final tambahanImageDataProvider =
    StateNotifierProvider<TambahanImageDataListNotifier, List<TambahanImageData>>((ref) {
  return TambahanImageDataListNotifier();
});

class TambahanImageDataListNotifier extends StateNotifier<List<TambahanImageData>> {
  static const _storageKey = 'tambahan_image_data_list';

  TambahanImageDataListNotifier() : super([]) {
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);
    if (jsonString != null) {
      try {
        final List<dynamic> jsonList = json.decode(jsonString);
        state = jsonList.map((jsonItem) => TambahanImageData.fromJson(jsonItem)).toList();
      } catch (e) {
        // print("Error decoding TambahanImageData: $e");
        state = []; // Fallback to empty list on error
      }
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList = state.map((item) => item.toJson()).toList();
    await prefs.setString(_storageKey, json.encode(jsonList));
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

  void clearAll() {
    state = [];
    _saveData();
  }
}