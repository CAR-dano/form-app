import 'dart:async';

import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

class CustomMessageOverlay {
  OverlayEntry? _overlayEntry;
  AnimationController? _animationController;
  AnimationController? _snapAnimationController;
  Animation<double>? _snapAnimation;

  Timer? _timer;
  double _draggedY = 0.0;
  double _draggedX = 0.0; // New variable for horizontal drag

  CustomMessageOverlay();

  void show({
    required BuildContext context, // Add BuildContext as a parameter
    required String message,
    required Color color,
    IconData? icon,
    Duration duration = const Duration(seconds: 2),
  }) {
    if (_overlayEntry != null) {
      _timer?.cancel();
      _snapAnimationController?.stop();
      _snapAnimationController?.dispose();
      _snapAnimationController = null;
      _animationController?.stop();
      _animationController?.dispose();
      _animationController = null;
      _overlayEntry?.remove();
      _overlayEntry = null;
    }
    _draggedY = 0.0;
    _draggedX = 0.0; // Reset horizontal drag

    final tickerProvider = Navigator.of(context);

    _animationController = AnimationController(
      vsync: tickerProvider,
      duration: const Duration(milliseconds: 300),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) {
        final baseTop = MediaQuery.of(context).padding.top + 10;
        return Positioned(
          top: baseTop + _draggedY,
          left: 10 + _draggedX, // Apply horizontal drag
          right: 10 - _draggedX, // Apply horizontal drag
          child: GestureDetector(
            onVerticalDragUpdate: (details) {
              _snapAnimationController?.stop();
              _draggedY += details.delta.dy;
              _draggedY = _draggedY.clamp(double.negativeInfinity, 0.0);
              _overlayEntry?.markNeedsBuild();
            },
            onVerticalDragEnd: (details) {
              final double dragThreshold = -75.0;
              final double velocityThreshold = -300.0;

              final double screenHeight = MediaQuery.of(context).size.height;
              if (_draggedY < dragThreshold || (details.primaryVelocity ?? 0) < velocityThreshold) {
                _snapAnimationController?.dispose();
                _snapAnimationController = AnimationController(
                    vsync: tickerProvider,
                    duration: const Duration(milliseconds: 1600)); // Increased duration for smoother vertical dismissal
                _snapAnimation = Tween<double>(
                  begin: _draggedY,
                  end: -screenHeight, // Animate upwards off-screen
                ).animate(
                    CurvedAnimation(parent: _snapAnimationController!, curve: Curves.easeOut));
                
                _snapAnimationController!.addListener(() {
                  _draggedY = _snapAnimation!.value;
                  _overlayEntry?.markNeedsBuild();
                });

                _snapAnimationController!.addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    hide();
                  }
                });
                _snapAnimationController!.forward();
              } else {
                _snapAnimationController?.dispose();
                _snapAnimationController = AnimationController(
                    vsync: tickerProvider,
                    duration: const Duration(milliseconds: 200));
                _snapAnimation = Tween<double>(begin: _draggedY, end: 0.0).animate(
                    CurvedAnimation(parent: _snapAnimationController!, curve: Curves.easeOut));
                
                _snapAnimationController!.addListener(() {
                  _draggedY = _snapAnimation!.value;
                  _overlayEntry?.markNeedsBuild();
                });

                _snapAnimationController!.addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    _draggedY = 0.0;
                    _snapAnimationController?.dispose();
                    _snapAnimationController = null;
                    _overlayEntry?.markNeedsBuild();
                  }
                });
                _snapAnimationController!.forward();
              }
            },
            onHorizontalDragUpdate: (details) { // New horizontal drag update
              _snapAnimationController?.stop();
              _draggedX += details.delta.dx;
              _overlayEntry?.markNeedsBuild();
            },
            onHorizontalDragEnd: (details) { // New horizontal drag end
              final double dragThreshold = 75.0;
              final double velocityThreshold = 300.0;
              final double screenWidth = MediaQuery.of(context).size.width;

              if (_draggedX.abs() > dragThreshold || (details.primaryVelocity ?? 0).abs() > velocityThreshold) {
                _snapAnimationController?.dispose();
                _snapAnimationController = AnimationController(
                    vsync: tickerProvider,
                    duration: const Duration(milliseconds: 300));
                _snapAnimation = Tween<double>(
                  begin: _draggedX,
                  end: _draggedX > 0 ? screenWidth : -screenWidth,
                ).animate(
                    CurvedAnimation(parent: _snapAnimationController!, curve: Curves.easeOut));
                
                _snapAnimationController!.addListener(() {
                  _draggedX = _snapAnimation!.value;
                  _overlayEntry?.markNeedsBuild();
                });

                _snapAnimationController!.addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    hide();
                  }
                });
                _snapAnimationController!.forward();
              } else {
                _snapAnimationController?.dispose();
                _snapAnimationController = AnimationController(
                    vsync: tickerProvider,
                    duration: const Duration(milliseconds: 200));
                _snapAnimation = Tween<double>(begin: _draggedX, end: 0.0).animate(
                    CurvedAnimation(parent: _snapAnimationController!, curve: Curves.easeOut));
                
                _snapAnimationController!.addListener(() {
                  _draggedX = _snapAnimation!.value;
                  _overlayEntry?.markNeedsBuild();
                });

                _snapAnimationController!.addStatusListener((status) {
                  if (status == AnimationStatus.completed) {
                    _draggedX = 0.0;
                    _snapAnimationController?.dispose();
                    _snapAnimationController = null;
                    _overlayEntry?.markNeedsBuild();
                  }
                });
                _snapAnimationController!.forward();
              }
            },
            child: Material(
              color: Colors.transparent,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0, -1),
                  end: Offset.zero,
                ).animate(CurvedAnimation(
                  parent: _animationController!,
                  curve: Curves.easeOutCubic,
                )),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: HSLColor.fromColor(color).withLightness(0.95).toColor(), // Even softer background color using HSL
                    borderRadius: BorderRadius.circular(16.0),
                    boxShadow: [
                      BoxShadow(
                        color: color.withAlpha((0.2*255).round()), // Shadow color derived from the main color
                        blurRadius: 6,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Row(
                    children: [
                      if (icon != null) ...[
                        Icon(icon, color: color), // Icon color matches the main color
                        const SizedBox(width: 12.0),
                      ],
                      Expanded(
                        child: Text(
                          message,
                          style: subTitleTextStyle.copyWith(color: color), // Text color matches the main color
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController?.forward();

    _timer?.cancel();
    _timer = Timer(duration, () {
      hide();
    });
  }

  void hide() {
    _timer?.cancel();
    _snapAnimationController?.stop();
    _snapAnimationController?.dispose();
    _snapAnimationController = null;

    if (_overlayEntry != null) {
      if (_animationController != null && !_animationController!.isDismissed) {
        _animationController!.reverse().then((_) {
          _overlayEntry?.remove();
          _overlayEntry = null;
          _animationController?.dispose();
          _animationController = null;
          _draggedY = 0.0;
          _draggedX = 0.0; // Reset horizontal drag
        }).catchError((e, stack) {
          FirebaseCrashlytics.instance.recordError(e, stack, fatal: false);
          _overlayEntry?.remove();
          _overlayEntry = null;
          _animationController?.dispose();
          _animationController = null;
          _draggedY = 0.0;
          _draggedX = 0.0; // Reset horizontal drag
        });
      } else {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _animationController?.dispose();
        _animationController = null;
        _draggedY = 0.0;
        _draggedX = 0.0; // Reset horizontal drag
      }
    }
  }
}
