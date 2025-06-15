import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/foundation.dart'; // Import for kDebugMode

// This provider now holds a Set of unique identifiers for active tasks.
final imageProcessingServiceProvider =
    StateNotifierProvider<ImageProcessingService, Set<String>>((ref) {
  return ImageProcessingService();
});

class ImageProcessingService extends StateNotifier<Set<String>> {
  ImageProcessingService() : super({});

  void taskStarted(String identifier) {
    state = {...state, identifier};
    if (kDebugMode) {
      print("Image processing task STARTED for: $identifier. Active tasks: $state");
    }
  }

  void taskFinished(String identifier) {
    // Create a new set from the current state and remove the identifier.
    final newState = {...state};
    newState.remove(identifier);
    // Only update state if it has changed to avoid unnecessary rebuilds.
    if (state.contains(identifier)) {
      state = newState;
    }
    if (kDebugMode) {
      print("Image processing task FINISHED for: $identifier. Active tasks: $state");
    }
  }

  // Check if a specific identifier is processing.
  bool isProcessing(String identifier) {
    return state.contains(identifier);
  }

  // Check if any task is processing.
  bool get isAnyProcessing => state.isNotEmpty;
}