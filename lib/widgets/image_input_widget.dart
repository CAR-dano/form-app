import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/statics/app_styles.dart';
import 'dart:io';
import 'package:camera/camera.dart'; // Import camera package
// For kDebugMode
import 'package:flutter/foundation.dart'; // Ensure kDebugMode is available
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/image_data_provider.dart';
import 'package:form_app/models/image_data.dart';
import 'package:form_app/widgets/delete_confirmation_dialog.dart';
import 'package:form_app/widgets/image_preview_dialog.dart';
import 'package:form_app/utils/image_picker_util.dart';
import 'package:form_app/providers/image_processing_provider.dart'; // Import the new provider
import 'package:form_app/pages/custom_camera_screen.dart'; // Import CustomCameraScreen

class ImageInputWidget extends ConsumerStatefulWidget {
  final String label;
  final ValueChanged<File?>? onImagePicked;

  const ImageInputWidget({
    super.key,
    required this.label,
    this.onImagePicked,
  });

  @override
  ConsumerState<ImageInputWidget> createState() => _ImageInputWidgetState();
}

class _ImageInputWidgetState extends ConsumerState<ImageInputWidget> {
  List<CameraDescription>? _cameras;
  ValueNotifier<CameraController?>? _cameraControllerNotifier;
  int _currentCameraIndex = 0; // Track selected camera index

  @override
  void initState() {
    super.initState();
    _cameraControllerNotifier = ValueNotifier(null); // Initialize the notifier
    _initializeCameras(); // Initialize cameras when widget starts
  }

  Future<void> _initializeCameras() async {
    try {
      _cameras = await availableCameras();
      if (_cameras == null || _cameras!.isEmpty) {
        if (kDebugMode) debugPrint("No cameras available.");
        return;
      }

      // Find the index of the rear camera, or default to the first camera
      _currentCameraIndex = _cameras!.indexWhere((camera) => camera.lensDirection == CameraLensDirection.back);
      if (_currentCameraIndex == -1) {
        _currentCameraIndex = 0; // Fallback to the first available camera
      }

      _cameraControllerNotifier!.value = CameraController(
        _cameras![_currentCameraIndex],
        ResolutionPreset.high, // Keep high resolution for now, aspect ratio is handled in CustomCameraScreen
        enableAudio: false,
      );
      await _cameraControllerNotifier!.value!.initialize();
      if (mounted) {
        setState(() {}); // Rebuild to show camera preview if needed
      }
    } on CameraException catch (e) {
      if (kDebugMode) {
        debugPrint("Error initializing cameras: $e");
      }
      // Handle error, e.g., show a message to the user
    }
  }

