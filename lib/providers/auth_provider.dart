import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/services/auth_service.dart';
import 'package:form_app/services/token_manager_service.dart';

final tokenManagerProvider = Provider<TokenManagerService>((ref) {
  return TokenManagerService();
});

final authServiceProvider = Provider<AuthService>((ref) {
  final tokenManager = ref.watch(tokenManagerProvider);
  return AuthService(tokenManager, ref);
});
