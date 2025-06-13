import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart'; // Import app_styles.dart

class PageNumber extends StatelessWidget {
  final int currentPage;
  final int totalPages;

  const PageNumber({
    super.key,
    required this.currentPage,
    required this.totalPages,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      '$currentPage/$totalPages',
      style: pageNumberStyle, // Use the style from app_styles.dart
    );
  }
}
