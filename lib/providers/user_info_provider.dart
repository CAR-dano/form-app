import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/user_data.dart';
import 'package:form_app/services/user_info_service.dart';
import 'package:form_app/utils/crashlytics_util.dart'; // Import CrashlyticsUtil

final userInfoServiceProvider = Provider<UserInfoService>((ref) {
  final crashlytics = ref.watch(crashlyticsUtilProvider); // Use the existing provider
  return UserInfoService(crashlytics);
});

final userInfoProvider = NotifierProvider<UserInfoNotifier, AsyncValue<UserData?>>(() {
  return UserInfoNotifier();
});

class UserInfoNotifier extends Notifier<AsyncValue<UserData?>> {
  late final UserInfoService _userInfoService;

  @override
  AsyncValue<UserData?> build() {
    _userInfoService = ref.watch(userInfoServiceProvider);
    _loadUserData();
    return const AsyncValue.loading();
  }

  Future<void> _loadUserData() async {
    try {
      final userData = await _userInfoService.getUserData();
      state = AsyncValue.data(userData);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> saveUserData(UserData userData) async {
    try {
      await _userInfoService.saveUserData(userData);
      state = AsyncValue.data(userData);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> clearUserData() async {
    try {
      await _userInfoService.clearUserData();
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}
