import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/utils/image_capture_and_processing_util.dart';
import 'package:form_app/services/task_queue_service.dart';
import 'package:form_app/utils/crashlytics_util.dart'; // Import CrashlyticsUtil
import 'dart:math' show pi;

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
    final crashlyticsUtil = ref.read(crashlyticsUtilProvider); // Get CrashlyticsUtil instance

    imageProcessingNotifier.taskStarted(identifier);
    try {
      // Step 1: Calculate the required rotation in degrees
      int rotationInDegrees = 0;
      if ((capturedRotationAngle - (pi / 2)).abs() < 0.1) {
        rotationInDegrees = -90;
      } else if ((capturedRotationAngle - (-pi / 2)).abs() < 0.1) {
        rotationInDegrees = 90;
      } else if ((capturedRotationAngle - pi).abs() < 0.1) {
        rotationInDegrees = 180;
      }

      // Step 2: Perform a lossless rotation on the original image
      final XFile? rotatedFullQualityFile = await ImageCaptureAndProcessingUtil.rotateImageOnly(
        capturedImageFile,
        rotationAngle: rotationInDegrees,
        crashlyticsUtil: crashlyticsUtil, // Pass crashlyticsUtil
      );

      // Abort if rotation fails
      if (rotatedFullQualityFile == null) {
        throw Exception('Failed to rotate the image.');
      }

      // Step 3: Save the full-quality, rotated image to the gallery
      await ImageCaptureAndProcessingUtil.saveImageToGallery(
        rotatedFullQualityFile,
        album: 'Palapa Inspeksi',
        crashlyticsUtil: crashlyticsUtil, // Pass crashlyticsUtil
      );

      // Step 4: Now, compress the rotated image for use in the app
      final String? compressedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(
        rotatedFullQualityFile,
        crashlyticsUtil: crashlyticsUtil, // Pass crashlyticsUtil
        // No rotation needed here as it's already been done
      );

      // Step 5: If compression is successful, add to app state
      if (compressedPath != null) {
        final newTambahanImage = TambahanImageData(
          imagePath: compressedPath,
          label: defaultLabel,
          needAttention: false,
          category: identifier,
          isMandatory: false,
          originalRawPath: capturedImageFile.path, // Still reference the absolute original
          rotationAngle: rotationInDegrees,
        );
        tambahanImageNotifier.addImage(newTambahanImage);
      }

      if (kDebugMode) {
        print('Successfully processed image for identifier: $identifier');
      }
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print("Error processing image for $identifier: $e");
      }
      crashlyticsUtil.recordError(e, stackTrace, reason: 'Error processing image in ImageCaptureTask for $identifier'); // Use CrashlyticsUtil
      rethrow;
    } finally {
      imageProcessingNotifier.taskFinished(identifier);
    }
  }
}
