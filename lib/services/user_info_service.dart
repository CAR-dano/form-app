import 'dart:convert';
import 'dart:io';
import 'package:form_app/models/user_data.dart';
import 'package:path_provider/path_provider.dart';

class UserInfoService {
  static const String _fileName = 'user_info.json';

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
    } catch (e) {
      // Handle potential errors, e.g., file corruption
      print('Error reading user data: $e');
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
      print('Error clearing user data: $e');
    }
  }
}
