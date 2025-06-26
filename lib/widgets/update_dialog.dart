import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/services/update_service.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';

void showUpdateDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: true,
    builder: (context) => const UpdateDialog(),
  );
}

class UpdateDialog extends ConsumerWidget {
  const UpdateDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateState = ref.watch(updateServiceProvider);
    final updateNotifier = ref.read(updateServiceProvider.notifier);

    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 20.0),
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Update Tersedia! (v${updateState.latestVersion})',
              textAlign: TextAlign.center,
              style: labelStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'Versi baru aplikasi tersedia.\nBerikut adalah perubahannya:',
              textAlign: TextAlign.center,
              style: labelStyle.copyWith(
                fontSize: 16,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              constraints: const BoxConstraints(maxHeight: 250), // Limit height for release notes
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 4),
                  child: MarkdownBody(
                    data: updateState.releaseNotes.isNotEmpty
                        ? updateState.releaseNotes.split('\n\n---\n\n')[0] // Extract only the PR description
                        : 'Catatan rilis tidak tersedia.',
                    styleSheet: MarkdownStyleSheet(
                      p: labelStyle.copyWith(fontSize: 14, color: darkTextColor),
                      listBullet: labelStyle.copyWith(fontSize: 14, color: darkTextColor),
                    ),
                  ),
                ),
              ),
            ),
            if (updateState.fileSize != null && updateState.downloadedApkPath.isEmpty) ...[ // Only show if not downloaded
              const SizedBox(height: 16),
              Text(
                'Ukuran File: ${updateState.fileSize}',
                textAlign: TextAlign.center,
                style: labelStyle.copyWith(
                  fontSize: 16,
                  color: darkTextColor,
                ),
              ),
            ],
            if (updateState.isDownloading) ...[
              const SizedBox(height: 20),
              ClipRRect(
                borderRadius: BorderRadius.circular(10), // Adjust the radius as needed
                child: LinearProgressIndicator(
                  value: updateState.downloadProgress,
                  backgroundColor: Colors.grey[300],
                  valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
                  minHeight: 10, // Adjust height to make it visible with border
                ),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Mengunduh: ${(updateState.downloadProgress * 100).toStringAsFixed(0)}% ${updateState.fileSize != null ? '(${(updateState.downloadProgress * (updateState.rawFileSize ?? 0) / (1024 * 1024)).toStringAsFixed(1)} MB / ${updateState.fileSize})' : ''}',
                  style: labelStyle.copyWith(
                  fontSize: 16,
                  color: darkTextColor,
                ),
                ),
              )
            ],
            if (updateState.errorMessage.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Kesalahan: ${updateState.errorMessage}',
                style: labelStyle.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ],
            const SizedBox(height: 24.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                // Later Button
                if (!updateState.isDownloading && updateState.downloadedApkPath.isEmpty)
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        minimumSize: const Size.fromHeight(44),
                        elevation: 5,
                        shadowColor: Colors.grey[300]?.withAlpha(102),
                        alignment: Alignment.center,
                      ),
                      child: SizedBox(
                        height: 24.0,
                        child: Transform.translate(
                          offset: const Offset(0.0, -2.0),
                          child: Text(
                            'Nanti',
                            textAlign: TextAlign.center,
                            style: labelStyle.copyWith(
                              color: darkTextColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                if (!updateState.isDownloading && updateState.downloadedApkPath.isEmpty)
                  const SizedBox(width: 16.0),

                // Download/Install Button
                Expanded(
                  child: ElevatedButton(
                    onPressed: updateState.isDownloading
                        ? null
                        : () {
                            if (updateState.downloadedApkPath.isNotEmpty) {
                              updateNotifier.installUpdate();
                            } else {
                              updateNotifier.downloadUpdate();
                            }
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: buttonColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      minimumSize: const Size.fromHeight(44),
                      elevation: 5,
                      shadowColor: buttonColor.withAlpha(102),
                      alignment: Alignment.center,
                    ),
                    child: SizedBox(
                      height: 24.0,
                      child: Transform.translate(
                        offset: const Offset(0.0, -2.0),
                        child: Text(
                          updateState.downloadedApkPath.isNotEmpty ? 'Instal' : 'Unduh',
                          textAlign: TextAlign.center,
                          style: labelStyle.copyWith(
                            color: buttonTextColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
