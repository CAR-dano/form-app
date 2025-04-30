import 'package:flutter/material.dart';

class CommonLayout extends StatelessWidget {
  final Widget child;
  final String? title; // Optional title for the AppBar

  const CommonLayout({
    super.key,
    required this.child,
    this.title,
  });

  // Define standard padding
  static const EdgeInsets pagePadding = EdgeInsets.symmetric(horizontal: 24.0, vertical: 16.0);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: pagePadding, // Apply standard padding
          child: child, // Display the page-specific content
        ),
      ),
      // You can add other Scaffold elements here if needed globally,
      // like a FloatingActionButton, BottomNavigationBar, Drawer, etc.
    );
  }
}
