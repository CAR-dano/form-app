import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;


  const CommonLayout({
    super.key,
    required this.child,
  });

  // Define standard padding
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus(); // Dismiss keyboard on tap outside
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: pagePadding,
            child: child,
          ),
        ),
        // You can add other Scaffold elements here if needed globally,
        // like a FloatingActionButton, BottomNavigationBar, Drawer, etc.
      ),
    );
  }
}
