import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

// Changed to StateNotifierProvider.family
// The second type argument is List<TambahanImageData> (the state type)
// The third type argument is String (the type of the family parameter, our identifier)
final tambahanImageDataProvider = StateNotifierProvider.family<
    TambahanImageDataListNotifier, List<TambahanImageData>, String>(
  (ref, identifier) {
    return TambahanImageDataListNotifier(identifier); // Pass the identifier to the notifier
  },
);

class TambahanImageDataListNotifier extends StateNotifier<List<TambahanImageData>> {
  // static const _storageKey = 'tambahan_image_data_list'; // Old global key
  final String identifier; // To make storage key unique
  late final String _storageKey; // Instance-specific storage key

  TambahanImageDataListNotifier(this.identifier) : super([]) {
    _storageKey = 'tambahan_image_data_list_$identifier'; // Create unique storage key
    _loadData();
  }

  Future<void> _loadData() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey); // Use instance-specific key
    if (jsonString != null) {
      try {
        final List<dynamic> jsonList = json.decode(jsonString);
        state = jsonList.map((jsonItem) => TambahanImageData.fromJson(jsonItem)).toList();
      } catch (e) {
        // print("Error decoding TambahanImageData for $identifier: $e");
        state = []; // Fallback to empty list on error
      }
    }
  }

  Future<void> _saveData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<Map<String, dynamic>> jsonList = state.map((item) => item.toJson()).toList();
    await prefs.setString(_storageKey, json.encode(jsonList)); // Use instance-specific key
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