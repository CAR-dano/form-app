import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles

class HeadingOne extends StatelessWidget {
  final String text;

  const HeadingOne({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: headingOneStyle,
    );
  }
}
