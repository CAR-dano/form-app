import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:gal/gal.dart';

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
}
