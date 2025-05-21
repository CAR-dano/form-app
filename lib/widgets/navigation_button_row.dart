import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class NavigationButtonRow extends StatelessWidget {
  final VoidCallback? onBackPressed; // Null if disabled (like on page 1)
  final VoidCallback onNextPressed;
  final String nextButtonText;
  final bool isBackButtonEnabled;
  final bool isLastPage;
  final bool isFormConfirmed;
  // Optional: Add isLoading state for the next button later if needed for submission
  final bool isLoading;

  // --- End Constants ---

  const NavigationButtonRow({
    super.key,
    required this.onNextPressed,
    this.onBackPressed, // Make optional
    this.nextButtonText = 'Next', // Default text
    this.isBackButtonEnabled = true, // Default to enabled
    this.isLastPage = false, // Default to not the last page
    this.isFormConfirmed = true, // Default to true
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    // Use the same layout structure as before (Row with spaceBetween)
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        // --- Back Button (Conditionally Rendered) ---
        if (isBackButtonEnabled) // Only render if enabled
          Expanded(
            child: ElevatedButton(
              // Use the provided callback
              onPressed: onBackPressed, // No need for ternary here as it won't render if disabled
              style: baseButtonStyle.copyWith(
                // Override specific properties for enabled/disabled state
                backgroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return disabledButtonColor; // Disabled color
                  }
                  return buttonColor; // Use default button color if enabled (will be overridden below)
                },
              ),
              // More explicit disabled styling:
              elevation: WidgetStateProperty.resolveWith<double>(
                   (Set<WidgetState> states) {
                      if (states.contains(WidgetState.disabled)) return 0;
                      return 5; // Use base elevation if enabled
                   }
              ),
              foregroundColor: WidgetStateProperty.resolveWith<Color>(
                (Set<WidgetState> states) {
                  if (states.contains(WidgetState.disabled)) {
                    return buttonTextColor.withAlpha(204); // Disabled text color
                  }
                  return buttonTextColor; // Enabled text color
                },
              ),
              shadowColor: WidgetStateProperty.all(buttonColor.withAlpha(102)), // Set shadow color to orange
            ),
            child: Text('Back', style: buttonTextStyle),
          ),
        ),

        // --- Spacer (Conditionally Rendered with Back Button) ---
        if (isBackButtonEnabled) // Only render spacer if back button is rendered
          const SizedBox(width: 10),

        // --- Next/Submit Button ---
        // Removed Expanded wrapper to keep button's natural width
        Expanded(
          child: ElevatedButton(
            onPressed: isLoading ? null : onNextPressed, // Disable button when loading
            // Apply base style and override background/foreground explicitly for clarity
            style: baseButtonStyle.copyWith(
               backgroundColor: WidgetStateProperty.all(isLastPage && !isFormConfirmed ? const Color(0xffcacaca) : (isLastPage ? toggleOptionSelectedLengkapColor : buttonColor)), // Grey if last page and not confirmed, Blue if last page and confirmed, else orange
               foregroundColor: WidgetStateProperty.all(buttonTextColor), // Always white when enabled
               shadowColor: WidgetStateProperty.all(isLastPage && !isFormConfirmed ? const Color(0xffcacaca).withAlpha(102) : (isLastPage ? toggleOptionSelectedLengkapColor.withAlpha(102) : buttonColor.withAlpha(102))), // Adjust shadow color
            ),
            child: SizedBox(
              height: 24.0, // Fixed height for the button content
              child: Center( // Center the content vertically and horizontally
                child: isLoading
                    ? SizedBox(
                        width: 24, // Slightly larger size for visibility
                        height: 24,
                        child: CircularProgressIndicator(
                          color: buttonTextColor,
                          strokeWidth: 2,
                        ),
                      )
                    : Text(isLastPage ? 'Kirim' : nextButtonText, style: buttonTextStyle),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
