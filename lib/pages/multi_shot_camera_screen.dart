import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/models/tambahan_image_data.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/utils/image_picker_util.dart';
import 'package:form_app/widgets/custom_message_overlay.dart';

class MultiShotCameraScreen extends ConsumerStatefulWidget {
  final String imageIdentifier;
  final String defaultLabel;

  const MultiShotCameraScreen({
    super.key,
    required this.imageIdentifier,
    this.defaultLabel = '',
  });

  @override
  ConsumerState<MultiShotCameraScreen> createState() =>
      _MultiShotCameraScreenState();
}

class _MultiShotCameraScreenState extends ConsumerState<MultiShotCameraScreen>
    with WidgetsBindingObserver {
  late List<CameraDescription> _cameras;
  CameraController? _controller;
  int _selectedCameraIndex = 0;
  int _picturesTaken = 0;
  FlashMode _currentFlashMode = FlashMode.off;
  double _currentZoomLevel = 1.0;
  double _minZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _initializeCamera();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? cameraController = _controller;
    if (cameraController == null || !cameraController.value.isInitialized) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      cameraController.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _initializeCamera(
          cameraIndex: _selectedCameraIndex); // Re-initialize with the selected camera
    }
  }

  Future<void> _initializeCamera({int cameraIndex = 0}) async {
    _cameras = await availableCameras();
    if (_cameras.isEmpty) {
      // Handle case where no cameras are available
      return;
    }
    // Ensure the index is valid
    _selectedCameraIndex =
        cameraIndex < _cameras.length ? cameraIndex : 0;

    final newController =
        CameraController(_cameras[_selectedCameraIndex], ResolutionPreset.max, enableAudio: false);

    _controller?.dispose();
    _controller = newController;

    try {
      await _controller!.initialize();
      // After initialization, get zoom levels
      _minZoomLevel = await _controller!.getMinZoomLevel();
      _maxZoomLevel = await _controller!.getMaxZoomLevel();
      
      // Set initial flash mode
      await _controller!.setFlashMode(_currentFlashMode);

      if (mounted) {
        setState(() {});
      }
    } on CameraException catch (e) {
      if (mounted) {
        CustomMessageOverlay(context).show(
          message: 'Error initializing camera: ${e.description}',
          backgroundColor: Colors.red,
          icon: Icons.error,
        );
      }
    }
  }

  Future<void> _onTakePicture() async {
    if (_controller == null || !_controller!.value.isInitialized || _controller!.value.isTakingPicture) {
      return;
    }

    try {
      if (mounted) {
        setState(() {
          _picturesTaken++;
        });
      }

      final XFile imageFile = await _controller!.takePicture();

      // Get notifiers before the async operation that might outlive the widget
      final imageProcessingNotifier = ref.read(imageProcessingServiceProvider.notifier);
      final tambahanImageNotifier = ref.read(tambahanImageDataProvider(widget.imageIdentifier).notifier);

      // Fire-and-forget the processing
      _processAndAddImage(
        imageFile,
        imageProcessingNotifier,
        tambahanImageNotifier,
        widget.defaultLabel,
        widget.imageIdentifier,
      );
    } on CameraException catch (e) {
      if (mounted) {
        CustomMessageOverlay(context).show(
          message: 'Error taking picture: ${e.description}',
          backgroundColor: Colors.red,
          icon: Icons.error,
        );
      }
    }
  }

  Future<void> _processAndAddImage(
    XFile imageFile,
    ImageProcessingService imageProcessingNotifier,
    TambahanImageDataListNotifier tambahanImageNotifier,
    String defaultLabel,
    String imageIdentifier,
  ) async {
    imageProcessingNotifier.taskStarted();
    try {
      await ImagePickerUtil.saveImageToGallery(imageFile);
      final String? processedPath =
          await ImagePickerUtil.processAndSaveImage(imageFile);

      if (processedPath != null) {
        final newTambahanImage = TambahanImageData(
          imagePath: processedPath,
          label: defaultLabel,
          needAttention: false,
          category: imageIdentifier,
          isMandatory: false,
        );
        tambahanImageNotifier.addImage(newTambahanImage);
      }
    } catch (e) {
      // Log error, but don't show overlay as there's no BuildContext
      if (kDebugMode) {
        print("Error processing image in background: $e");
      }
    } finally {
      imageProcessingNotifier.taskFinished();
    }
  }
  
  void _onFlipCamera() {
    if (_cameras.length > 1) {
      // Find the index of the first camera with a different lens direction
      final currentLensDirection = _cameras[_selectedCameraIndex].lensDirection;
      int newIndex = _cameras.indexWhere((cam) => cam.lensDirection != currentLensDirection);
      if (newIndex == -1) newIndex = 0; // Fallback to the first camera
      
      _initializeCamera(cameraIndex: newIndex);
    }
  }

  void _onToggleFlash() {
    setState(() {
      if (_currentFlashMode == FlashMode.off) {
        _currentFlashMode = FlashMode.auto;
      } else if (_currentFlashMode == FlashMode.auto) {
        _currentFlashMode = FlashMode.always;
      } else {
        _currentFlashMode = FlashMode.off;
      }
    });
    _controller?.setFlashMode(_currentFlashMode);
  }

  IconData _getFlashIcon() {
    switch (_currentFlashMode) {
      case FlashMode.auto:
        return Icons.flash_auto;
      case FlashMode.always:
        return Icons.flash_on;
      case FlashMode.off:
      default:
        return Icons.flash_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      return const Scaffold(
          backgroundColor: Colors.black,
          body: Center(child: CircularProgressIndicator()));
    }
    return Scaffold(
      backgroundColor: Colors.black,
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Stack(
          children: [
            Center(
              child: _buildCameraPreview(),
            ),
            _buildControlsOverlay(),
          ],
        ),
      ),
    );
  }  Widget _buildCameraPreview() {
    final Size screenSize = MediaQuery.of(context).size;
    final double cameraAspectRatio = _controller!.value.aspectRatio;
    
    // Calculate scale depending on screen and camera ratios
    // This is actually screenSize.aspectRatio / (1 / cameraAspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    var scale = screenSize.aspectRatio * cameraAspectRatio;
    
    // To prevent scaling down, invert the value
    if (scale < 1) scale = 1 / scale;
    
    return SizedBox(
      width: screenSize.width,
      height: screenSize.width / (3.0 / 4.0), // 3:4 aspect ratio using full width
      child: ClipRect(
        child: Transform.scale(
          scale: scale,
          child: Center(
            child: CameraPreview(_controller!),
          ),
        ),
      ),
    );
  }

  Widget _buildControlsOverlay() {
    return Column(
      children: [
        // Top controls: Close, Flash, Camera Switch
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildControlButton(Icons.close, () => Navigator.of(context).pop()), // Revert to original pop
                 Row(
                   children: [
                     _buildControlButton(_getFlashIcon(), _onToggleFlash),
                     const SizedBox(width: 16),
                     if (_cameras.length > 1) _buildControlButton(Icons.flip_camera_ios, _onFlipCamera),
                   ],
                 )
              ],
            ),
          ),
        ),
        const Spacer(),
        // Bottom controls: Zoom Slider, Capture Button, Picture Count
        Padding(
          padding: const EdgeInsets.only(bottom: 30.0),
          child: Column(
            children: [
              if (_maxZoomLevel > _minZoomLevel)
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.7,
                  child: Slider(
                    value: _currentZoomLevel,
                    min: _minZoomLevel,
                    max: _maxZoomLevel,
                    activeColor: Colors.white,
                    inactiveColor: Colors.white30,
                    onChanged: (value) async {
                      setState(() {
                        _currentZoomLevel = value;
                      });
                      await _controller!.setZoomLevel(value);
                    },
                  ),
                ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 60), // Spacer
                  _buildCaptureButton(),
                  SizedBox(
                    width: 60,
                    child: Text(
                      '$_picturesTaken',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }

  Widget _buildControlButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black.withAlpha((255 * 0.4).round()),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        icon: Icon(icon, color: Colors.white, size: 24),
        onPressed: onPressed,
      ),
    );
  }

  Widget _buildCaptureButton() {
    return InkWell(
      onTap: _onTakePicture,
      child: Container(
        width: 70,
        height: 70,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.transparent,
          border: Border.all(color: Colors.white, width: 4),
        ),
        child: Center(
          child: Container(
            width: 58,
            height: 58,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.white,
            ),
          ),
        ),
      ),
    );
  }
}
