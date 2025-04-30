import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class NavigationButtonRow extends StatelessWidget {
  final VoidCallback? onBackPressed; // Null if disabled (like on page 1)
  final VoidCallback onNextPressed;
  final String nextButtonText;
  final bool isBackButtonEnabled;
  // Optional: Add isLoading state for the next button later if needed for submission
  // final bool isLoading;

  static final ButtonStyle _baseButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 32.0),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8.0),
    ),
    elevation: 5, // Base elevation for enabled state
    shadowColor: buttonColor.withAlpha(102),
  );
  // --- End Constants ---

  const NavigationButtonRow({
    super.key,
    required this.onNextPressed,
    this.onBackPressed, // Make optional
    this.nextButtonText = 'Next', // Default text
    this.isBackButtonEnabled = true, // Default to enabled
    // this.isLoading = false,
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
              style: _baseButtonStyle.copyWith(
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
            onPressed: onNextPressed, // Always use the provided callback
            // Apply base style and override background/foreground explicitly for clarity
            style: _baseButtonStyle.copyWith(
               backgroundColor: WidgetStateProperty.all(buttonColor), // Always orange when enabled
               foregroundColor: WidgetStateProperty.all(buttonTextColor), // Always white when enabled
            ),
            // TODO: Handle isLoading state here later if needed
            // child: isLoading
            //     ? SizedBox(
            //         width: 20,
            //         height: 20,
            //         child: CircularProgressIndicator(
            //           color: buttonTextColor,
            //           strokeWidth: 2,
            //         ),
            //       )
            //     : Text(nextButtonText, style: buttonTextStyle),
              child: Text(nextButtonText, style: buttonTextStyle),
          ),
        ),
      ],
    );
  }
}
