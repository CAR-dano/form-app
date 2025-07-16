import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:form_app/models/auth_response.dart';

class AuthService {
  final dio.Dio _dioInst;
  final FlutterSecureStorage _secureStorage;

  String get _baseApiUrl {
    if (kDebugMode) {
      return dotenv.env['API_BASE_URL_DEBUG']!;
    }
    return dotenv.env['API_BASE_URL']!;
  }

  String get _loginInspectorUrl => '$_baseApiUrl/auth/login/inspector';
  String get _checkTokenUrl => '$_baseApiUrl/auth/check-token';
  String get _refreshTokenUrl => '$_baseApiUrl/auth/refresh';

  AuthService()
      : _dioInst = dio.Dio(),
        _secureStorage = const FlutterSecureStorage() {
    _dioInst.interceptors.add(
      dio.LogInterceptor(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        logPrint: (object) {
          if (kDebugMode) {
            print("DIO_LOG (AuthService): ${object.toString()}");
          }
        },
      ),
    );
  }

  Future<AuthResponse> loginInspector(String email, String pin) async {
    try {
      final response = await _dioInst.post(
        _loginInspectorUrl,
        data: {
          "email": email,
          "pin": pin,
        },
      );

      if (response.statusCode == 200) {
        final AuthResponse authResponse = AuthResponse.fromJson(response.data);
        await _secureStorage.write(key: 'accessToken', value: authResponse.accessToken);
        await _secureStorage.write(key: 'refreshToken', value: authResponse.refreshToken);
        await _secureStorage.write(key: 'userName', value: authResponse.user.name);
        if (kDebugMode) {
          print('Login successful! Access Token: ${authResponse.accessToken}, Refresh Token: ${authResponse.refreshToken}, User Name: ${authResponse.user.name}');
        }
        return authResponse;
      } else {
        final errorMessage = response.data['message'] ?? 'Unknown error';
        throw Exception('Failed to login: ${response.statusCode} - $errorMessage');
      }
    } on dio.DioException catch (e) {
      if (e.response != null) {
        final errorMessage = e.response?.data['message'] ?? 'Server error';
        throw Exception('Login failed: ${e.response?.statusCode} - $errorMessage');
      } else {
        throw Exception('Login failed: ${e.message}');
      }
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
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

  Future<void> logout() async {
    await _secureStorage.delete(key: 'accessToken');
    await _secureStorage.delete(key: 'refreshToken');
    await _secureStorage.delete(key: 'userName');
    
    debugPrint('User logged out and tokens cleared.');
  }

  Future<bool> checkTokenValidity() async {
    try {
      final accessToken = await getAccessToken();
      if (accessToken == null) {
        debugPrint('No access token found.');
        return false;
      }

      final response = await _dioInst.get(
        _checkTokenUrl,
        options: dio.Options(
          headers: {
            'Authorization': 'Bearer $accessToken',
          },
        ),
      );

      if (response.statusCode == 200) {
        debugPrint('Token is valid.');
        return true;
      } else {
        debugPrint('Token check failed with status: ${response.statusCode}. Attempting to refresh token.');
        return await _tryRefreshToken();
      }
    } on dio.DioException catch (e) {
      debugPrint('Token check failed due to DioException: ${e.message}');
      if (e.response?.statusCode == 401) {
        debugPrint('Token is unauthorized. Attempting to refresh token.');
        return await _tryRefreshToken();
      }
      return false;
    } catch (e) {
      debugPrint('An unexpected error occurred during token check: $e');
      return false;
    }
  }

  Future<bool> _tryRefreshToken() async {
    try {
      final refreshToken = await getRefreshToken();
      if (refreshToken == null) {
        debugPrint('No refresh token found. Logging out.');
        await logout();
        return false;
      }

      final response = await _dioInst.post(
        _refreshTokenUrl,
        data: {
          'refreshToken': refreshToken,
        },
      );

      if (response.statusCode == 200) {
        final AuthResponse authResponse = AuthResponse.fromJson(response.data);
        await _secureStorage.write(key: 'accessToken', value: authResponse.accessToken);
        await _secureStorage.write(key: 'refreshToken', value: authResponse.refreshToken);
        await _secureStorage.write(key: 'userName', value: authResponse.user.name);
        debugPrint('Token refreshed successfully.');
        return true;
      } else {
        debugPrint('Refresh token failed with status: ${response.statusCode}. Logging out.');
        await logout();
        return false;
      }
    } on dio.DioException catch (e) {
      debugPrint('Refresh token failed due to DioException: ${e.message}');
      await logout();
      return false;
    } catch (e) {
      debugPrint('An unexpected error occurred during refresh token: $e');
      await logout();
      return false;
    }
  }
}
