import 'package:flutter_riverpod/flutter_riverpod.dart';
// Import apiServiceProvider from your existing inspection_branches_provider.dart
import 'package:form_app/providers/inspection_branches_provider.dart';

// FutureProvider to fetch inspectors
final inspectorProvider = FutureProvider<List<String>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getInspectors();
});
