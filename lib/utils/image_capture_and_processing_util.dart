import 'package:flutter/foundation.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:gal/gal.dart';
import 'dart:math' show pi; // Added for pi constant

// Helper class for passing data to the rotation isolate
class _RotateImageInput {
  final String filePath;
  final double rotationAngle;
  final String tempPath; // For saving the rotated image

  _RotateImageInput({
    required this.filePath,
    required this.rotationAngle,
    required this.tempPath,
  });
}

// Top-level function for image rotation in an isolate
Future<String?> _rotateImageInIsolate(_RotateImageInput input) async {
  if (input.rotationAngle == 0.0) {
    // No rotation needed if angle is exactly 0.0
    // Consider a small tolerance if needed: (input.rotationAngle.abs() < 0.01)
    return input.filePath;
  }

  try {
    final File imageFile = File(input.filePath);
    // Ensure Uint8List is imported or use imageFile.readAsBytesSync() if appropriate for isolate context
    // However, async readAsBytes should be fine.
    final Uint8List imageBytes = await imageFile.readAsBytes();
    final img.Image? originalImage = img.decodeImage(imageBytes);

    if (originalImage == null) {
      if (kDebugMode) {
        print("Isolate Error: Could not decode image for rotation: ${input.filePath}");
      }
      return input.filePath; // Return original path if decoding fails
    }

    img.Image rotatedImage;
    // img.copyRotate expects angle in degrees.
    // pi/2 radians = 90 degrees. -pi/2 radians = -90 degrees.
    if (input.rotationAngle == pi / 2) {
      // Device top is to the LEFT (landscape). Image from camera (portrait) needs to be rotated Counter-Clockwise.
      rotatedImage = img.copyRotate(originalImage, angle: -90);
    } else if (input.rotationAngle == -pi / 2) {
      // Device top is to the RIGHT (landscape). Image from camera (portrait) needs to be rotated Clockwise.
      rotatedImage = img.copyRotate(originalImage, angle: 90);
    } else {
      // Not a 90-degree rotation, return original path.
      // This case should ideally not be reached if rotationAngle is only set to 0, pi/2, or -pi/2.
      if (kDebugMode) {
        print("Isolate Info: Non-90 degree rotation angle (${input.rotationAngle}), not rotating.");
      }
      return input.filePath;
    }

    // Ensure the tempPath ends with a path separator if not already, or construct carefully.
    // Platform.pathSeparator is the correct way to do this.
    final String newFileName = '${DateTime.now().millisecondsSinceEpoch}_rotated.jpg';
    final String rotatedFilePath = '${input.tempPath}${Platform.pathSeparator}$newFileName';
    
    final File rotatedFile = File(rotatedFilePath);
    // encodeJpg returns List<int>, which is compatible with Uint8List
    await rotatedFile.writeAsBytes(img.encodeJpg(rotatedImage));

    if (kDebugMode) {
      print("Isolate: Image rotated by ${input.rotationAngle} rad. New path: $rotatedFilePath");
    }
    return rotatedFilePath;
  } catch (e) {
    if (kDebugMode) {
      print("Isolate Error rotating image: $e");
    }
    // Fallback to original path on error during processing
    return input.filePath;
  }
}

// Helper class to pass arguments to _processImageIsolate
class _ProcessImageInput {
  final String pickedFilePath;
  final String pickedFileName;
  final String tempPath;
  final int rotationAngle; // New parameter for rotation

  _ProcessImageInput({
    required this.pickedFilePath,
    required this.pickedFileName,
    required this.tempPath,
    this.rotationAngle = 0, // Default to no rotation
  });
}

// This function will run in a separate isolate
Future<String?> _processImageIsolate(_ProcessImageInput input) async {
  final File imageFile = File(input.pickedFilePath);
  List<int> imageBytes = await imageFile.readAsBytes();
  img.Image? originalImage = img.decodeImage(Uint8List.fromList(imageBytes));

  if (originalImage == null) {
    if (kDebugMode) {
      print("Error: Could not decode image ${input.pickedFilePath}");
    }
    if (kDebugMode) {
      print("DEBUG: _processImageIsolate returning null due to originalImage being null.");
    }
    return null;
  }

  // Apply rotation first
  img.Image? rotatedImage = originalImage;
  if (input.rotationAngle != 0) {
    rotatedImage = img.copyRotate(originalImage, angle: input.rotationAngle);
  }

  // All image processing logic (cropping, resizing, encoding) is Pure Dart and fine here.
  double currentAspectRatio = rotatedImage.width / rotatedImage.height;
  double targetAspectRatio = 4.0 / 3.0;
  const double tolerance = 0.01;
  bool needsCrop = false;

  int cropX = 0;
  int cropY = 0;
  int cropWidth = rotatedImage.width;
  int cropHeight = rotatedImage.height;

  if ((currentAspectRatio - targetAspectRatio).abs() > tolerance) {
    needsCrop = true;
    if (currentAspectRatio > targetAspectRatio) {
      cropWidth = (rotatedImage.height * targetAspectRatio).round();
      cropX = ((rotatedImage.width - cropWidth) / 2).round();
    } else {
      cropHeight = (rotatedImage.width / targetAspectRatio).round();
      cropY = ((rotatedImage.height - cropHeight) / 2).round();
    }
  }

  img.Image? processedImage = rotatedImage;
  if (needsCrop) {
    processedImage = img.copyCrop(rotatedImage, x: cropX, y: cropY, width: cropWidth, height: cropHeight);
  }

  const int maxWidth = 1200;
  if (processedImage.width > maxWidth) {
    processedImage = img.copyResize(processedImage, width: maxWidth);
  }

  String finalImagePath;
  List<int> processedBytes;
  String extension = input.pickedFileName.split('.').last.toLowerCase();
  int jpgQuality = 70; // Default quality
  final originalFileSize = imageFile.lengthSync(); // Get original file size in bytes

  if (originalFileSize > 2 * 1024 * 1024) { // If original file size > 2MB
    jpgQuality = 50;
  }
  if (originalFileSize > 4 * 1024 * 1024) { // If original file size > 4MB
    jpgQuality = 30;
  }

  if (extension == 'png') {
    processedBytes = img.encodePng(processedImage);
  } else if (extension == 'gif') {
    processedBytes = img.encodeGif(processedImage);
  } else {
    processedBytes = img.encodeJpg(processedImage, quality: jpgQuality);
    if (extension != 'jpg' && extension != 'jpeg') extension = 'jpg';
  }

  try {
    final String directoryPath = input.tempPath;
    final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
    
    String finalExtension = extension;
    if (extension == 'png') {
      // already png
    } else if (extension == 'gif') {
      // already gif
    } else {
      finalExtension = 'jpg'; 
    }

    final String newFileName = '${timestamp}_compressed.$finalExtension';
    finalImagePath = '$directoryPath${Platform.pathSeparator}$newFileName';
    final File newProcessedFile = File(finalImagePath);
    await newProcessedFile.writeAsBytes(processedBytes);
    if (kDebugMode) {
      print('Processed image saved to: $finalImagePath');
      final int fileSize = await newProcessedFile.length();
      print('Compressed file size: ${fileSize / 1024} KB');
    }
    return finalImagePath;
  } catch (e) {
    if (kDebugMode) {
      print("Error saving processed image in isolate: $e");
    }
    return null;
  }
}

