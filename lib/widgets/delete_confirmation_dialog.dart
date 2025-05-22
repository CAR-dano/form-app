import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart'; // Import app_styles for text styles and colors

class DeleteConfirmationDialog extends StatelessWidget {
  final String message;
  final VoidCallback onConfirm;
  final VoidCallback onCancel;

  const DeleteConfirmationDialog({
    super.key,
    required this.message,
    required this.onConfirm,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0), // Small padding on sides
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0), // Padding inside the dialog
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              message,
              textAlign: TextAlign.center,
              style: labelStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: onCancel,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.grey[300], // A neutral color for "Tidak"
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: const Size.fromHeight(44), // Set height to 44
                      elevation: 5,
                      shadowColor: Colors.grey[300]?.withAlpha(102),
                      alignment: Alignment.center, // Explicitly center the content
                    ),
                    child: SizedBox(
                      height: 24.0, // Fixed height for the button content
                      child: Transform.translate(
                        offset: const Offset(0.0, -2.0), // Move text up by 1 pixel
                        child: Text(
                          'Tidak',
                          textAlign: TextAlign.center, // Ensure text is centered horizontally
                          style: labelStyle.copyWith(
                            color: darkTextColor, // Or a suitable dark color
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16.0),
                Expanded(
                  child: ElevatedButton(
                    onPressed: onConfirm,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: const Size.fromHeight(44), // Set height to 44
                      elevation: 5,
                      shadowColor: buttonColor.withAlpha(102),
                      alignment: Alignment.center, // Explicitly center the content
                    ),
                    child: SizedBox(
                      height: 24.0, // Fixed height for the button content
                      child: Transform.translate(
                        offset: const Offset(0.0, -2.0), // Move text up by 1 pixel
                        child: Text(
                          'Iya',
                          textAlign: TextAlign.center, // Ensure text is centered horizontally
                          style: labelStyle.copyWith(
                            color: buttonTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
