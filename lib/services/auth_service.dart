import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/api_exception.dart';
import 'package:form_app/models/auth_response.dart';
import 'package:form_app/models/user_data.dart';
import 'package:form_app/providers/user_info_provider.dart';
import 'package:form_app/services/token_manager_service.dart';
import 'package:form_app/utils/crashlytics_util.dart';

class AuthService {
  final dio.Dio _dioInst;
  final TokenManagerService _tokenManager;
  final Ref _ref;
  final CrashlyticsUtil _crashlytics;

  String get _baseApiUrl {
    if (kDebugMode) {
      return dotenv.env['API_BASE_URL_DEBUG']!;
    }
    return dotenv.env['API_BASE_URL']!;
  }

  String get _loginInspectorUrl => '$_baseApiUrl/auth/login/inspector';
  String get _checkTokenUrl => '$_baseApiUrl/auth/check-token';
  String get _refreshTokenUrl => '$_baseApiUrl/auth/refresh';

  AuthService(this._tokenManager, this._ref, this._crashlytics) : _dioInst = dio.Dio() {
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
        final UserData userData = UserData.fromAuthResponse(response.data);

        await _tokenManager.saveTokens(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
        );
        // Update the provider state
        await _ref.read(userInfoProvider.notifier).saveUserData(userData);

        if (kDebugMode) {
          print(
              'Login successful! Access Token: ${authResponse.accessToken}, Refresh Token: ${authResponse.refreshToken}, User Name: ${authResponse.user.name}');
        }
        return authResponse;
      } else {
        final errorMessage = response.data['message'] ?? 'Unknown error';
        throw ApiException(
          message: 'Failed to login: $errorMessage',
          statusCode: response.statusCode,
          responseData: response.data,
        );
      }
    } on ApiException catch (e, stackTrace) {
      _crashlytics.recordError(
        e,
        stackTrace,
        reason: 'Login inspector failed',
      );
      rethrow;
    } catch (e, stackTrace) {
      String message = 'Login failed: ${e.toString()}';
      int? statusCode;
      Map<String, dynamic>? responseData;

      // Try to extract response data from the error if available
      try {
        final errorResponse = (e as dynamic).response;
        if (errorResponse != null) {
          statusCode = errorResponse.statusCode;
          responseData = errorResponse.data;
          if (responseData != null && responseData['message'] != null) {
            message = responseData['message'];
          } else {
            message = 'Server error';
          }
        }
      } catch (_) {
        // If we can't extract response data, keep the default message
      }

      final apiException = ApiException(
        message: message,
        statusCode: statusCode,
        responseData: responseData,
      );

      _crashlytics.recordError(
        apiException,
        stackTrace,
        reason: 'Login inspector failed',
      );
      
      throw apiException;
    }
  }

  Future<String?> getAccessToken() async {
    return await _tokenManager.getAccessToken();
  }

  Future<String?> getRefreshToken() async {
    return await _tokenManager.getRefreshToken();
  }

  Future<void> logout() async {
    await _tokenManager.clearTokens();
    // Clear the provider state
    await _ref.read(userInfoProvider.notifier).clearUserData();
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
        debugPrint(
            'Token check failed with status: ${response.statusCode}. Attempting to refresh token.');
        return await _tryRefreshToken();
      }
    } catch (e, stackTrace) {
      // Check if it's a 401 error (expected during token expiry)
      bool is401 = false;
      try {
        final errorResponse = (e as dynamic).response;
        if (errorResponse?.statusCode == 401) {
          is401 = true;
        }
      } catch (_) {
        // If we can't check the status code, it's not a 401
      }

      if (is401) {
        debugPrint('Token is unauthorized. Attempting to refresh token.');
        return await _tryRefreshToken();
      }
      
      // Log unexpected errors
      _crashlytics.recordError(
        e,
        stackTrace,
        reason: 'Token check failed with unexpected error',
      );
      debugPrint('Token check failed: $e');
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

        await _tokenManager.saveTokens(
          accessToken: authResponse.accessToken,
          refreshToken: authResponse.refreshToken,
        );

        debugPrint('Token refreshed successfully.');
        return true;
      } else {
        debugPrint(
            'Refresh token failed with status: ${response.statusCode}. Logging out.');
        await logout();
        return false;
      }
    } catch (e, stackTrace) {
      // Log refresh failures - these are important to track
      _crashlytics.recordError(
        e,
        stackTrace,
        reason: 'Token refresh failed',
      );
      debugPrint('Refresh token failed: $e');
      await logout();
      return false;
    }
  }
}
