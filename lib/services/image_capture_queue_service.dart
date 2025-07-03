import 'dart:async';
import 'dart:collection';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/utils/image_capture_and_processing_util.dart';

class ImageCaptureQueueService extends StateNotifier<bool> {
  ImageCaptureQueueService(this.ref) : super(false) {
    _processQueue(); // Start processing when the service is created
  }

  final Ref ref;
  final Queue<_ImageCaptureTask> _queue = Queue();
  bool _isProcessing = false;

  /// Adds an image capture task to the queue.
  void addImageCaptureTask({
    required XFile capturedImageFile,
    required double capturedRotationAngle,
    required String imageIdentifier,
    required String defaultLabel,
  }) {
    _queue.addLast(
      _ImageCaptureTask(
        capturedImageFile: capturedImageFile,
        capturedRotationAngle: capturedRotationAngle,
        imageIdentifier: imageIdentifier,
        defaultLabel: defaultLabel,
      ),
    );
    if (kDebugMode) {
      print('Task added to queue. Queue size: ${_queue.length}');
    }
    _processQueue(); // Attempt to process the queue
  }

  /// Processes tasks in the queue sequentially.
  Future<void> _processQueue() async {
    if (_isProcessing || _queue.isEmpty) {
      return;
    }

    _isProcessing = true;
    state = true; // Indicate that the service is busy

    while (_queue.isNotEmpty) {
      final task = _queue.removeFirst();
      if (kDebugMode) {
        print('Processing task for identifier: ${task.imageIdentifier}. Remaining tasks: ${_queue.length}');
      }

      final imageProcessingNotifier = ref.read(imageProcessingServiceProvider.notifier);
      final tambahanImageNotifier = ref.read(tambahanImageDataProvider(task.imageIdentifier).notifier);

      imageProcessingNotifier.taskStarted(task.imageIdentifier);
      try {
        final XFile imageFileAfterRotation = await ImageCaptureAndProcessingUtil.rotateImageIfNecessary(
          task.capturedImageFile,
          task.capturedRotationAngle,
        );

        await ImageCaptureAndProcessingUtil.processAndAddImage(
          imageFile: imageFileAfterRotation,
          tambahanImageNotifier: tambahanImageNotifier,
          imageIdentifier: task.imageIdentifier,
          defaultLabel: task.defaultLabel,
        );
        if (kDebugMode) {
          print('Successfully processed image for identifier: ${task.imageIdentifier}');
        }
      } catch (e) {
        if (kDebugMode) {
          print("Error processing image for ${task.imageIdentifier}: $e");
        }
      } finally {
        imageProcessingNotifier.taskFinished(task.imageIdentifier);
      }
    }

    _isProcessing = false;
    state = false; // Indicate that the service is idle
    if (kDebugMode) {
      print('Image capture queue finished processing.');
    }
  }
}

// Private class to hold image capture task data
class _ImageCaptureTask {
  final XFile capturedImageFile;
  final double capturedRotationAngle;
  final String imageIdentifier;
  final String defaultLabel;

  _ImageCaptureTask({
    required this.capturedImageFile,
    required this.capturedRotationAngle,
    required this.imageIdentifier,
    required this.defaultLabel,
  });
}

// Riverpod provider for the ImageCaptureQueueService
final imageCaptureQueueServiceProvider = StateNotifierProvider<ImageCaptureQueueService, bool>((ref) {
  return ImageCaptureQueueService(ref);
});
