import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:gal/gal.dart';
// Note: We no longer need 'package:flutter/foundation.dart' for compute, but it's good for kDebugMode.

// This function is no longer an isolate entry point, just a regular helper function.
// It contains the core compression logic.
Future<String?> _performCompression({
  required String pickedFilePath,
  required String tempPath,
  int rotationAngle = 0,
}) async {
  try {
    final originalFile = File(pickedFilePath);
    final originalFileSize = await originalFile.length();

    int jpgQuality = 50;
    if (originalFileSize > 4 * 1024 * 1024) { // > 4MB
      jpgQuality = 45;
    } else if (originalFileSize > 2 * 1024 * 1024) { // > 2MB
      jpgQuality = 47;
    }

    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final targetPath = '$tempPath/${timestamp}_compressed.jpg';

    // Directly await the compression. This is now safe and won't throw the platform channel error.
    final XFile? result = await FlutterImageCompress.compressAndGetFile(
      originalFile.absolute.path,
      targetPath,
      quality: jpgQuality,
      minWidth: 1200,
      minHeight: 1200,
      rotate: rotationAngle,
      format: CompressFormat.jpeg,
    );

    if (result == null) {
      if (kDebugMode) print('Image compression failed.');
      return null;
    }

    final compressedFile = File(result.path);
    if (kDebugMode) {
      print('Processed image saved to: ${compressedFile.path}');
      final int fileSize = await compressedFile.length();
      print('Original file size: ${(originalFileSize / 1024).toStringAsFixed(2)} KB');
      print('Compressed file size: ${(fileSize / 1024).toStringAsFixed(2)} KB');
    }

    return compressedFile.path;
  } catch (e) {
    if (kDebugMode) {
      print("Error during image compression: $e");
    }
    return null;
  }
}

class ImageCaptureAndProcessingUtil {
  static final ImagePicker _picker = ImagePicker();

  // THE KEY CHANGE IS HERE: We remove the 'compute' wrapper.
  static Future<String?> processAndSaveImage(XFile pickedFile, {int rotationAngle = 0}) async {
    final directory = await getTemporaryDirectory();
    
    // Instead of spawning an isolate with compute, we call our helper function directly.
    // The 'await' ensures it completes before moving on, but because it's in a Future,
    // it doesn't block the UI event loop.
    return await _performCompression(
      pickedFilePath: pickedFile.path,
      tempPath: directory.path,
      rotationAngle: rotationAngle,
    );
  }

  // No other methods in this class need to be changed.
  // The rest of the file (saveImageToGallery, pickImageFromGallery, etc.) remains the same.
  static Future<void> saveImageToGallery(XFile imageXFile, {String? album}) async {
    try {
      bool hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final accessGranted = await Gal.requestAccess();
        if (!accessGranted) {
          if (kDebugMode) print('Gallery access denied by user.');
          return;
        }
      }
      await Gal.putImage(imageXFile.path, album: album);
      if (kDebugMode) print('Image successfully saved to gallery via Gal package.');
    } catch (e) {
      if (kDebugMode) print('Error saving image to gallery using Gal: $e');
    }
  }

  static Future<XFile?> pickImageFromGallery() async {
    return await _picker.pickImage(source: ImageSource.gallery);
  }

  static Future<List<XFile>> pickMultiImagesFromGallery() async {
    return await _picker.pickMultiImage();
  }

  static Future<void> processAndAddImage({
    required XFile imageFile,
    required TambahanImageDataListNotifier tambahanImageNotifier,
    required String imageIdentifier,
    required String defaultLabel,
    int rotationAngle = 0,
  }) async {
    try {
      await ImageCaptureAndProcessingUtil.saveImageToGallery(imageFile);
      
      final String? processedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(
        imageFile,
        rotationAngle: rotationAngle,
      );

      if (processedPath != null) {
        final newTambahanImage = TambahanImageData(
          imagePath: processedPath,
          label: defaultLabel,
          needAttention: false,
          category: imageIdentifier,
          isMandatory: false,
          originalRawPath: imageFile.path,
          rotationAngle: rotationAngle,
        );
        tambahanImageNotifier.addImage(newTambahanImage);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error processing and adding image: $e");
      }
    }
  }

  static Future<XFile?> rotateImageOnly(XFile sourceFile, {int rotationAngle = 0}) async {
    // If no rotation is needed, just return the original file.
    if (rotationAngle == 0) {
      return sourceFile;
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final targetPath = '${tempDir.path}/${DateTime.now().millisecondsSinceEpoch}_rotated.jpg';

      // Call compression with 100% quality to perform a lossless rotation.
      final result = await FlutterImageCompress.compressAndGetFile(
        sourceFile.path,
        targetPath,
        quality: 100, // Keep original quality
        rotate: rotationAngle,
      );
      
      if (result != null) {
        debugPrint('Image rotated losslessly and saved to: ${result.path}');
      }
      
      return result;
    } catch (e) {
      if (kDebugMode) {
        print('Error during lossless rotation: $e');
      }
      return null; // Return null on failure
    }
  }
}