  Future<void> _switchCamera() async {
    if (_cameras == null || _cameras!.length < 2) {
      // No other camera to switch to
      return;
    }

    if (_cameraControllerNotifier!.value != null) {
      await _cameraControllerNotifier!.value!.dispose();
    }

    setState(() {
      _currentCameraIndex = (_currentCameraIndex + 1) % _cameras!.length;
    });

    _cameraControllerNotifier!.value = CameraController(
      _cameras![_currentCameraIndex],
      ResolutionPreset.high, // Keep high resolution for now
      enableAudio: false,
    );

    try {
      await _cameraControllerNotifier!.value!.initialize();
      if (mounted) {
        setState(() {});
      }
    } on CameraException catch (e) {
      if (kDebugMode) {
        debugPrint("Error switching camera: $e");
      }
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Terjadi kesalahan saat mengganti kamera: $e'))
        );
      }
    }
  }

  @override
  void dispose() {
    _cameraControllerNotifier?.value?.dispose(); // Dispose the camera controller
    _cameraControllerNotifier?.dispose(); // Dispose the notifier itself
    super.dispose();
  }

  Future<void> _takePictureFromCamera() async {
    FocusScope.of(context).unfocus();

    if (_cameraControllerNotifier!.value == null || !_cameraControllerNotifier!.value!.value.isInitialized) {
      // If camera is not initialized, try to initialize it first
      await _initializeCameras();
      if (_cameraControllerNotifier!.value == null || !_cameraControllerNotifier!.value!.value.isInitialized) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Kamera tidak dapat diinisialisasi.'))
          );
        }
        return;
      }
    }

    if (!mounted) return; // Guard against BuildContext across async gaps

    final String? imagePath = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => CustomCameraScreen(
          controllerNotifier: _cameraControllerNotifier!, // Pass the notifier
          onCameraSwitchPressed: _switchCamera, // Pass the camera switch callback
        ),
      ),
    );

    if (imagePath != null) {
      final XFile imageXFile = XFile(imagePath);

      ref.read(imageProcessingServiceProvider.notifier).taskStarted(); // Increment counter
      try {
        await ImagePickerUtil.saveImageToGallery(imageXFile);

        if (mounted) {
          widget.onImagePicked?.call(File(imagePath));
          ref
              .read(imageDataListProvider.notifier)
              .updateImageDataByLabel(widget.label, imagePath: imagePath);
        }
      } catch (e) {
        if (mounted && kDebugMode) {
          debugPrint("Error during custom camera image processing or saving: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Terjadi kesalahan saat memproses gambar kamera: $e'))
          );
        }
      } finally {
        if (mounted) {
          ref.read(imageProcessingServiceProvider.notifier).taskFinished(); // Decrement counter
        }
      }
    }
  }

  Future<void> _takePictureFromGallery() async {
    FocusScope.of(context).unfocus();
    final pickedImageXFile = await ImagePickerUtil.pickImageFromGallery();

    if (pickedImageXFile != null) {
      ref.read(imageProcessingServiceProvider.notifier).taskStarted(); // Increment counter
      try {
        final String? processedPath = await ImagePickerUtil.processAndSaveImage(pickedImageXFile);

        if (mounted && processedPath != null) {
          widget.onImagePicked?.call(File(processedPath));
          ref
              .read(imageDataListProvider.notifier)
              .updateImageDataByLabel(widget.label, imagePath: processedPath);
        } else if (mounted && processedPath == null) {
          if (kDebugMode) {
            debugPrint("Image processing failed for gallery image.");
          }
          if (mounted) { // Added mounted check
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Gagal memproses gambar dari galeri.'))
            );
          }
        }
      } catch (e) {
        if (mounted && kDebugMode) {
          if (kDebugMode) {
            debugPrint("Error during gallery image processing: $e");
          }
          if (mounted) { // Added mounted check
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Terjadi kesalahan saat memproses gambar galeri: $e'))
            );
          }
        }
      } finally {
        if (mounted) {
          ref.read(imageProcessingServiceProvider.notifier).taskFinished(); // Decrement counter
        }
      }
    }
  }

  void _viewImage(File imageFile) {
    FocusScope.of(context).unfocus();
    _showImagePreview(context, imageFile);
  }

  void _showImagePreview(BuildContext context, File imageFile) {
    showGeneralDialog(
      context: context,
      barrierDismissible: true,
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      transitionDuration: const Duration(milliseconds: 200),
      pageBuilder: (BuildContext buildContext, Animation animation,
          Animation secondaryAnimation) {
        return ImagePreviewDialog(
          imageFile: imageFile,
          onDeleteConfirmed: _deleteImageConfirmed,
        );
      },
    );
  }

  void _deleteImageConfirmed() {
    if (!mounted) return;
    widget.onImagePicked?.call(null);
    ref
        .read(imageDataListProvider.notifier)
        .updateImageDataByLabel(widget.label, imagePath: '');
  }

  @override
  Widget build(BuildContext context) {
    final imageDataList = ref.watch(imageDataListProvider);
    final imageData = imageDataList.firstWhere(
      (img) => img.label == widget.label,
      orElse: () => ImageData(
        label: widget.label,
        imagePath: '',
        needAttention: false,
        category: '', 
        isMandatory: true,
      ),
    );

    final storedImage =
        imageData.imagePath.isNotEmpty ? File(imageData.imagePath) : null;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            bottom: storedImage == null ? 4.0 : 2.0,
          ),
          child: Text(
            widget.label,
            style: labelStyle,
          ),
        ),
        storedImage == null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: _takePictureFromCamera,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0), 
                        decoration: BoxDecoration(
                          color: toggleOptionSelectedLengkapColor,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: toggleOptionSelectedLengkapColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/camera.svg',
                              width: 30.0, 
                              height: 30.0, 
                              colorFilter: ColorFilter.mode(buttonTextColor, BlendMode.srcIn),
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Kamera',
                              style: labelStyle.copyWith(
                                color: buttonTextColor,
                                fontWeight: FontWeight.bold,
                                height: 1.2, 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: GestureDetector(
                      onTap: _takePictureFromGallery,
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0), 
                        decoration: BoxDecoration(
                          color: toggleOptionSelectedLengkapColor,
                          borderRadius: BorderRadius.circular(8.0),
                          border: Border.all(
                            color: toggleOptionSelectedLengkapColor,
                            width: 1.0,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              'assets/images/gallery-white.svg',
                              width: 30.0, 
                              height: 30.0, 
                            ),
                            const SizedBox(width: 8),
                            Text(
                              'Galeri',
                              style: labelStyle.copyWith(
                                color: buttonTextColor,
                                fontWeight: FontWeight.bold,
                                height: 1.2, 
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 8.0),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'assets/images/galeri.svg',
                      width: 22.0, 
                      height: 22.0, 
                    ),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        storedImage.path.split('/').last,
                        style: inputTextStyling.copyWith(
                          fontWeight: FontWeight.w300,
                          height: 1.2, 
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 8),
                    GestureDetector(
                      onTap: () => _viewImage(storedImage),
                      child: Text(
                        'Lihat Gambar',
                        style: TextStyle(
                          color: toggleOptionSelectedLengkapColor,
                          decoration: TextDecoration.underline,
                          decorationColor: toggleOptionSelectedLengkapColor,
                          decorationThickness: 1.5,
                          height: 1.2, 
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return DeleteConfirmationDialog(
                              message: 'Apakah anda yakin ingin menghapus gambar tersebut?',
                              onConfirm: () {
                                Navigator.of(context).pop(); 
                                _deleteImageConfirmed(); 
                              },
                              onCancel: () {
                                Navigator.of(context).pop(); 
                              },
                            );
                          },
                        );
                      },
                      child: SvgPicture.asset(
                        'assets/images/trashcan.svg',
                        width: 26.0, 
                        height: 26.0, 
                      ),
                    ),
                  ],
                ),
              ),
      ],
    );
  }
}
