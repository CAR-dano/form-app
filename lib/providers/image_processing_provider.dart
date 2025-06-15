import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart';

// This provider now holds a Map to count active tasks for each identifier.
final imageProcessingServiceProvider =
    StateNotifierProvider<ImageProcessingService, Map<String, int>>((ref) {
  return ImageProcessingService();
});

class ImageProcessingService extends StateNotifier<Map<String, int>> {
  ImageProcessingService() : super({});

  void taskStarted(String identifier) {
    final newState = {...state};
    // Increment the count for the identifier, or set it to 1 if it's not there.
    newState[identifier] = (newState[identifier] ?? 0) + 1;
    state = newState;
    if (kDebugMode) {
      print("Image processing task STARTED for: $identifier. Active tasks: $state");
    }
  }

  void taskFinished(String identifier) {
    final newState = {...state};
    if (newState.containsKey(identifier)) {
      // Decrement the count.
      newState[identifier] = newState[identifier]! - 1;
      // If the count is zero, remove the identifier from the map.
      if (newState[identifier]! <= 0) {
        newState.remove(identifier);
      }
      state = newState;
    }
    if (kDebugMode) {
      print("Image processing task FINISHED for: $identifier. Active tasks: $state");
    }
  }

  // Check if a specific identifier has any active processing tasks.
  bool isProcessing(String identifier) {
    return state.containsKey(identifier);
  }

  // Check if any task is processing at all.
  bool get isAnyProcessing => state.isNotEmpty;
}