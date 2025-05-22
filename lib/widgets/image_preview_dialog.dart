import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/delete_confirmation_dialog.dart';

class ImagePreviewDialog extends StatelessWidget {
  final File imageFile;
  final VoidCallback onDeleteConfirmed;

  const ImagePreviewDialog({
    super.key,
    required this.imageFile,
    required this.onDeleteConfirmed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Center(
        child: SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          child: AlertDialog(
            backgroundColor: Colors.white,
            insetPadding: EdgeInsets.zero,
            contentPadding: EdgeInsets.zero,
            content: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column( // Wrap content in a Column
                mainAxisSize: MainAxisSize.min, // Ensure column takes minimum space
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: Image.file(
                            imageFile,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        right: 8.0,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext dialogContext) {
                                return DeleteConfirmationDialog(
                                  message: 'Apakah anda yakin ingin menghapus gambar tersebut?',
                                  onConfirm: () {
                                    Navigator.of(dialogContext).pop();
                                    onDeleteConfirmed();
                                    Navigator.of(context).pop();
                                  },
                                  onCancel: () {
                                    Navigator.of(dialogContext).pop();
                                  },
                                );
                              },
                            );
                          },
                          child: SvgPicture.asset(
                            'assets/images/trashcan.svg',
                            width: 40.0,
                            height: 40.0,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16.0), // Add spacing between image and button
                  SizedBox(
                    width: double.infinity, // Take full width
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the image preview popup
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: toggleOptionSelectedLengkapColor, // Change to light blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        minimumSize: const Size.fromHeight(44), // Set height to 44
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        elevation: 5,
                        shadowColor: toggleOptionSelectedLengkapColor.withAlpha(102), // Update shadow color
                      ),
                      child: Text(
                        'Simpan',
                        style: labelStyle.copyWith(
                          color: buttonTextColor,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
