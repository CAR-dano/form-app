import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/form_data.dart'; // Assuming FormData is defined here

class SubmissionDataCache {
  final String? lastSubmittedInspectionId;
  final FormData? lastSubmittedFormData;
  final List<String> uploadedImagePaths; // New field to store paths of uploaded images

  SubmissionDataCache({
    this.lastSubmittedInspectionId,
    this.lastSubmittedFormData,
    this.uploadedImagePaths = const [], // Initialize as empty list
  });

  SubmissionDataCache copyWith({
    String? lastSubmittedInspectionId,
    FormData? lastSubmittedFormData,
    List<String>? uploadedImagePaths,
  }) {
    return SubmissionDataCache(
      lastSubmittedInspectionId: lastSubmittedInspectionId ?? this.lastSubmittedInspectionId,
      lastSubmittedFormData: lastSubmittedFormData ?? this.lastSubmittedFormData,
      uploadedImagePaths: uploadedImagePaths ?? this.uploadedImagePaths,
    );
  }
}

final submissionDataCacheProvider = StateNotifierProvider<SubmissionDataCacheNotifier, SubmissionDataCache>(
  (ref) => SubmissionDataCacheNotifier(),
);

class SubmissionDataCacheNotifier extends StateNotifier<SubmissionDataCache> {
  SubmissionDataCacheNotifier() : super(SubmissionDataCache());

  void setCache({String? inspectionId, FormData? formData, List<String>? uploadedImagePaths}) {
    state = state.copyWith(
      lastSubmittedInspectionId: inspectionId,
      lastSubmittedFormData: formData,
      uploadedImagePaths: uploadedImagePaths,
    );
  }

  void addUploadedImagePaths(List<String> newPaths) {
    state = state.copyWith(
      uploadedImagePaths: [...state.uploadedImagePaths, ...newPaths],
    );
  }

  void clearCache() {
    state = SubmissionDataCache();
  }
}
