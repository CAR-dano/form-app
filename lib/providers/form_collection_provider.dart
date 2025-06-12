import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:convert';
import 'package:flutter/foundation.dart';

final formCollectionProvider = StateNotifierProvider<FormCollectionNotifier, Map<String, FormData>>((ref) {
  return FormCollectionNotifier();
});

class FormCollectionNotifier extends StateNotifier<Map<String, FormData>> {
  static const _indexFileName = 'form_index.json';
  static const _fileNamePrefix = 'form_data_';
  static const _fileExtension = '.json';

  FormCollectionNotifier() : super({}) {
    _loadFormIndex().then((_) {
      _loadAllForms();
    });
  }

  Future<String> _getIndexFilePath() async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_indexFileName';
  }

  Future<String> _getFormFilePath(String identifier) async {
    final directory = await getApplicationDocumentsDirectory();
    return '${directory.path}/$_fileNamePrefix$identifier$_fileExtension';
  }

  Future<void> _loadFormIndex() async {
    try {
      final filePath = await _getIndexFilePath();
      final file = File(filePath);
      if (await file.exists()) {
        final jsonString = await file.readAsString();
        final List<dynamic> identifiers = json.decode(jsonString);
        // Initialize state with null FormData for each identifier; will be populated later
        final initialState = Map<String, FormData?>.fromEntries(
          identifiers.map((id) => MapEntry(id.toString(), null))
        );
        state = initialState.cast<String, FormData>(); // Cast to Map<String, FormData>
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error loading form index: $e');
      }
    }
  }

  Future<void> _loadAllForms() async {
    try {
      final Map<String, FormData> loadedForms = {};
      for (final identifier in state.keys) { // Iterate over existing keys
        final filePath = await _getFormFilePath(identifier);
        final file = File(filePath);
        if (await file.exists()) {
          final jsonString = await file.readAsString();
          final jsonMap = json.decode(jsonString);
          final loadedFormData = FormData.fromJson(jsonMap);
          loadedForms[loadedFormData.id] = loadedFormData;
        }
      }
      state = loadedForms; // Set the state to only loaded forms
    } catch (e) {
      if (kDebugMode) {
        print('Error loading all forms: $e');
      }
    }
  }

  Future<void> _saveFormIndex() async {
    try {
      final filePath = await _getIndexFilePath();
      final file = File(filePath);
      final jsonString = json.encode(state.keys.toList());
      await file.writeAsString(jsonString);
    } catch (e) {
      if (kDebugMode) {
        print('Error saving form index: $e');
      }
    }
  }

  void addForm(FormData formData) { // Change parameter to FormData
    if (!state.containsKey(formData.id)) {
      state = {...state, formData.id: formData}; // Use formData.id as key
      _saveFormIndex();
    }
  }

  void removeForm(String id) { // Change parameter to id
    if (state.containsKey(id)) {
      final newState = Map<String, FormData>.from(state);
      newState.remove(id);
      state = newState;
      _saveFormIndex();
      _deleteFormFile(id); // Delete the individual form file
    }
  }

  Future<void> renameForm(String oldId, FormData newFormData) async { // Change parameters
    if (state.containsKey(oldId) && !state.containsKey(newFormData.id)) {
      final newState = Map<String, FormData>.from(state);
      newState.remove(oldId);
      newState[newFormData.id] = newFormData;
      state = newState;
      await _saveFormIndex();
      await _deleteFormFile(oldId); // Delete the old file
      // The new file will be saved by form_provider when its state changes
    }
  }

  Future<void> _deleteFormFile(String id) async { // Change parameter to id
    try {
      final filePath = await _getFormFilePath(id);
      final file = File(filePath);
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error deleting form file for $id: $e');
      }
    }
  }

  void updateForm(String id, FormData formData) { // Change parameter to id
    if (state.containsKey(id)) {
      state = {...state, id: formData};
    }
  }
}

final selectedFormIdentifierProvider = StateProvider<String?>((ref) => null);
