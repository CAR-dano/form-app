import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:open_file_plus/open_file_plus.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';

// --- CONFIGURATION ---
const String githubOwner = 'CAR-dano';
const String githubRepo = 'form-app';
// ---------------------

final updateServiceProvider = StateNotifierProvider<UpdateNotifier, UpdateState>((ref) {
  return UpdateNotifier();
});

class UpdateNotifier extends StateNotifier<UpdateState> {
  UpdateNotifier() : super(UpdateState());

  Future<void> checkForUpdate() async {
    debugPrint('UpdateService: Checking for updates...');
    if (state.isLoading) {
      debugPrint('UpdateService: Already checking for updates. Aborting.');
      return;
    }
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // 1. Get current app version
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;
      final currentBuildNumber = packageInfo.buildNumber;
      final fullCurrentVersion = '$currentVersion+$currentBuildNumber';
      debugPrint('UpdateService: Current app version: $fullCurrentVersion');

      // 2. Fetch latest release from GitHub
      debugPrint('UpdateService: Fetching latest release from GitHub: https://api.github.com/repos/$githubOwner/$githubRepo/releases/latest');
      final response = await dio.Dio().get(
        'https://api.github.com/repos/$githubOwner/$githubRepo/releases/latest',
      );

      final latestVersion = (response.data['tag_name'] as String).replaceAll('v', '');
      final releaseNotes = response.data['body'] as String;
      final assets = response.data['assets'] as List;
      debugPrint('UpdateService: Latest release version on GitHub: $latestVersion');

      // Filter for all .apk assets
      final apkAssets = assets.where((asset) {
        final name = asset['name'] as String;
        return name.endsWith('.apk');
      }).toList();

      if (apkAssets.isEmpty) {
        debugPrint('UpdateService: No .apk files found in the latest release.');
        throw Exception('No .apk files found in the latest release.');
      }

      // Prioritize arm64-v8a-release.apk
      dynamic apkAsset = apkAssets.firstWhere(
        (asset) => (asset['name'] as String).contains('arm64-v8a-release.apk'),
        orElse: () => null,
      );

      // If arm64-v8a-release.apk not found, try universal-release.apk
      if (apkAsset == null) {
        debugPrint('UpdateService: arm64-v8a-release.apk not found. Checking for universal-release.apk...');
        apkAsset = apkAssets.firstWhere(
          (asset) => (asset['name'] as String).contains('universal-release.apk'),
          orElse: () => null,
        );
      }

      // If neither specific APK is found, just take the first available APK
      if (apkAsset == null) {
        debugPrint('UpdateService: Neither arm64-v8a nor universal .apk found. Taking the first available .apk.');
        apkAsset = apkAssets.first; // This assumes apkAssets is not empty, which is checked above
      }

      final apkDownloadUrl = apkAsset['browser_download_url'] as String;
      debugPrint('UpdateService: Found APK: ${apkAsset['name']}. Download URL: $apkDownloadUrl');

      // 3. Compare versions
      if (_isNewerVersion(latestVersion, fullCurrentVersion)) {
        debugPrint('UpdateService: New version available: $latestVersion');
        state = state.copyWith(
          isLoading: false,
          newVersionAvailable: true,
          latestVersion: latestVersion,
          releaseNotes: releaseNotes,
          apkDownloadUrl: apkDownloadUrl,
        );
      } else {
        debugPrint('UpdateService: No newer version available.');
        state = state.copyWith(isLoading: false, newVersionAvailable: false);
      }
    } catch (e) {
      debugPrint('UpdateService: Error checking for updates: $e');
      state = state.copyWith(isLoading: false, errorMessage: e.toString());
    }
  }

  Future<void> downloadUpdate() async {
    if (state.isDownloading || state.apkDownloadUrl.isEmpty) return;

    state = state.copyWith(isDownloading: true, downloadProgress: 0.0);

    try {
      final dir = await getTemporaryDirectory();
      final filePath = '${dir.path}/app-release.apk';
      
      await dio.Dio().download(
        state.apkDownloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            state = state.copyWith(downloadProgress: progress);
          }
        },
      );

      state = state.copyWith(isDownloading: false, downloadedApkPath: filePath);
    } catch (e) {
      state = state.copyWith(isDownloading: false, errorMessage: e.toString());
    }
  }

  Future<void> installUpdate() async {
    if (state.downloadedApkPath.isEmpty) return;
    final result = await OpenFile.open(state.downloadedApkPath);
    if (result.type != ResultType.done) {
      state = state.copyWith(errorMessage: 'Could not open installer: ${result.message}');
    }
  }

  // Simple version comparison logic
  bool _isNewerVersion(String newVersion, String currentVersion) {
    final newVersionParts = newVersion.split('+');
    final currentVersionParts = currentVersion.split('+');

    final newSemanticParts = newVersionParts[0].split('.').map(int.parse).toList();
    final currentSemanticParts = currentVersionParts[0].split('.').map(int.parse).toList();

    // Compare semantic versions (e.g., 2.0.4)
    for (int i = 0; i < newSemanticParts.length; i++) {
      if (i >= currentSemanticParts.length) return true; // New version has more parts, assume newer
      if (newSemanticParts[i] > currentSemanticParts[i]) return true;
      if (newSemanticParts[i] < currentSemanticParts[i]) return false;
    }

    // If semantic versions are equal, compare build numbers
    if (newVersionParts.length > 1 && currentVersionParts.length > 1) {
      final newBuild = int.tryParse(newVersionParts[1]) ?? 0;
      final currentBuild = int.tryParse(currentVersionParts[1]) ?? 0;
      return newBuild > currentBuild;
    } else if (newVersionParts.length > 1 && currentVersionParts.length == 1) {
      return true; // New version has a build number, current does not, assume newer
    }

    return false; // Versions are the same or current is newer
  }
}

class UpdateState {
  final bool isLoading;
  final bool isDownloading;
  final bool newVersionAvailable;
  final double downloadProgress;
  final String latestVersion;
  final String releaseNotes;
  final String apkDownloadUrl;
  final String downloadedApkPath;
  final String errorMessage;

  UpdateState({
    this.isLoading = false,
    this.isDownloading = false,
    this.newVersionAvailable = false,
    this.downloadProgress = 0.0,
    this.latestVersion = '',
    this.releaseNotes = '',
    this.apkDownloadUrl = '',
    this.downloadedApkPath = '',
    this.errorMessage = '',
  });

  UpdateState copyWith({
    bool? isLoading,
    bool? isDownloading,
    bool? newVersionAvailable,
    double? downloadProgress,
    String? latestVersion,
    String? releaseNotes,
    String? apkDownloadUrl,
    String? downloadedApkPath,
    String? errorMessage,
  }) {
    return UpdateState(
      isLoading: isLoading ?? this.isLoading,
      isDownloading: isDownloading ?? this.isDownloading,
      newVersionAvailable: newVersionAvailable ?? this.newVersionAvailable,
      downloadProgress: downloadProgress ?? this.downloadProgress,
      latestVersion: latestVersion ?? this.latestVersion,
      releaseNotes: releaseNotes ?? this.releaseNotes,
      apkDownloadUrl: apkDownloadUrl ?? this.apkDownloadUrl,
      downloadedApkPath: downloadedApkPath ?? this.downloadedApkPath,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
