import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:form_app/services/update_service.dart';
import 'package:form_app/widgets/update_dialog.dart';

class AppVersionDisplay extends ConsumerWidget {
  const AppVersionDisplay({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final updateState = ref.watch(updateServiceProvider);

    if (updateState.newVersionAvailable) {
      return IconButton(
        icon: const Icon(Icons.cloud_download, color: Colors.blue),
        onPressed: () {
          showUpdateDialog(context);
        },
      );
    } else {
      return FutureBuilder<PackageInfo>(
        future: PackageInfo.fromPlatform(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final version = snapshot.data!.version;
            final buildNumber = snapshot.data!.buildNumber;
            return Padding(
              padding: const EdgeInsets.only(right: 16.0),
              child: Text(
                'v$version+$buildNumber',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.black54,
                ),
              ),
            );
          }
          return const SizedBox.shrink(); // Or a loading indicator
        },
      );
    }
  }
}
