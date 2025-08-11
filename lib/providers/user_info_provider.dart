import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/user_data.dart';
import 'package:form_app/services/user_info_service.dart';

final userInfoServiceProvider = Provider<UserInfoService>((ref) {
  return UserInfoService();
});

final userInfoProvider = StateNotifierProvider<UserInfoNotifier, AsyncValue<UserData?>>((ref) {
  return UserInfoNotifier(ref.watch(userInfoServiceProvider));
});

class UserInfoNotifier extends StateNotifier<AsyncValue<UserData?>> {
  final UserInfoService _userInfoService;

  UserInfoNotifier(this._userInfoService) : super(const AsyncValue.loading()) {
    _loadUserData();
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
