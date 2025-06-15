import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'dart:ui'; // For ImageFilter

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
          child: ClipRect( // ClipRect is important for BackdropFilter
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0), // Apply blur effect
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.white.withAlpha(0), // Start fully transparent
                      Colors.white.withAlpha((0.05*255).round()), // End with semi-transparent white (lowered opacity)
                    ],
                    stops: const [0.0, 0.5], // Fade from 0% to 50% of the height
                  ),
                ),
              ),
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
          child: NavigationButtonRow(
            isBackButtonEnabled: currentPageIndex > 0,
            isLastPage: currentPageIndex == formPagesLength - 2, // PageNine
            onNextPressed: onNextPressed, // Simply call the passed-in callback
            onBackPressed: isLoading ? null : onBackPressed, // Disable back button when loading
            isLoading: isLoading, // Pass loading state to the button
            isFormConfirmed: isChecked, // Pass confirmation state for button styling
          ),
        ),
      ],
    );
  }
}
