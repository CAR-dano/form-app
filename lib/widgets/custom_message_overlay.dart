import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class CustomMessageOverlay {
  OverlayEntry? _overlayEntry;
  final BuildContext context;
  AnimationController? _animationController;

  CustomMessageOverlay(this.context);

  void show({
    required String message,
    required Color backgroundColor,
    IconData? icon,
    Duration duration = const Duration(seconds: 3),
  }) {
    if (_overlayEntry != null) {
      _overlayEntry?.remove();
      _overlayEntry = null;
      _animationController?.dispose();
      _animationController = null;
    }

    _animationController = AnimationController(
      vsync: Navigator.of(context), // Use NavigatorState as TickerProvider
      duration: const Duration(milliseconds: 300),
    );

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: MediaQuery.of(context).padding.top + 10, // Position below status bar
        left: 10,
        right: 10,
        child: Material(
          color: Colors.transparent,
          child: FadeTransition(
            opacity: _animationController!,
            child: SlideTransition(
              position: Tween<Offset>(
                begin: const Offset(0, -1),
                end: Offset.zero,
              ).animate(_animationController!),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                decoration: BoxDecoration(
                  color: backgroundColor,
                  borderRadius: BorderRadius.circular(16.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withAlpha((255 * 0.2).round()),
                      blurRadius: 6,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    if (icon != null) ...[
                      Icon(icon, color: Colors.white),
                      const SizedBox(width: 12.0),
                    ],
                    Expanded(
                      child: Text(
                        message,
                        style: subTitleTextStyle.copyWith(color: Colors.white),
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
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
    _animationController?.forward();

    Future.delayed(duration, () {
      hide();
    });
  }

  void hide() {
    if (_overlayEntry != null) {
      _animationController?.reverse().then((_) {
        _overlayEntry?.remove();
        _overlayEntry = null;
        _animationController?.dispose();
        _animationController = null;
      });
    }
  }
}
