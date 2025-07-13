import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart'; // For context and Colors
import 'package:form_app/utils/image_capture_and_processing_util.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/message_overlay_provider.dart';
import 'package:form_app/services/task_queue_service.dart'; // Import the generic task queue service
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

/// A task for processing an image from the gallery.
class ImageProcessingQueueTask extends QueueTask<String?> {
  final XFile pickedFile;
  final int rotationAngle;
  final BuildContext? context; // To show messages

  ImageProcessingQueueTask({
    required this.pickedFile,
    required super.identifier,
    this.rotationAngle = 0,
    this.context,
  });

  @override
  Future<String?> execute(Ref ref) async {
    final imageProcessingNotifier = ref.read(imageProcessingServiceProvider.notifier);
    final messageOverlayNotifier = ref.read(customMessageOverlayProvider);

    imageProcessingNotifier.taskStarted(identifier);
    try {
      final String? processedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(
        pickedFile,
        rotationAngle: rotationAngle,
      );
      return processedPath;
    } catch (e, stackTrace) {
      if (context != null && context!.mounted) { // Add null check for context before accessing mounted
        messageOverlayNotifier.show(
          context: context!, // Use null assertion operator as context is checked for null
          message: 'Error memproses gambar: $e',
          color: Colors.red,
          icon: Icons.error,
        );
      }
      FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: 'Error processing image in ImageProcessingQueueTask for $identifier');
      rethrow; // Re-throw to be caught by the generic queue service
    } finally {
      imageProcessingNotifier.taskFinished(identifier);
    }
  }
}

// This provider will no longer manage a queue directly, but will provide a method to enqueue tasks.
final imageProcessingQueueProvider = Provider((ref) {
  final taskQueue = ref.read(taskQueueServiceProvider.notifier);
  return (
    enqueueImageProcessing: ({
      required XFile pickedFile,
      required String identifier,
      int rotationAngle = 0,
      BuildContext? context,
    }) {
      final task = ImageProcessingQueueTask(
        pickedFile: pickedFile,
        identifier: identifier,
        rotationAngle: rotationAngle,
        context: context,
      );
      taskQueue.addTask(task);
      return task.completer.future; // This future now correctly completes with a String?
    },
  );
});
