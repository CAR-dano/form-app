import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class PageTitle extends StatelessWidget {
  const PageTitle({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: pageTitleStyle,
    );
  }
}
