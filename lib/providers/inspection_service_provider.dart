import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/services/inspection_service.dart';
import 'package:form_app/providers/auth_provider.dart';

final inspectionServiceProvider = Provider<InspectionService>((ref) {
  final authService = ref.watch(authServiceProvider);
  return InspectionService(authService);
});

