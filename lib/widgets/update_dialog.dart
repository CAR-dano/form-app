import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/services/update_service.dart';

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

    return AlertDialog(
      title: Text('Update Available! (v${updateState.latestVersion})'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('A new version of the app is available. Here are the changes:'),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(8),
              ),
              child: Text(updateState.releaseNotes.isNotEmpty
                  ? updateState.releaseNotes
                  : 'No release notes provided.'),
            ),
            if (updateState.isDownloading) ...[
              const SizedBox(height: 20),
              LinearProgressIndicator(value: updateState.downloadProgress),
              const SizedBox(height: 8),
              Center(
                child: Text('${(updateState.downloadProgress * 100).toStringAsFixed(0)}%'),
              )
            ],
            if (updateState.errorMessage.isNotEmpty) ...[
              const SizedBox(height: 16),
              Text(
                'Error: ${updateState.errorMessage}',
                style: const TextStyle(color: Colors.red),
              ),
            ]
          ],
        ),
      ),
      actions: [
        if (!updateState.isDownloading && updateState.downloadedApkPath.isEmpty)
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('Later'),
          ),
        
        ElevatedButton(
          onPressed: updateState.isDownloading
              ? null // Disable button while downloading
              : () {
                  if (updateState.downloadedApkPath.isNotEmpty) {
                    updateNotifier.installUpdate();
                  } else {
                    updateNotifier.downloadUpdate();
                  }
                },
          child: Text(
            updateState.downloadedApkPath.isNotEmpty ? 'Install' : 'Download',
          ),
        ),
      ],
    );
  }
}
