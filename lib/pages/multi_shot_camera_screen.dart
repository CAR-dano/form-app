  import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/utils/image_picker_util.dart';

class MultiShotCameraScreen extends ConsumerStatefulWidget {
  final String imageIdentifier; // To know which provider instance to use

  const MultiShotCameraScreen({super.key, required this.imageIdentifier});

  @override
  ConsumerState<MultiShotCameraScreen> createState() => _MultiShotCameraScreenState();
}

class _MultiShotCameraScreenState extends ConsumerState<MultiShotCameraScreen> {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  int _picturesTaken = 0;

  @override
  void initState() {
    super.initState();
    _initializeCamera();
  }

  Future<void> _initializeCamera() async {
    _cameras = await availableCameras();
    if (_cameras.isNotEmpty) {
      _controller = CameraController(_cameras[0], ResolutionPreset.high);
      await _controller!.initialize();
      if (mounted) {
        setState(() {});
      }
    }
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  Future<void> _onTakePicture() async {
    if (_controller == null || !_controller!.value.isInitialized) {
      return;
    }

    // Show a quick flash animation
    _controller!.setFlashMode(FlashMode.auto);
    await Future.delayed(const Duration(milliseconds: 100));
    _controller!.setFlashMode(FlashMode.off);

    final XFile imageFile = await _controller!.takePicture();

    // Process the image in the background
    _processAndAddImage(imageFile);

    setState(() {
      _picturesTaken++;
    });
  }

  Future<void> _processAndAddImage(XFile imageFile) async {
    ref.read(imageProcessingServiceProvider.notifier).taskStarted();
    try {
      await ImagePickerUtil.saveImageToGallery(imageFile);
      final String? processedPath = await ImagePickerUtil.processAndSaveImage(imageFile);

      if (mounted && processedPath != null) {
        final newTambahanImage = TambahanImageData(
          imagePath: processedPath,
          label: '', // Start with an empty label
          needAttention: false,
          category: widget.imageIdentifier,
          isMandatory: false, // Or based on your logic
        );
        ref.read(tambahanImageDataProvider(widget.imageIdentifier).notifier).addImage(newTambahanImage);
      }
    } catch (e) {
      // Handle error
    } finally {
      ref.read(imageProcessingServiceProvider.notifier).taskFinished();
    }
  }


  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Positioned.fill(
            child: CameraPreview(_controller!),
          ),
          // Close Button
          Positioned(
            top: 40,
            left: 20,
            child: IconButton(
              icon: const Icon(Icons.close, color: Colors.white, size: 30),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          // Picture Count
           Positioned(
            top: 40,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.black.withAlpha((255 * 0.5).round()),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                '$_picturesTaken Foto',
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
          // Capture Button
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: Align(
              alignment: Alignment.center,
              child: InkWell(
                onTap: _onTakePicture,
                child: Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                    border: Border.all(color: Colors.grey, width: 4),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
