import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/services/update_service.dart';
import 'package:form_app/statics/app_styles.dart';

void showUpdateDialog(BuildContext context) {
  showDialog(
    context: context,
    barrierDismissible: false,
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
              'Update Available! (v${updateState.latestVersion})',
              textAlign: TextAlign.center,
              style: labelStyle.copyWith(
                fontSize: 24,
                fontWeight: FontWeight.w300,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 24.0),
            Text(
              'A new version of the app is available. Here are the changes:',
              textAlign: TextAlign.center,
              style: labelStyle.copyWith(
                fontSize: 16,
                color: darkTextColor,
              ),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12.0),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!),
              ),
              constraints: const BoxConstraints(maxHeight: 150), // Limit height for release notes
              child: SingleChildScrollView(
                child: Text(
                  updateState.releaseNotes.isNotEmpty
                      ? updateState.releaseNotes
                      : 'No release notes provided.',
                  style: labelStyle.copyWith(fontSize: 14, color: darkTextColor),
                ),
              ),
            ),
            if (updateState.isDownloading) ...[
              const SizedBox(height: 20),
              LinearProgressIndicator(
                value: updateState.downloadProgress,
                backgroundColor: Colors.grey[300],
                valueColor: AlwaysStoppedAnimation<Color>(buttonColor),
              ),
              const SizedBox(height: 8),
              Center(
                child: Text(
                  'Downloading: ${(updateState.downloadProgress * 100).toStringAsFixed(0)}%',
                  style: labelStyle.copyWith(color: darkTextColor),
                ),
              )
            ],
            if (updateState.errorMessage.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Error: ${updateState.errorMessage}',
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
                            'Later',
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
                          updateState.downloadedApkPath.isNotEmpty ? 'Install' : 'Download',
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
