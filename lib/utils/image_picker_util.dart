import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:gal/gal.dart';
// Ensure ImagePicker is imported

class ImagePickerUtil {
  static final ImagePicker _picker = ImagePicker();

  static Future<String?> processAndSaveImage(XFile pickedFile) async {
    final File imageFile = File(pickedFile.path);
    List<int> imageBytes = await imageFile.readAsBytes();
    img.Image? originalImage = img.decodeImage(Uint8List.fromList(imageBytes));

    if (originalImage == null) {
      if (kDebugMode) {
        print("Error: Could not decode image ${pickedFile.path}");
      }
      return null;
    }

    double currentAspectRatio = originalImage.width / originalImage.height;
    double targetAspectRatio = 4.0 / 3.0;
    const double tolerance = 0.01;
    bool needsCrop = false;

    int cropX = 0;
    int cropY = 0;
    int cropWidth = originalImage.width;
    int cropHeight = originalImage.height;

    if ((currentAspectRatio - targetAspectRatio).abs() > tolerance) {
      needsCrop = true;
      if (currentAspectRatio > targetAspectRatio) {
        cropWidth = (originalImage.height * targetAspectRatio).round();
        cropX = ((originalImage.width - cropWidth) / 2).round();
      } else {
        cropHeight = (originalImage.width / targetAspectRatio).round();
        cropY = ((originalImage.height - cropHeight) / 2).round();
      }
    }

    img.Image? processedImage = originalImage;
    if (needsCrop) {
      processedImage = img.copyCrop(originalImage, x: cropX, y: cropY, width: cropWidth, height: cropHeight);
    }

    const int maxWidth = 1200;
    if (processedImage.width > maxWidth) {
      processedImage = img.copyResize(processedImage, width: maxWidth);
    }

    String finalImagePath = pickedFile.path;
    List<int> processedBytes;
    String extension = pickedFile.name.split('.').last.toLowerCase();
    if (extension == 'png') {
      processedBytes = img.encodePng(processedImage);
    } else if (extension == 'gif') {
      processedBytes = img.encodeGif(processedImage);
    } else {
      processedBytes = img.encodeJpg(processedImage, quality: 70);
      if (extension != 'jpg' && extension != 'jpeg') extension = 'jpg';
    }

    try {
      final directory = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      
      // Ensure the extension is consistent with the processed bytes
      String finalExtension = extension;
      if (extension == 'png') {
        // already png
      } else if (extension == 'gif') {
        // already gif
      } else {
        finalExtension = 'jpg'; // Default to jpg if not png/gif
      }

      // Generate a new filename using timestamp and '_compressed' suffix
      final String newFileName = '${timestamp}_compressed.$finalExtension';
      finalImagePath = '${directory.path}${Platform.pathSeparator}$newFileName';
      final File newProcessedFile = File(finalImagePath);
      await newProcessedFile.writeAsBytes(processedBytes);
      if (kDebugMode) {
        print('Processed image saved to: $finalImagePath');
        final int fileSize = await newProcessedFile.length();
        print('Compressed file size: ${fileSize / 1024} KB');
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error saving processed image: $e");
      }
      return null;
    }
    return finalImagePath;
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

      // Generate a shorter, unique filename for the original image
      final directory = await getTemporaryDirectory();
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      String extension = imageXFile.name.split('.').last.toLowerCase();
      final String newFileName = 'IMG_$timestamp.$extension'; // e.g., IMG_16789012345.jpg
      final String newFilePath = '${directory.path}/$newFileName';

      // Copy the original image to the new path
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
