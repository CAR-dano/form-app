import 'package:dio/dio.dart' as dio;
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
    if (state.isLoading) return;
    state = state.copyWith(isLoading: true, errorMessage: '');

    try {
      // 1. Get current app version
      final packageInfo = await PackageInfo.fromPlatform();
      final currentVersion = packageInfo.version;

      // 2. Fetch latest release from GitHub
      final response = await dio.Dio().get(
        'https://api.github.com/repos/$githubOwner/$githubRepo/releases/latest',
      );

      final latestVersion = (response.data['tag_name'] as String).replaceAll('v', '');
      final releaseNotes = response.data['body'] as String;
      final assets = response.data['assets'] as List;
      final apkAsset = assets.firstWhere(
        (asset) => (asset['name'] as String).contains('arm64-v8a-release.apk'),
        orElse: () => null,
      );

      if (apkAsset == null) {
        // It's good practice to add a fallback in case the specific APK isn't found
        final universalApkAsset = assets.firstWhere(
          (asset) => (asset['name'] as String).contains('universal-release.apk'),
          orElse: () => null
        );
        if (universalApkAsset == null) {
          throw Exception('No arm64-v8a or universal .apk file found in the latest release.');
        }
        final apkDownloadUrl = universalApkAsset['browser_download_url'] as String;
        // ... continue with comparison logic using universalApkAsset ...
         if (_isNewerVersion(latestVersion, currentVersion)) {
          state = state.copyWith(
            isLoading: false,
            newVersionAvailable: true,
            latestVersion: latestVersion,
            releaseNotes: releaseNotes,
            apkDownloadUrl: apkDownloadUrl,
          );
        } else {
          state = state.copyWith(isLoading: false, newVersionAvailable: false);
        }

        return; // Exit after handling the fallback
      }

      final apkDownloadUrl = apkAsset['browser_download_url'] as String;

      // 3. Compare versions (no changes here)
      if (_isNewerVersion(latestVersion, currentVersion)) {
        state = state.copyWith(
          isLoading: false,
          newVersionAvailable: true,
          latestVersion: latestVersion,
          releaseNotes: releaseNotes,
          apkDownloadUrl: apkDownloadUrl,
        );
      } else {
        state = state.copyWith(isLoading: false, newVersionAvailable: false);
      }
    } catch (e) {
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
    final newParts = newVersion.split('.').map(int.parse).toList();
    final currentParts = currentVersion.split('.').map(int.parse).toList();

    for (int i = 0; i < newParts.length; i++) {
      if (i >= currentParts.length) return true;
      if (newParts[i] > currentParts[i]) return true;
      if (newParts[i] < currentParts[i]) return false;
    }
    return false;
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
