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
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  // ignore: deprecated_member_use
                  year2023: false,
                  stopIndicatorColor: numberedButtonColors[
                        (progress * 10).clamp(1, 10).toInt()] ?? numberedButtonColors[10]!,
                  borderRadius: BorderRadius.circular(8.0),
                  color: numberedButtonColors[
                        (progress * 10).clamp(1, 10).toInt()] ?? numberedButtonColors[10]!,
                  value: progress,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    numberedButtonColors[
                        (progress * 10).clamp(1, 10).toInt()] ?? numberedButtonColors[10]!
                  ),
                  minHeight: 10,
                ),
              ),
              if (progress > 0 && progress < 1)
                Padding(
                  padding: const EdgeInsets.only(left: 8.0), // Add left padding for spacing
                  child: Text(
                    '${(progress * 100).toStringAsFixed(0)}%',
                    style: hintTextStyle,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}
