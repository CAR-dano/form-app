import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:form_app/widgets/delete_confirmation_dialog.dart';
import 'package:form_app/providers/image_processing_provider.dart';
import 'package:form_app/providers/image_data_provider.dart';
import 'package:form_app/models/image_data.dart'; // Import ImageData

class ImagePreviewDialog extends ConsumerWidget {
  final String imageIdentifier;
  final VoidCallback onRotate;

  const ImagePreviewDialog({
    super.key,
    required this.imageIdentifier,
    required this.onRotate,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final imageData = ref.watch(imageDataListProvider).firstWhere(
          (img) => img.label == imageIdentifier,
          orElse: () => ImageData(
              label: imageIdentifier, imagePath: '', category: '', isMandatory: false, needAttention: false),
        );
    
    final imageFile = imageData.imagePath.isNotEmpty ? File(imageData.imagePath) : null;
    final isProcessingImage = ref.watch(imageProcessingServiceProvider.select((s) => (s[imageIdentifier] ?? 0) > 0));

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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Stack(
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.circular(16.0),
                        child: AspectRatio(
                          aspectRatio: 4 / 3,
                          child: imageFile != null && imageFile.existsSync()
                              ? Image.file(
                                  imageFile,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/checker.png',
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                      Positioned(
                        top: 8.0,
                        right: 56.0,
                        child: GestureDetector(
                          onTap: isProcessingImage ? null : onRotate,
                          child: SvgPicture.asset(
                            'assets/images/rotate.svg',
                            width: 40.0,
                            height: 40.0,
                            colorFilter: isProcessingImage
                                ? ColorFilter.mode(Colors.grey.withAlpha((0.6 * 255).round()), BlendMode.srcIn)
                                : null,
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
                                    Navigator.of(context).pop(true);
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
                  if (isProcessingImage)
                    Padding(
                      padding: const EdgeInsets.only(top: 16.0),
                      child: LinearProgressIndicator(
                        borderRadius: BorderRadius.circular(8.0),
                        backgroundColor: Colors.grey[300],
                        valueColor: const AlwaysStoppedAnimation<Color>(toggleOptionSelectedLengkapColor),
                        minHeight: 5.0,
                      ),
                    ),
                  const SizedBox(height: 16.0),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop(false);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: toggleOptionSelectedLengkapColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        minimumSize: const Size.fromHeight(44),
                        padding: const EdgeInsets.symmetric(vertical: 12.0),
                        elevation: 5,
                        shadowColor: toggleOptionSelectedLengkapColor.withAlpha(102),
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
