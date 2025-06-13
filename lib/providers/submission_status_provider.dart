import 'package:flutter_riverpod/flutter_riverpod.dart';

class SubmissionStatus {
  final bool isLoading;
  final String message;
  final double progress;

  SubmissionStatus({
    this.isLoading = false,
    this.message = '',
    this.progress = 0.0,
  });

  SubmissionStatus copyWith({
    bool? isLoading,
    String? message,
    double? progress,
  }) {
    return SubmissionStatus(
      isLoading: isLoading ?? this.isLoading,
      message: message ?? this.message,
      progress: progress ?? this.progress,
    );
  }
}

final submissionStatusProvider = StateNotifierProvider<SubmissionStatusNotifier, SubmissionStatus>(
  (ref) => SubmissionStatusNotifier(),
);

class SubmissionStatusNotifier extends StateNotifier<SubmissionStatus> {
  SubmissionStatusNotifier() : super(SubmissionStatus());

  void setLoading({
    required bool isLoading,
    String message = '',
    double progress = 0.0,
  }) {
    state = state.copyWith(
      isLoading: isLoading,
      message: message,
      progress: progress,
    );
  }

  void reset() {
    state = SubmissionStatus();
  }
}
