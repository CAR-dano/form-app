import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/utils/image_capture_and_processing_util.dart';
import 'package:form_app/services/task_queue_service.dart'; // Import the generic task queue service
import 'dart:math' show pi; 

/// A task for capturing and processing an image.
class ImageCaptureTask extends QueueTask<void> {
  final XFile capturedImageFile;
  final double capturedRotationAngle; // in radians (e.g., pi / 2)
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
      // Convert radians to degrees for the new processing function
      int rotationInDegrees = 0;
      if ((capturedRotationAngle - (pi / 2)).abs() < 0.1) {
        rotationInDegrees = -90;
      } else if ((capturedRotationAngle - (-pi / 2)).abs() < 0.1) {
        rotationInDegrees = 90; // or 270 depending on library
      } else if ((capturedRotationAngle - pi).abs() < 0.1) {
        rotationInDegrees = 180;
      }

      // NO longer need to call rotateImageIfNecessary. The processing is done in one step.
      await ImageCaptureAndProcessingUtil.processAndAddImage(
        imageFile: capturedImageFile,
        tambahanImageNotifier: tambahanImageNotifier,
        imageIdentifier: identifier,
        defaultLabel: defaultLabel,
        rotationAngle: rotationInDegrees, // Pass the angle here
      );

      if (kDebugMode) {
        print('Successfully processed image for identifier: $identifier');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error processing image for $identifier: $e");
      }
      rethrow;
    } finally {
      imageProcessingNotifier.taskFinished(identifier);
    }
  }
}
