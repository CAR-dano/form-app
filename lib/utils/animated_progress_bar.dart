import 'package:flutter/material.dart';

class AnimatedProgressBar extends StatefulWidget {
  final double value;
  final Color backgroundColor;
  final double minHeight;
  final BorderRadiusGeometry? borderRadius;
  final Map<int, Color> colorMap;
  final Color? trackColor;
  final Color? stopIndicatorColor;

  const AnimatedProgressBar({
    super.key,
    required this.value,
    required this.backgroundColor,
    this.minHeight = 10.0,
    this.borderRadius,
    required this.colorMap,
    this.trackColor,
    this.stopIndicatorColor,
  });

  @override
  State<AnimatedProgressBar> createState() => _AnimatedProgressBarState();
}

class _AnimatedProgressBarState extends State<AnimatedProgressBar> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Color?> _colorAnimation;
  Color? _previousInterpolatedColor;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300), // Smooth transition duration
    );
    _previousInterpolatedColor = _getInterpolatedColor(widget.value);
    _colorAnimation = ColorTween(begin: _previousInterpolatedColor, end: _previousInterpolatedColor).animate(_controller);
  }

  @override
  void didUpdateWidget(covariant AnimatedProgressBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    final newInterpolatedColor = _getInterpolatedColor(widget.value);
    if (_previousInterpolatedColor != newInterpolatedColor) {
      _colorAnimation = ColorTween(begin: _previousInterpolatedColor ?? newInterpolatedColor, end: newInterpolatedColor).animate(_controller);
      _controller.forward(from: 0.0);
      _previousInterpolatedColor = newInterpolatedColor;
    }
  }

  Color _getInterpolatedColor(double value) {
    final clampedValue = (value * 10).clamp(0, 10).toDouble(); // Scale 0-1 to 0-10
    final lowerIndex = clampedValue.floor();
    final upperIndex = clampedValue.ceil();

    final Color startColor = widget.colorMap[lowerIndex == 0 ? 1 : lowerIndex] ?? widget.colorMap[1]!;
    final Color endColor = widget.colorMap[upperIndex == 0 ? 1 : upperIndex] ?? widget.colorMap[10]!;

    final double t = clampedValue - lowerIndex; // Interpolation factor

    return Color.lerp(startColor, endColor, t)!;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _colorAnimation,
      builder: (context, child) {
        return LinearProgressIndicator(
          // ignore: deprecated_member_use
          year2023: false,
          borderRadius: widget.borderRadius,
          value: widget.value,
          backgroundColor: widget.backgroundColor,
          valueColor: AlwaysStoppedAnimation<Color>(_colorAnimation.value!),
          minHeight: widget.minHeight,
          color: widget.trackColor,
          stopIndicatorColor: widget.stopIndicatorColor,
        );
      },
    );
  }
}
