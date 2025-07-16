import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/inspector_data.dart'; // Import the Inspector model
import 'package:form_app/providers/api_service_provider.dart';
// Import apiServiceProvider from your existing inspection_branches_provider.dart

// FutureProvider to fetch inspectors
final inspectorProvider = FutureProvider<List<Inspector>>((ref) async { // Change return type to List<Inspector>
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getInspectors();
});
