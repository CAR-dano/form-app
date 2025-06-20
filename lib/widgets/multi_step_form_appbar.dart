import 'package:flutter/material.dart';
import 'package:form_app/widgets/page_number.dart';

class MultiStepFormAppBar extends StatelessWidget implements PreferredSizeWidget {
  final int currentPage;
  final int totalPages;
  final Widget? trailingWidget; // New parameter for the widget on the right

  const MultiStepFormAppBar({
    super.key,
    required this.currentPage,
    required this.totalPages,
    this.trailingWidget, // Make it optional
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      automaticallyImplyLeading: false, // No back button by default
      title: Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: PageNumber(
          currentPage: currentPage,
          totalPages: totalPages,
        ),
      ),
      actions: trailingWidget != null
          ? [
              Padding(
                padding: const EdgeInsets.only(right: 16.0), // Add some padding to the right
                child: trailingWidget!,
              ),
            ]
          : null,
      backgroundColor: Colors.white, // Or your desired app bar color
      elevation: 0, // No shadow
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
