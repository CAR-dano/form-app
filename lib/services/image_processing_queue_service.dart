import 'dart:collection';
import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_app/utils/image_capture_and_processing_util.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/message_overlay_provider.dart';
import 'package:flutter/material.dart'; // For context and Colors

class ImageProcessingTask {
  final XFile pickedFile;
  final String identifier;
  final int rotationAngle;
  final Completer<String?> completer;
  final BuildContext? context; // To show messages

  ImageProcessingTask({
    required this.pickedFile,
    required this.identifier,
    this.rotationAngle = 0,
    required this.completer,
    this.context,
  });
}

class ImageProcessingQueueService extends Notifier<Queue<ImageProcessingTask>> {
  bool _isProcessing = false;

  @override
  Queue<ImageProcessingTask> build() {
    return Queue<ImageProcessingTask>();
  }

  Future<String?> enqueueImageProcessing({
    required XFile pickedFile,
    required String identifier,
    int rotationAngle = 0,
    BuildContext? context, // Pass context for message overlay
  }) {
    final completer = Completer<String?>();
    final task = ImageProcessingTask(
      pickedFile: pickedFile,
      identifier: identifier,
      rotationAngle: rotationAngle,
      completer: completer,
      context: context,
    );
    state.add(task);
    _processQueue(); // Attempt to process the queue
    return completer.future;
  }

  Future<void> _processQueue() async {
    if (_isProcessing || state.isEmpty) {
      return;
    }

    _isProcessing = true;
    while (state.isNotEmpty) {
      final task = state.removeFirst();
      final identifier = task.identifier;
      final context = task.context;

      // Notify that a task has started for this identifier
      ref.read(imageProcessingServiceProvider.notifier).taskStarted(identifier);

      String? processedPath;
      try {
        processedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(
          task.pickedFile,
          rotationAngle: task.rotationAngle,
        );
        task.completer.complete(processedPath);
      } catch (e) {
        task.completer.completeError(e);
        if (context != null && context.mounted) {
          ref.read(customMessageOverlayProvider).show(
            context: context,
            message: 'Error memproses gambar: $e',
            color: Colors.red,
            icon: Icons.error,
          );
        }
      } finally {
        // Notify that a task has finished for this identifier
        ref.read(imageProcessingServiceProvider.notifier).taskFinished(identifier);
      }
    }
    _isProcessing = false;
  }
}

final imageProcessingQueueProvider = NotifierProvider<ImageProcessingQueueService, Queue<ImageProcessingTask>>(
  ImageProcessingQueueService.new,
);
