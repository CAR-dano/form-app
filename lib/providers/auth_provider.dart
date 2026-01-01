import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/services/auth_service.dart';
import 'package:form_app/services/token_manager_service.dart';
import 'package:form_app/utils/crashlytics_util.dart';

final tokenManagerProvider = Provider<TokenManagerService>((ref) {
  return TokenManagerService();
});

final authServiceProvider = Provider<AuthService>((ref) {
  final tokenManager = ref.watch(tokenManagerProvider);
  final crashlyticsUtil = ref.watch(crashlyticsUtilProvider);
  return AuthService(tokenManager, ref, crashlyticsUtil);
});
