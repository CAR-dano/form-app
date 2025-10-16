import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/inspection_service_provider.dart';
import 'package:form_app/models/inspection_branch.dart';

// FutureProvider to fetch inspection branches
// It will automatically handle loading/error states and re-fetch if dependencies change (though none here).
final inspectionBranchesProvider = FutureProvider<List<InspectionBranch>>((ref) async {
  final apiService = ref.watch(inspectionServiceProvider);
  return apiService.getInspectionBranches();
});
