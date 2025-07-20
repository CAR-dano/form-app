import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'dart:ui';

class MultiStepFormNavbar extends ConsumerWidget {
  final int currentPageIndex;
  final int formPagesLength;
  final VoidCallback onNextPressed;
  final VoidCallback onBackPressed;
  final bool isLoading;
  final bool isChecked;

  const MultiStepFormNavbar({
    super.key,
    required this.currentPageIndex,
    required this.formPagesLength,
    required this.onNextPressed,
    required this.onBackPressed,
    required this.isLoading,
    required this.isChecked,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        Positioned.fill(
          child: ShaderMask(
            shaderCallback: (Rect bounds) {
              return const LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Colors.transparent, // Top will be transparent
                  Colors.white,       // Bottom will be fully visible
                ],
                stops: [0.0, 0.2], // Adjust how much of the top fades out
              ).createShader(bounds);
            },
            blendMode: BlendMode.dstIn, // Keep destination (blurred bg), mask with fade
            child: ClipRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 50.0, sigmaY: 50.0),
                child: Container(
                  color: Colors.white.withAlpha((0.8*255).round()), // base color of blurred layer
                ),
              ),
            ),
          ),
        ),

        // Foreground content (buttons)
        Padding(
          padding: const EdgeInsets.only(top:6, left: 24.0, right: 24.0, bottom: 24),
          child: NavigationButtonRow(
            isBackButtonEnabled: currentPageIndex > 0,
            isLastPage: currentPageIndex == formPagesLength - 1,
            onNextPressed: onNextPressed,
            onBackPressed: onBackPressed,
            isLoading: isLoading,
            isFormConfirmed: isChecked,
          ),
        ),
      ],
    );
  }
}
