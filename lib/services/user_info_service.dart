import 'dart:convert';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:form_app/models/user_data.dart';
import 'package:path_provider/path_provider.dart';
import 'package:form_app/utils/crashlytics_util.dart'; // Import CrashlyticsUtil

class UserInfoService {
  static const String _fileName = 'user_info.json';
  final CrashlyticsUtil _crashlytics; // Add CrashlyticsUtil dependency

  UserInfoService(this._crashlytics); // Constructor to receive CrashlyticsUtil

  Future<File> get _localFile async {
    final directory = await getApplicationDocumentsDirectory();
    return File('${directory.path}/$_fileName');
  }

  Future<void> saveUserData(UserData userData) async {
    final file = await _localFile;
    final userDataJson = jsonEncode(userData.toJson());
    await file.writeAsString(userDataJson);
  }

  Future<UserData?> getUserData() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        if (contents.isNotEmpty) {
          return UserData.fromJson(jsonDecode(contents));
        }
      }
    } catch (e, st) { // Capture stack trace
      // Handle potential errors, e.g., file corruption
      debugPrint('Error reading user data: $e');
      _crashlytics.recordError(
        e,
        st,
        reason: 'Error reading user data from local storage',
        fatal: false, // Not fatal, as it might just mean no user data exists yet
      );
    }
    return null;
  }

  Future<void> clearUserData() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        await file.delete();
      }
    } catch (e) {
      debugPrint('Error clearing user data: $e');
    }
  }
}
