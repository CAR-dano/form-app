import 'dart:async';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/message_overlay_provider.dart'; // Import the new provider
import 'package:form_app/services/image_capture_queue_service.dart'; // Import the new service
import 'package:sensors_plus/sensors_plus.dart';
import 'dart:math' show pi;

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
    with WidgetsBindingObserver, TickerProviderStateMixin {
  late List<CameraDescription> _cameras = []; // Initialize as empty
  CameraController? _controller;
  int _selectedCameraIndex = 0; // Default to 0
  int _picturesTaken = 0;
  FlashMode _currentFlashMode = FlashMode.off;
  double _currentZoomLevel = 1.0;
  double _minZoomLevel = 1.0;
  double _maxZoomLevel = 1.0;
  double _rotationAngle = 0.0; // Added for rotation
  StreamSubscription<AccelerometerEvent>? _accelerometerSubscription; // Added for rotation

  late AnimationController _captureAnimationController;
  late Animation<double> _captureOpacityAnimation;
  late AnimationController _buttonScaleAnimationController;
  late Animation<double> _buttonScaleAnimation;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _setupCameras(); // New method to discover and initialize the first camera

    _captureAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 0), // Fast flash to black
      reverseDuration: const Duration(milliseconds: 100), // Fade back in
    );
    _captureOpacityAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _captureAnimationController,
        curve: Curves.easeOut,
      ),
    );

    _buttonScaleAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _buttonScaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(
        parent: _buttonScaleAnimationController,
        curve: Curves.easeOut,
      ),
    );

    // Initialize accelerometer listener for rotation
    _accelerometerSubscription =
        accelerometerEventStream(samplingPeriod: SensorInterval.uiInterval)
            .listen((AccelerometerEvent event) {
      if (kDebugMode) {
        print('Accelerometer event: x=${event.x.toStringAsFixed(2)}, y=${event.y.toStringAsFixed(2)}, z=${event.z.toStringAsFixed(2)}');
      }
      final double oldRotationAngle = _rotationAngle;
      setState(() {
        const double threshold = 7.0;

        if (event.y.abs() > threshold && event.x.abs() < threshold) {
          _rotationAngle = 0.0;
        } else if (event.x.abs() > threshold && event.y.abs() < threshold) {
          if (event.x < 0) {
            _rotationAngle = -pi / 2;
          } else {
            _rotationAngle = pi / 2;
          }
        }
        // Only print if the angle actually changed
        if (_rotationAngle != oldRotationAngle) {
          debugPrint('Rotation angle updated: ${_rotationAngle.toStringAsFixed(2)}');
        }
      });
    });
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _controller?.dispose(); // Ensure controller is disposed
    _captureAnimationController.dispose(); // Dispose the new capture animation controller
    _buttonScaleAnimationController.dispose(); // Dispose the button scale animation controller
    _accelerometerSubscription?.cancel(); // Dispose accelerometer subscription
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    final CameraController? currentController = _controller;

    switch (state) {
      case AppLifecycleState.inactive:
      case AppLifecycleState.paused:
      case AppLifecycleState.hidden:
      case AppLifecycleState.detached:
        if (currentController != null && currentController.value.isInitialized) {
          currentController.dispose();
        }
        // Set _controller to null and call setState to update UI.
        // This ensures the build method shows the blank screen and doesn't use a disposed controller.
        if (mounted) {
          setState(() {
            _controller = null;
          });
        } else {
          _controller = null; // If not mounted, just nullify.
        }
        break;
      case AppLifecycleState.resumed:
        // If _controller is null, it means it was disposed (or never initialized).
        if (_controller == null) {
          if (_cameras.isNotEmpty) {
            // If camera descriptions are already available, select the camera.
            _selectCamera(_selectedCameraIndex);
          } else {
            // Otherwise, (re-)run the full camera setup.
            // _setupCameras will populate _cameras and then call _selectCamera.
            _setupCameras();
          }
        }
        // It's also possible _controller is not null but became uninitialized due to an error
        // or an extremely fast pause/resume cycle before nullification completed.
        // _selectCamera handles re-initialization if the controller is in such a state.
        else if (!_controller!.value.isInitialized) {
            _selectCamera(_selectedCameraIndex);
        }
        break;
    }
  }

  Future<void> _setupCameras() async {
    try {
      final cameras = await availableCameras();
      if (!mounted) return;

      if (cameras.isEmpty) {
        if (mounted) {
          ref.read(customMessageOverlayProvider).show(
            context: context, // Pass context here
            message: 'No cameras available.',
            color: Colors.orange,
            icon: Icons.warning,
          );
        }
        return;
      }
      _cameras = cameras;
      if (kDebugMode) {
        print("Available cameras:");
        for (var i = 0; i < _cameras.length; i++) {
          print("Camera $i: ${_cameras[i].name}, Lens Direction: ${_cameras[i].lensDirection}, Sensor Orientation: ${_cameras[i].sensorOrientation}");
        }
      }

      int initialCameraIndex = _cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.back);
      if (initialCameraIndex == -1) {
        initialCameraIndex = 0; // Fallback to the first camera overall
      }
      
      await _selectCamera(initialCameraIndex);

    } on CameraException catch (e) {
      if (mounted) {
        ref.read(customMessageOverlayProvider).show(
          context: context, // Pass context here
          message: 'Error discovering cameras: ${e.description}',
          color: Colors.red,
          icon: Icons.error,
        );
      }
    }
  }

  Future<void> _selectCamera(int cameraIndex) async {
    if (_cameras.isEmpty) {
      if (kDebugMode) print("Attempted to select camera but _cameras list is empty.");
      // Optionally, trigger _setupCameras if it hasn't run successfully.
      // This could be risky if _setupCameras itself calls _selectCamera leading to a loop.
      // Consider if _setupCameras should be called here if _cameras is empty.
      // For now, if _cameras is empty, we assume _setupCameras is the entry point for camera list population.
      if (_controller == null && mounted) { // If no controller exists at all, try to setup.
          await _setupCameras();
          // If _setupCameras populates _cameras and calls _selectCamera, this call might be redundant
          // or could lead to issues if not handled carefully.
          // For simplicity, let's assume _setupCameras is the entry point for camera list population.
      }
      return;
    }
    if (cameraIndex < 0 || cameraIndex >= _cameras.length) {
      if (kDebugMode) print("Invalid cameraIndex: $cameraIndex for _cameras length: ${_cameras.length}");
      return;
    }

    // Update _selectedCameraIndex immediately, possibly within setState if UI depends on it directly
    // setState is called later after successful initialization or for error display.
    _selectedCameraIndex = cameraIndex;


    final newController = CameraController(
      _cameras[_selectedCameraIndex],
      ResolutionPreset.max,
      enableAudio: false,
      imageFormatGroup: ImageFormatGroup.jpeg,
    );

    final CameraController? oldController = _controller;
    _controller = newController; // Assign new controller to be used by the UI

    await oldController?.dispose(); // Dispose the old controller

    try {
      await newController.initialize();
      if (!mounted) { // Check mounted status after await
        await newController.dispose(); // Dispose if not mounted
        _controller = null; // Ensure controller is null if disposed
        return;
      }

      _minZoomLevel = await newController.getMinZoomLevel();
      _maxZoomLevel = await newController.getMaxZoomLevel();
      _currentZoomLevel = 1.0; // Reset zoom on camera switch
      await newController.setZoomLevel(_currentZoomLevel);
      await newController.setFlashMode(_currentFlashMode); // Re-apply flash mode

      if (mounted) {
        setState(() {}); // Refresh UI
      }
    } on CameraException catch (e) {
      if (mounted) {
        ref.read(customMessageOverlayProvider).show(
          context: context, // Pass context here
          message: 'Error initializing camera: ${e.description}',
          color: Colors.red,
          icon: Icons.error,
        );
      }
      // If initialization fails, newController might be unusable.
      // oldController is already disposed. Set _controller to null.
      _controller = null;
      if (mounted) {
        setState(() {}); // Refresh UI to show loading/error state
      }
    }
  }


  Future<void> _onTakePicture() async {
    final controller = _controller;
    if (controller == null || !controller.value.isInitialized || controller.value.isTakingPicture) {
      return;
    }

    try {
      final XFile capturedImageFile = await controller.takePicture();

      // Trigger the flash animation and increment counter after picture is taken
      if (mounted) {
        _captureAnimationController.forward(from: 0.0).then((_) {
          if (mounted) {
            _captureAnimationController.reverse();
          }
        });
        setState(() => _picturesTaken++);
      }

      // Capture the rotation angle at the moment the picture is taken.
      final double capturedRotationAngle = _rotationAngle;

      // Add the image capture task to the queue service
      ref.read(imageCaptureQueueServiceProvider.notifier).addImageCaptureTask(
        capturedImageFile: capturedImageFile,
        capturedRotationAngle: capturedRotationAngle,
        imageIdentifier: widget.imageIdentifier,
        defaultLabel: widget.defaultLabel,
      );

    } on CameraException catch (e) {
      if (mounted) {
        ref.read(customMessageOverlayProvider).show(
          context: context, // Pass context here
          message: 'Error taking picture: ${e.description}',
          color: Colors.red,
          icon: Icons.error,
        );
      }
    }
  }
  
  void _onFlipCamera() {
    if (_cameras.isEmpty || _cameras.length == 1) return;

    int targetIndex = -1;
    final currentLensDirection = _cameras[_selectedCameraIndex].lensDirection;

    if (currentLensDirection == CameraLensDirection.front) {
        // Currently front, switch to primary back (first back camera found)
        targetIndex = _cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.back);
    } else { // Covers back and external
        // Currently back or external, switch to primary front (first front camera found)
        targetIndex = _cameras.indexWhere((c) => c.lensDirection == CameraLensDirection.front);
    }

    // If the desired opposite isn't found (e.g., only back cameras or only front cameras)
    // and there are multiple cameras, then cycle to the next camera.
    if (targetIndex == -1) {
        targetIndex = (_selectedCameraIndex + 1) % _cameras.length;
    }
    
    if (targetIndex != _selectedCameraIndex) {
        _selectCamera(targetIndex);
    }
  }

  void _onSwitchLens() {
    if (_cameras.isEmpty) return;

    final List<MapEntry<int, CameraDescription>> backCamerasWithIndices = _cameras
        .asMap()
        .entries
        .where((entry) => entry.value.lensDirection == CameraLensDirection.back)
        .toList();

    if (backCamerasWithIndices.length <= 1) {
      // No other back lenses to switch to, or only one back camera
      return;
    }

    final currentOverallIndex = _selectedCameraIndex;
    final currentCamera = _cameras[currentOverallIndex];
    int nextOverallIndex = -1;

    if (currentCamera.lensDirection == CameraLensDirection.back) {
      int currentIndexInBackList = backCamerasWithIndices.indexWhere((entry) => entry.key == currentOverallIndex);
      if (currentIndexInBackList != -1) {
        int nextIndexInBackList = (currentIndexInBackList + 1) % backCamerasWithIndices.length;
        nextOverallIndex = backCamerasWithIndices[nextIndexInBackList].key;
      } else {
        // Fallback: current camera is back but not in list (should not happen), switch to first back.
        nextOverallIndex = backCamerasWithIndices.first.key;
      }
    } else {
      // Current camera is not back (e.g., front or external), switch to the first back camera.
      nextOverallIndex = backCamerasWithIndices.first.key;
    }

    if (nextOverallIndex != -1 && nextOverallIndex != _selectedCameraIndex) {
      _selectCamera(nextOverallIndex);
    }
  }

  void _onToggleFlash() {
    setState(() {
      if (_currentFlashMode == FlashMode.off) {
        _currentFlashMode = FlashMode.auto;
      } else if (_currentFlashMode == FlashMode.auto) {
        _currentFlashMode = FlashMode.always;
      } else if (_currentFlashMode == FlashMode.always) {
        _currentFlashMode = FlashMode.torch; // New mode: flash always on (torch)
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
      case FlashMode.torch: // Icon for the new torch mode
        return Icons.highlight; // Or Icons.flashlight_on
      case FlashMode.off:
      return Icons.flash_off;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_controller == null || !_controller!.value.isInitialized) {
      // Show a blank screen or a simple placeholder while the camera is initializing
      // instead of a loading indicator.
      return Scaffold(
        backgroundColor: Colors.black, // Or any other appropriate background color
        body: Container(), // Empty container, effectively showing a blank screen
      );
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
    // final double cameraAspectRatio = _controller!.value.aspectRatio; // Original line, not needed if scale is 1.0

    // Calculate scale depending on screen and camera ratios
    // This is actually screenSize.aspectRatio / (1 / cameraAspectRatio)
    // because camera preview size is received as landscape
    // but we're calculating for portrait orientation
    // var scale = screenSize.aspectRatio * cameraAspectRatio; // Original line
    
    // To prevent scaling down, invert the value
    // if (scale < 1) scale = 1 / scale; // Original line

    // The SizedBox defines a 3:4 aspect ratio viewport.
    // The CameraPreview, if the camera is 4:3 (which results in a 3:4 portrait preview),
    // should fit this viewport correctly with a scale of 1.0.
    const double scale = 1.0;
    
    return SizedBox(
      width: screenSize.width,
      height: screenSize.width / (3.0 / 4.0), // 3:4 aspect ratio using full width
      child: ClipRect(
        child: Transform.scale(
          scale: scale, // Adjusted scale to prevent zoom
          child: Center(
            child: AnimatedBuilder(
              animation: _captureOpacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: _captureOpacityAnimation.value,
                  child: CameraPreview(_controller!),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildControlsOverlay() {
    final int backCameraCount = _cameras.where((c) => c.lensDirection == CameraLensDirection.back).length;

    return Column(
      children: [
        // Top controls: Close, Flash, Camera Switch
        SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row( // Group Close and Flash buttons
                  children: [
                    AnimatedRotation(
                      turns: _rotationAngle / (2 * pi),
                      duration: const Duration(milliseconds: 300),
                      child: _buildControlButton(Icons.arrow_back, () => Navigator.of(context).pop()),
                    ),
                    AnimatedRotation(
                      turns: _rotationAngle / (2 * pi),
                      duration: const Duration(milliseconds: 300),
                      child: _buildControlButton(_getFlashIcon(), _onToggleFlash),
                    ),
                  ],
                ),
                 Row( // Group Lens Switch and Flip Camera buttons
                   children: [
                     if (backCameraCount > 1) ...[
                       AnimatedRotation(
                         turns: _rotationAngle / (2 * pi),
                         duration: const Duration(milliseconds: 300),
                         child: _buildControlButton(Icons.switch_camera_outlined, _onSwitchLens), // Lens switch
                       ),
                       const SizedBox(width: 16), // Spacing
                     ],
                     if (_cameras.length > 1) ...[ // Flip camera
                       AnimatedRotation(
                         turns: _rotationAngle / (2 * pi),
                         duration: const Duration(milliseconds: 300),
                         child: _buildControlButton(Icons.flip_camera_ios, _onFlipCamera),
                       ),
                     ]
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
                  SizedBox(
                    width: 60,
                    child: AnimatedRotation(
                      turns: _rotationAngle / (2 * pi),
                      duration: const Duration(milliseconds: 300),
                      child: Text(
                        '$_picturesTaken',
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  _buildCaptureButton(),
                  AnimatedRotation(
                    turns: _rotationAngle / (2 * pi),
                    duration: const Duration(milliseconds: 300),
                    child: _buildControlButton(Icons.check, () => Navigator.of(context).pop()),
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
    return Material(
      color: Colors.transparent,
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: _onTakePicture,
        onTapDown: (_) => _buttonScaleAnimationController.forward(),
        onTapUp: (_) => _buttonScaleAnimationController.reverse(),
        onTapCancel: () => _buttonScaleAnimationController.reverse(),
        borderRadius: BorderRadius.circular(35.0), // Half of the button's width/height
        child: Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.transparent,
            border: Border.all(color: Colors.white, width: 4),
          ),
          child: Center(
            child: ScaleTransition(
              scale: _buttonScaleAnimation,
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
        ),
      ),
    );
  }
}
