import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/services/inspection_service.dart';
import 'package:form_app/providers/auth_provider.dart';
import 'package:form_app/utils/crashlytics_util.dart';

final inspectionServiceProvider = Provider<InspectionService>((ref) {
  final authService = ref.watch(authServiceProvider);
  final crashlyticsUtil = ref.watch(crashlyticsUtilProvider);
  return InspectionService(authService, crashlyticsUtil);
});
