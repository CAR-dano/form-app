import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:camera/camera.dart';
import 'package:flutter/foundation.dart'; // For kDebugMode

final cameraServiceProvider = StateNotifierProvider<CameraService, CameraController?>((ref) {
  return CameraService();
});

class CameraService extends StateNotifier<CameraController?> {
  CameraService() : super(null);

  List<CameraDescription>? _cameras;
  int _currentCameraIndex = 0;

  Future<void> initializeCamera() async {
    if (state != null && state!.value.isInitialized) {
      // Camera is already initialized, no need to re-initialize
      return;
    }

    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        if (kDebugMode) debugPrint("No cameras available.");
        return;
      }

      _currentCameraIndex = _cameras!.indexWhere((camera) => camera.lensDirection == CameraLensDirection.back);
      if (_currentCameraIndex == -1) {
        _currentCameraIndex = 0;
      }

      state = CameraController(
        _cameras![_currentCameraIndex],
        ResolutionPreset.high,
        enableAudio: false,
      );
      await state!.initialize();
    } on CameraException catch (e) {
      if (kDebugMode) {
        debugPrint("Error initializing cameras: $e");
      }
      state = null; // Set state to null on error
      throw Exception('Failed to initialize camera: $e');
    }
  }

  Future<void> switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) {
      return; // No other camera to switch to
    }

    if (state != null) {
      await state!.dispose();
    }

    _currentCameraIndex = (_currentCameraIndex + 1) % _cameras!.length;

    state = CameraController(
      _cameras![_currentCameraIndex],
      ResolutionPreset.high,
      enableAudio: false,
    );

    try {
      await state!.initialize();
    } on CameraException catch (e) {
      if (kDebugMode) {
        debugPrint("Error switching camera: $e");
      }
      state = null; // Set state to null on error
      throw Exception('Failed to switch camera: $e');
    }
  }

  @override
  void dispose() {
    state?.dispose();
    super.dispose();
  }
}
