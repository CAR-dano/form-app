import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:image_picker/image_picker.dart'; // For gallery access
import 'package:form_app/utils/image_picker_util.dart'; // Import ImagePickerUtil

class CustomCameraScreen extends StatefulWidget {
  final ValueNotifier<CameraController?> controllerNotifier; // Change to ValueNotifier
  final VoidCallback onCameraSwitchPressed; // New callback for camera switch

  const CustomCameraScreen({
    super.key,
    required this.controllerNotifier, // Make it required
    required this.onCameraSwitchPressed, // Make it required
  });

  @override
  State<CustomCameraScreen> createState() => _CustomCameraScreenState();
}

class _CustomCameraScreenState extends State<CustomCameraScreen> {
  CameraController? _controller; // Make it nullable
  bool _isFlashOn = false;
  bool _isManualCapture = true; // Default to Manual capture

  @override
  void initState() {
    super.initState();
    _controller = widget.controllerNotifier.value; // Get initial controller

    // Listen to changes in the controller notifier
    widget.controllerNotifier.addListener(_onControllerNotifierChanged);

    _controller?.addListener(_onCameraControllerChanged); // Listen to controller's value changes
  }

  void _onControllerNotifierChanged() {
    if (_controller != widget.controllerNotifier.value) {
      // Dispose old controller listeners if controller changes
      _controller?.removeListener(_onCameraControllerChanged);
      _controller = widget.controllerNotifier.value;
      _controller?.addListener(_onCameraControllerChanged);
      if (mounted) {
        setState(() {}); // Rebuild when controller changes
      }
    }
  }

  void _onCameraControllerChanged() {
    if (mounted) {
      setState(() {});
    }
    if (_controller?.value.hasError ?? false) {
      // Handle camera errors
      if (kDebugMode) {
        print('Camera error: ${_controller!.value.errorDescription}');
      }
    }
  }

  @override
  void dispose() {
    widget.controllerNotifier.removeListener(_onControllerNotifierChanged); // Remove listener
    _controller?.removeListener(_onCameraControllerChanged); // Remove controller listener
    // The controller is managed by the calling widget, so we don't dispose it here.
    super.dispose();
  }

  Future<void> _toggleFlash() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }
    try {
      final newFlashMode = _isFlashOn ? FlashMode.off : FlashMode.torch;
      await _controller!.setFlashMode(newFlashMode);
      setState(() {
        _isFlashOn = !_isFlashOn;
      });
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error toggling flash: $e');
      }
    }
  }

  Future<void> _takePicture() async {
    if (_controller == null || !_controller!.value.isInitialized || _controller!.value.isTakingPicture) {
      return;
    }

    try {
      final XFile image = await _controller!.takePicture();
      
      // Process and save the image using ImagePickerUtil
      final String? processedPath = await ImagePickerUtil.processAndSaveImage(image);

      if (mounted) {
        if (processedPath != null) {
          Navigator.pop(context, processedPath);
        } else {
          if (kDebugMode) {
            print("Image processing failed in CustomCameraScreen.");
          }
          // Optionally show a snackbar or error message
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Gagal memproses gambar.'))
          );
          Navigator.pop(context); // Pop without returning a path on failure
        }
      }
    } on CameraException catch (e) {
      if (kDebugMode) {
        print('Error taking picture: $e');
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat mengambil gambar: $e'))
        );
        Navigator.pop(context); // Pop on error
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
    // No loading indicator needed, as controller is passed already initialized.
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // Camera Preview
          Positioned.fill(
            child: _controller != null && _controller!.value.isInitialized
                ? AspectRatio(
                    aspectRatio: 4 / 3, // Set aspect ratio to 4:3
                    child: CameraPreview(_controller!),
                  )
                : const Center(child: CircularProgressIndicator()), // Show loading indicator or black screen
          ),

          // Top controls (Close and Flash)
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

          // Bottom controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.black.withAlpha(128), // Semi-transparent background for controls (replaces withOpacity)
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  // Manual/Auto Capture Toggle
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
                      // Gallery Button
                      IconButton(
                        icon: const Icon(Icons.image, color: Colors.white, size: 40),
                        onPressed: _pickImageFromGallery,
                      ),
                      // Capture Button
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
                      // Camera switch button
                      IconButton(
                        icon: const Icon(Icons.cameraswitch, color: Colors.white, size: 40),
                        onPressed: widget.onCameraSwitchPressed, // Call the callback
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
