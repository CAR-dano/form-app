import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;


  const CommonLayout({
    super.key,
    required this.child,
  });

  // Define standard padding
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 24.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on tap outside
      },
      child: Padding(
        padding: pagePadding,
        child: child,
      ),
    );
  }
}
