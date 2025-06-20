import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_app/utils/image_capture_and_processing_util.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/widgets/custom_message_overlay.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

class ImageFormHandler {
  static Future<void> processAndHandleImageUpload({
    required BuildContext context,
    required WidgetRef ref,
    required String identifier,
    required Future<XFile?> Function() pickImageFunction,
    required Future<void> Function(String processedPath) onSuccess,
    required Function(bool isLoading) setLoadingState,
    String errorMessage = 'Terjadi kesalahan saat memproses gambar.',
  }) async {
    if (!context.mounted) return;
    FocusScope.of(context).unfocus();

    try {
      final pickedImageXFile = await pickImageFunction();

      if (pickedImageXFile != null) {
        setLoadingState(true);
        ref.read(imageProcessingServiceProvider.notifier).taskStarted(identifier);
        final String? processedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(pickedImageXFile);

        if (context.mounted && processedPath != null) {
          await onSuccess(processedPath);
        } else if (context.mounted && processedPath == null) {
          if (kDebugMode) print("Image processing failed for $identifier.");
          CustomMessageOverlay(context).show(
              message: 'Gagal memproses gambar untuk $identifier.',
              color: errorBorderColor,
              icon: Icons.error);
        }
      }
    } catch (e) {
      if (context.mounted) debugPrint("Error during image processing for $identifier: $e");
      if (context.mounted) {
        CustomMessageOverlay(context).show(
            message: '$errorMessage: $e',
            color: errorBorderColor,
            icon: Icons.error);
      }
    } finally {
      if (context.mounted) {
        ref.read(imageProcessingServiceProvider.notifier).taskFinished(identifier);
        setLoadingState(false);
      }
    }
  }

  static Future<void> processAndHandleMultiImageUpload({
    required BuildContext context,
    required WidgetRef ref,
    required String identifier,
    required Future<List<XFile>> Function() pickMultiImagesFunction,
    required Future<void> Function(String processedPath) onSuccess, // Changed to single processedPath
    String errorMessage = 'Terjadi kesalahan saat memproses beberapa gambar.',
  }) async {
    if (!context.mounted) return;
    FocusScope.of(context).unfocus();

    try {
      final List<XFile> imagesXFiles = await pickMultiImagesFunction();

      if (imagesXFiles.isNotEmpty) {
        ref.read(imageProcessingServiceProvider.notifier).taskStarted(identifier);
        for (var imageFileXFile in imagesXFiles) {
          final String? processedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(imageFileXFile);
          if (context.mounted && processedPath != null) {
            await onSuccess(processedPath); // Call onSuccess for each image
          } else if (context.mounted && processedPath == null) {
            if (kDebugMode) print("Image processing failed for ${imageFileXFile.name} in $identifier.");
            CustomMessageOverlay(context).show(
                message: 'Gagal memproses gambar: ${imageFileXFile.name}',
                color: errorBorderColor,
                icon: Icons.photo_library);
          }
        }
      }
    } catch (e) {
      if (context.mounted) debugPrint("Error during multi-image processing for $identifier: $e");
      if (context.mounted) {
        CustomMessageOverlay(context).show(
            message: '$errorMessage: $e',
            color: errorBorderColor,
            icon: Icons.error);
      }
    } finally {
      if (context.mounted) {
        ref.read(imageProcessingServiceProvider.notifier).taskFinished(identifier);
      }
    }
  }
}
