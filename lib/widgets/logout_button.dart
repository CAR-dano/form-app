import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/pages/login_page.dart';
import 'package:form_app/providers/auth_provider.dart';
import 'package:form_app/widgets/delete_confirmation_dialog.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return IconButton(
      icon: const Icon(Icons.logout, color: Colors.red),
      onPressed: () => _showLogoutConfirmationDialog(context, ref),
    );
  }

  Future<void> _showLogoutConfirmationDialog(BuildContext context, WidgetRef ref) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // User must tap a button
      builder: (BuildContext dialogContext) {
        return DeleteConfirmationDialog(
          message: 'Apakah Anda yakin ingin keluar?',
          confirmText: 'Logout',
          cancelText: 'Batal',
          onConfirm: () {
            Navigator.of(dialogContext).pop(); // Dismiss the dialog
            _logout(context, ref); // Proceed with logout
          },
          onCancel: () {
            Navigator.of(dialogContext).pop();
          },
        );
      },
    );
  }

  Future<void> _logout(BuildContext context, WidgetRef ref) async {
    final authService = ref.read(authServiceProvider);
    await authService.logout();
    // Ensure the context is still mounted before navigating
    if (context.mounted) {
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => const LoginPage()),
        (Route<dynamic> route) => false,
      );
    }
  }
}