class ImageCaptureAndProcessingUtil {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> processAndSaveImage(XFile pickedFile, {int rotationAngle = 0}) async {
    final directory = await getTemporaryDirectory();
    final String tempPath = directory.path;

    return await compute(
      _processImageIsolate,
      _ProcessImageInput(
        pickedFilePath: pickedFile.path,
        pickedFileName: pickedFile.name,
        tempPath: tempPath,
        rotationAngle: rotationAngle,
      ),
    );
  }

  static Future<XFile> rotateImageIfNecessary(XFile imageFile, double rotationAngle) async {
    // If rotation angle is 0 (or very close to 0), no rotation is needed.
    // Using a small tolerance might be robust if angle calculation isn't always exact.
    if (rotationAngle.abs() < 0.01) { // Example tolerance
      return imageFile;
    }

    try {
      // getTemporaryDirectory must be called from the main isolate.
      final Directory tempDir = await getTemporaryDirectory();
      
      final String? rotatedPath = await compute(
        _rotateImageInIsolate,
        _RotateImageInput(
          filePath: imageFile.path, // Corrected: Pass imageFile.path
          rotationAngle: rotationAngle, // Corrected: Pass rotationAngle
          tempPath: tempDir.path,
        ),
      );

      // Check if a new path was returned and it's different from the original
      if (rotatedPath != null && rotatedPath != imageFile.path) {
        if (kDebugMode) {
          print("Image rotation successful. New path: $rotatedPath");
        }
        return XFile(rotatedPath);
      } else if (rotatedPath == imageFile.path) {
        // Isolate determined no rotation was needed or returned original path
        if (kDebugMode) {
          print("Image rotation determined unnecessary by isolate or returned original path.");
        }
        return imageFile;
      } else {
        // Rotation failed in isolate (returned null)
        if (kDebugMode) {
          print("Image rotation in isolate failed or returned null. Using original image.");
        }
        return imageFile; // Fallback to original image
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error setting up or during compute for image rotation: $e");
      }
      return imageFile; // Fallback to original image on error in this function
    }
  }

  static Future<void> saveImageToGallery(XFile imageXFile) async {
    try {
      bool hasAccess = await Gal.hasAccess();
      if (!hasAccess) {
        final accessGranted = await Gal.requestAccess();
        if (!accessGranted) {
          if (kDebugMode) {
            print('Gallery access denied by user.');
          }
          return;
        }
      }

      final directory = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String extension = imageXFile.name.split('.').last.toLowerCase();
      final String newFileName = 'IMG_$timestamp.$extension';
      final String newFilePath = '${directory.path}/$newFileName';

      final File originalFile = File(imageXFile.path);
      final File newFileForGallery = await originalFile.copy(newFilePath);

      if (kDebugMode) {
        print('Attempting to save original camera image to gallery from new path: ${newFileForGallery.path}');
      }
      await Gal.putImage(newFileForGallery.path);
      if (kDebugMode) {
        print('Image successfully saved to gallery via Gal package with new name.');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error saving image to gallery using Gal: $e');
        if (e is GalException) {
          print('GalException type: ${e.type}');
        }
      }
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
  }) async {
    try {
      await ImageCaptureAndProcessingUtil.saveImageToGallery(imageFile);
      final String? processedPath = await ImageCaptureAndProcessingUtil.processAndSaveImage(imageFile);

      if (processedPath != null) {
        final newTambahanImage = TambahanImageData(
          imagePath: processedPath,
          label: defaultLabel,
          needAttention: false,
          category: imageIdentifier,
          isMandatory: false,
          originalRawPath: imageFile.path, // Store the path of the captured image as original
        );
        tambahanImageNotifier.addImage(newTambahanImage);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error processing image in background: $e");
      }
    }
  }
}
