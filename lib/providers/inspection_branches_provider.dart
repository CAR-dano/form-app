import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/services/api_service.dart';
import 'package:form_app/models/inspection_branch.dart'; // Import InspectionBranch model

// Provider for the ApiService instance
final apiServiceProvider = Provider<ApiService>((ref) {
  return ApiService();
});

// FutureProvider to fetch inspection branches
// It will automatically handle loading/error states and re-fetch if dependencies change (though none here).
final inspectionBranchesProvider = FutureProvider<List<InspectionBranch>>((ref) async {
  final apiService = ref.watch(apiServiceProvider);
  return apiService.getInspectionBranches();
});
