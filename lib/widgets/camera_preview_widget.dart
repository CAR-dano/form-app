import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class CameraPreviewWidget extends StatefulWidget {
  final CameraController? controller;
  final Animation<double> captureOpacityAnimation;
  final double rotationAngle;

  const CameraPreviewWidget({
    super.key,
    required this.controller,
    required this.captureOpacityAnimation,
    required this.rotationAngle,
  });

  @override
  State<CameraPreviewWidget> createState() => _CameraPreviewWidgetState();
}

class _CameraPreviewWidgetState extends State<CameraPreviewWidget> {
  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;
    const double scale = 1.0;

    if (widget.controller == null || !widget.controller!.value.isInitialized) {
      // Show a blank screen or a simple placeholder while the camera is initializing
      return Container(color: Colors.black); // Effectively a blank screen
    }

    return SizedBox(
      width: screenSize.width,
      height: screenSize.width / (3.0 / 4.0), // 3:4 aspect ratio using full width
      child: ClipRect(
        child: Transform.scale(
          scale: scale, // Adjusted scale to prevent zoom
          child: Center(
            child: AnimatedBuilder(
              animation: widget.captureOpacityAnimation,
              builder: (context, child) {
                return Opacity(
                  opacity: widget.captureOpacityAnimation.value,
                  child: CameraPreview(widget.controller!),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
