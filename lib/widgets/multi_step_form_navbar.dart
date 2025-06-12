import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/providers/form_step_provider.dart';
import 'package:form_app/providers/page_navigation_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/widgets/navigation_button_row.dart';
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles
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
    return ClipRect( // ClipRect is important for BackdropFilter
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0), // Apply blur effect
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.white.withOpacity(0.0), // More transparent at the top
                Colors.white.withOpacity(0.6), // More opaque at the bottom
              ],
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 24.0),
            child: NavigationButtonRow(
              isBackButtonEnabled: currentPageIndex > 0,
              isLastPage: currentPageIndex == formPagesLength - 2, // PageNine
              onNextPressed: onNextPressed, // Simply call the passed-in callback
              onBackPressed: onBackPressed, // Simply call the passed-in callback
              isLoading: isLoading, // Pass loading state to the button
              isFormConfirmed: isChecked, // Pass confirmation state for button styling
            ),
          ),
        ),
      ),
    );
  }
}
