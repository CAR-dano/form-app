import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/services/api_service.dart';
import 'package:form_app/providers/auth_provider.dart';

final apiServiceProvider = Provider<ApiService>((ref) {
  final authService = ref.watch(authServiceProvider);
  return ApiService(authService);
});
