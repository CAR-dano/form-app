import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:form_app/utils/image_picker_util.dart';
import 'package:form_app/providers/camera_provider.dart'; // Import the new provider
import 'package:flutter/foundation.dart'; // For kDebugMode

class CustomCameraScreen extends ConsumerStatefulWidget {
  const CustomCameraScreen({super.key});

  @override
  ConsumerState<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends ConsumerState<CustomCameraScreen> {
  bool _isFlashOn = false;
  bool _isManualCapture = true;

  @override
  void initState() {
    super.initState();
    // Initialize camera when the screen is opened
    _initializeCameraForScreen();
  }

  Future<void> _initializeCameraForScreen() async {
    final cameraService = ref.read(cameraServiceProvider.notifier);
    try {
      await cameraService.initializeCamera();
      if (mounted) {
        setState(() {}); // Rebuild to show camera preview
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to initialize camera: $e'))
        );
        Navigator.pop(context); // Pop on error
      }
    }
  }

  @override
  void dispose() {
    // Dispose the camera controller when the screen is disposed
    ref.read(cameraServiceProvider.notifier).dispose();
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    final controller = ref.read(cameraServiceProvider);
    if (controller == null || !controller.value.isInitialized) {
      return;
    }
    try {
      final newFlashMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
      await controller.setFlashMode(newFlashMode);
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } on CameraException catch (e) {
      if (kDebugMode) {
        debugPrint('Error toggling flash: $e');
      }
    }
  }

  Future<void> _takePicture() async {
    final controller = ref.read(cameraServiceProvider);
    if (controller == null || !controller.value.isInitialized || controller.value.isTakingPicture) {
      return;
    }

    try {
      final XFile image = await controller.takePicture();
      
      final String? processedPath = await ImagePickerUtil.processAndSaveImage(image);

      if (mounted) {
        if (processedPath != null) {
          Navigator.pop(context, processedPath);
        } else {
          if (kDebugMode) {
            debugPrint("Image processing failed in CustomCameraScreen.");
          }
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal memproses gambar.'))
          );
          Navigator.pop(context);
        }
      }
    } on CameraException catch (e) {
      if (kDebugMode) {
        debugPrint('Error taking picture: $e');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat mengambil gambar: $e'))
        );
        Navigator.pop(context);
      }
    }
  }

  Future<void> _pickImageFromGallery() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null && mounted) {
      Navigator.pop(context, image.path);
    }
  }

  @override
  Widget build(BuildContext context) {
    final cameraController = ref.watch(cameraServiceProvider);

    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: cameraController != null && cameraController.value.isInitialized
                ? AspectRatio(
                    aspectRatio: 4 / 3,
                    child: CameraPreview(cameraController),
                  )
                : const Center(child: CircularProgressIndicator()),
          ),
          Positioned(
            top: 40,
            left: 20,
            right: 20,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: const Icon(Icons.close, color: Colors.white, size: 30),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                IconButton(
                  icon: Icon(
                    _isFlashOn ? Icons.flash_on : Icons.flash_off,
                    color: Colors.white,
                    size: 30,
                  ),
                  onPressed: _toggleFlash,
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withAlpha(128),
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isManualCapture = true;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: _isManualCapture ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Manual',
                              style: TextStyle(
                                color: _isManualCapture ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isManualCapture = false;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                            decoration: BoxDecoration(
                              color: !_isManualCapture ? Colors.white : Colors.transparent,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Text(
                              'Auto capture',
                              style: TextStyle(
                                color: !_isManualCapture ? Colors.black : Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.image, color: Colors.white, size: 40),
                        onPressed: _pickImageFromGallery,
                      ),
                      GestureDetector(
                        onTap: _takePicture,
                        child: Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 3),
                          ),
                          child: const Center(
                            child: Icon(Icons.circle, color: Colors.white, size: 50),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.cameraswitch, color: Colors.white, size: 40),
                        onPressed: () async {
                          await ref.read(cameraServiceProvider.notifier).switchCamera();
                          if (mounted) {
                            setState(() {}); // Rebuild to reflect camera switch
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Text(
                      'Files by Google will have access only to the images you scan',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white70, fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
