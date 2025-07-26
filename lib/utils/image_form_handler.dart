import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_app/utils/image_capture_and_processing_util.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/message_overlay_provider.dart'; // Import the new provider
import 'package:form_app/statics/app_styles.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode
import 'package:form_app/utils/crashlytics_util.dart';

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
        final crashlyticsUtil = ref.read(crashlyticsUtilProvider);
        final String? processedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(
          pickedImageXFile,
          crashlyticsUtil: crashlyticsUtil,
        );

        if (context.mounted && processedPath != null) {
          await onSuccess(processedPath);
        } else if (context.mounted && processedPath == null) {
          if (kDebugMode) print("Image processing failed for $identifier.");
          ref.read(customMessageOverlayProvider).show(
              context: context, // Pass context here
              message: 'Gagal memproses gambar untuk $identifier.',
              color: errorBorderColor,
              icon: Icons.error);
        }
      }
    } catch (e, stackTrace) {
      ref.read(crashlyticsUtilProvider).recordError(e, stackTrace, reason: 'Error during image processing for $identifier');
      if (context.mounted) debugPrint("Error during image processing for $identifier: $e");
      if (context.mounted) {
        ref.read(customMessageOverlayProvider).show(
            context: context, // Pass context here
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
        final crashlyticsUtil = ref.read(crashlyticsUtilProvider);
        for (var imageFileXFile in imagesXFiles) {
          final String? processedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(
            imageFileXFile,
            crashlyticsUtil: crashlyticsUtil,
          );
          if (context.mounted && processedPath != null) {
            await onSuccess(processedPath); // Call onSuccess for each image
          } else if (context.mounted && processedPath == null) {
            if (kDebugMode) print("Image processing failed for ${imageFileXFile.name} in $identifier.");
            ref.read(customMessageOverlayProvider).show(
                context: context, // Pass context here
                message: 'Gagal memproses gambar: ${imageFileXFile.name}',
                color: errorBorderColor,
                icon: Icons.photo_library);
          }
        }
      }
    } catch (e, stackTrace) {
      ref.read(crashlyticsUtilProvider).recordError(e, stackTrace, reason: 'Error during multi-image processing for $identifier');
      if (context.mounted) debugPrint("Error during multi-image processing for $identifier: $e");
      if (context.mounted) {
        ref.read(customMessageOverlayProvider).show(
            context: context, // Pass context here
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
