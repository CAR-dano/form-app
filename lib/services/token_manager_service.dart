import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class TokenManagerService {
  final FlutterSecureStorage _secureStorage;

  TokenManagerService() : _secureStorage = const FlutterSecureStorage();

  Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
    required String userName,
  }) async {
    await _secureStorage.write(key: 'accessToken', value: accessToken);
    await _secureStorage.write(key: 'refreshToken', value: refreshToken);
    await _secureStorage.write(key: 'userName', value: userName);
    if (kDebugMode) {
      print('Tokens and user name saved successfully.');
    }
  }

  Future<String?> getAccessToken() async {
    return await _secureStorage.read(key: 'accessToken');
  }

  Future<String?> getRefreshToken() async {
    return await _secureStorage.read(key: 'refreshToken');
  }

  Future<String?> getUserName() async {
    return await _secureStorage.read(key: 'userName');
  }

  Future<void> clearTokens() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');
    await _secureStorage.delete(key: 'userName');
    debugPrint('User tokens cleared.');
  }
}
