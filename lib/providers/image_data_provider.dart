import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/image_data.dart';

// Define a StateNotifierProvider for managing a list of ImageData
final imageDataListProvider = StateNotifierProvider<ImageDataListNotifier, List<ImageData>>((ref) {
  return ImageDataListNotifier();
});

// Define the StateNotifier to manage the list of ImageData
class ImageDataListNotifier extends StateNotifier<List<ImageData>> {
  ImageDataListNotifier() : super([]);

  // Method to add new ImageData
  void addImageData(ImageData imageData) {
    state = [...state, imageData];
  }

  // Method to update existing ImageData by label
  void updateImageDataByLabel(String label, {String? imagePath, String? formId}) {
    state = [
      for (final img in state)
        if (img.label == label)
          ImageData(
            label: img.label,
            imagePath: imagePath ?? img.imagePath,
            formId: formId ?? img.formId,
          )
        else
          img,
    ];
  }

  // Method to remove ImageData by label
  void removeImageDataByLabel(String label) {
    state = state.where((img) => img.label != label).toList();
  }

  // Method to clear all ImageData
  void clearImageData() {
    state = [];
  }
}
