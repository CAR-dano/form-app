import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Assuming FormData is defined here

class SubmissionDataCache {
  final String? lastSubmittedInspectionId;
  final FormData? lastSubmittedFormData;

  SubmissionDataCache({
    this.lastSubmittedInspectionId,
    this.lastSubmittedFormData,
  });

  SubmissionDataCache copyWith({
    String? lastSubmittedInspectionId,
    FormData? lastSubmittedFormData,
  }) {
    return SubmissionDataCache(
      lastSubmittedInspectionId: lastSubmittedInspectionId ?? this.lastSubmittedInspectionId,
      lastSubmittedFormData: lastSubmittedFormData ?? this.lastSubmittedFormData,
    );
  }
}

final submissionDataCacheProvider = StateNotifierProvider<SubmissionDataCacheNotifier, SubmissionDataCache>(
  (ref) => SubmissionDataCacheNotifier(),
);

class SubmissionDataCacheNotifier extends StateNotifier<SubmissionDataCache> {
  SubmissionDataCacheNotifier() : super(SubmissionDataCache());

  void setCache({String? inspectionId, FormData? formData}) {
    state = state.copyWith(
      lastSubmittedInspectionId: inspectionId,
      lastSubmittedFormData: formData,
    );
  }

  void clearCache() {
    state = SubmissionDataCache();
  }
}
