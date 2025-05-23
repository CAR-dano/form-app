import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class LoadingIndicatorWidget extends StatelessWidget {
  final String message;
  final double progress; // Value from 0.0 to 1.0

  const LoadingIndicatorWidget({
    super.key,
    required this.message,
    required this.progress,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Column(
        children: [
          Text(
            message,
            style: labelStyle.copyWith(fontSize: 16),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 12.0),
          ClipRRect( // For rounded corners
            borderRadius: BorderRadius.circular(8.0), // Material 3 style rounded corners
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: numberedButtonColors[1]?.withAlpha((numberedButtonColors[1]!.a * 0.3).round()), // Lighter shade of the first color
              valueColor: AlwaysStoppedAnimation<Color>(numberedButtonColors[10]!), // Use the 10th color for progress
              minHeight: 10, // Make it a bit thicker
            ),
          ),
          if (progress > 0 && progress < 1)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: Text(
                '${(progress * 100).toStringAsFixed(0)}%',
                style: hintTextStyle,
              ),
            ),
        ],
      ),
    );
  }
}
