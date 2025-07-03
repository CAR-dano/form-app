import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/utils/image_capture_and_processing_util.dart';
import 'package:form_app/services/task_queue_service.dart'; // Import the generic task queue service

/// A task for capturing and processing an image.
class ImageCaptureTask extends QueueTask<void> {
  final XFile capturedImageFile;
  final double capturedRotationAngle;
  final String defaultLabel;

  ImageCaptureTask({
    required this.capturedImageFile,
    required this.capturedRotationAngle,
    required super.identifier,
    required this.defaultLabel,
  });

  @override
  Future<void> execute(Ref ref) async {
    final imageProcessingNotifier = ref.read(imageProcessingServiceProvider.notifier);
    final tambahanImageNotifier = ref.read(tambahanImageDataProvider(identifier).notifier);

    imageProcessingNotifier.taskStarted(identifier);
    try {
      final XFile imageFileAfterRotation = await ImageCaptureAndProcessingUtil.rotateImageIfNecessary(
        capturedImageFile,
        capturedRotationAngle,
      );

      await ImageCaptureAndProcessingUtil.processAndAddImage(
        imageFile: imageFileAfterRotation,
        tambahanImageNotifier: tambahanImageNotifier,
        imageIdentifier: identifier,
        defaultLabel: defaultLabel,
      );
      if (kDebugMode) {
        print('Successfully processed image for identifier: $identifier');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error processing image for $identifier: $e");
      }
      rethrow; // Re-throw to be caught by the generic queue service
    } finally {
      imageProcessingNotifier.taskFinished(identifier);
    }
  }
}