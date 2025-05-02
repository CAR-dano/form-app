import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart'; // Import app_styles.dart

class PageNumber extends StatelessWidget {
  const PageNumber({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: pageNumberStyle, // Use the style from app_styles.dart
    );
  }
}
