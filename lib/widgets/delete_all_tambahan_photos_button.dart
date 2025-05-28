import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'package:form_app/widgets/delete_confirmation_dialog.dart';
import 'package:form_app/statics/app_styles.dart'; // For text styles if needed

class DeleteAllTambahanPhotosButton extends ConsumerWidget {
  final String tambahanImageIdentifier;
  final String dialogMessage;

  const DeleteAllTambahanPhotosButton({
    super.key,
    required this.tambahanImageIdentifier,
    this.dialogMessage = 'Apakah Anda yakin ingin menghapus semua foto tambahan di bagian ini?',
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    // Watch the provider to enable/disable the button
    final images = ref.watch(tambahanImageDataProvider(tambahanImageIdentifier));
    final bool hasImages = images.isNotEmpty;

    return Opacity(
      opacity: hasImages ? 1.0 : 0.5, // Make button less prominent if no images
      child: InkWell(
        onTap: hasImages
            ? () {
                showDialog(
                  context: context,
                  builder: (BuildContext dialogContext) {
                    return DeleteConfirmationDialog(
                      message: dialogMessage,
                      onConfirm: () {
                        ref
                            .read(tambahanImageDataProvider(tambahanImageIdentifier)
                                .notifier)
                            .clearAll();
                        Navigator.of(dialogContext).pop(); // Close confirmation dialog
                      },
                      onCancel: () {
                        Navigator.of(dialogContext).pop(); // Close confirmation dialog
                      },
                    );
                  },
                );
              }
            : null, // Disable tap if no images
        borderRadius: BorderRadius.circular(12.0), // Match border radius
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: deleteButtonHorizontalPadding,
            vertical: deleteButtonVerticalPadding,
          ),
          decoration: BoxDecoration(
            color: Colors.white, // Or transparent if you prefer
            border: Border.all(
              color: deleteButtonBorderColor,
              width: deleteButtonBorderWidth,
            ),
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min, // So the row doesn't expand unnecessarily
            children: [
              SvgPicture.asset(
                'assets/images/delete.svg', // Your SVG icon path
                width: deleteButtonIconSize,
                height: deleteButtonIconSize,
                colorFilter: const ColorFilter.mode(
                  deleteButtonBorderColor, // Icon color matches border
                  BlendMode.srcIn,
                ),
              ),
              const SizedBox(width: 2.0),
              Text(
                'Hapus Foto',
                style: deleteButtonTextStyle,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
