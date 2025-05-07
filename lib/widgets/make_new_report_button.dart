import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class MakeNewReportButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const MakeNewReportButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onPressed,
      style: baseButtonStyle.copyWith(
        backgroundColor: WidgetStateProperty.all(toggleOptionSelectedLengkapColor),
      ),
      child: Text(
        text,
        style: buttonTextStyle,
      ),
    );
  }
}
