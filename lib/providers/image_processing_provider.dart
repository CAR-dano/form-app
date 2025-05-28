import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart'; // Import for kDebugMode

// Provider to track the number of active image processing tasks
final imageProcessingServiceProvider = StateNotifierProvider<ImageProcessingService, int>((ref) {
  return ImageProcessingService();
});

class ImageProcessingService extends StateNotifier<int> {
  ImageProcessingService() : super(0);

  void taskStarted() {
    state++;
    if (kDebugMode) {
      print("Image processing tasks started. Active: $state");
    }
  }

  void taskFinished() {
    if (state > 0) {
      state--;
    }
    if (kDebugMode) {
      print("Image processing tasks finished. Active: $state");
    }
  }

  bool get isProcessing => state > 0;
}
