import 'dart:io';

import 'package:dio/dio.dart' as dio;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:open_file/open_file.dart';

// --- CONFIGURATION ---
const String githubOwner = 'CAR-dano';
const String githubRepo = 'form-app';
// ---------------------

final updateServiceProvider = StateNotifierProvider<UpdateNotifier, UpdateState>((ref) {
  return UpdateNotifier();
});

class UpdateState {
  final bool isLoading;
  final bool isDownloading;
  final bool newVersionAvailable;
  final double downloadProgress;
  final String latestVersion;
  final String releaseNotes;
  final String apkDownloadUrl;
  final String downloadedApkPath;
  final String apkFileName; // New field for the exact APK filename from GitHub
  final String errorMessage;
  final String? fileSize; // New field for formatted file size
  final int? rawFileSize; // New field for raw file size in bytes

  UpdateState({
    this.isLoading = false,
    this.isDownloading = false,
    this.newVersionAvailable = false,
    this.downloadProgress = 0.0,
    this.latestVersion = '',
    this.releaseNotes = '',
    this.apkDownloadUrl = '',
    this.downloadedApkPath = '',
    this.apkFileName = '', // Initialize new field
    this.errorMessage = '',
    this.fileSize, // Initialize new field
    this.rawFileSize, // Initialize new field
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
    String? apkFileName, // New field for copyWith
    String? errorMessage,
    String? fileSize, // New field for copyWith
    int? rawFileSize, // New field for copyWith
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
      apkFileName: apkFileName ?? this.apkFileName, // Copy new field
      errorMessage: errorMessage ?? this.errorMessage,
      fileSize: fileSize ?? this.fileSize, // Copy new field
      rawFileSize: rawFileSize ?? this.rawFileSize, // Copy new field
    );
  }
}

class UpdateNotifier extends StateNotifier<UpdateState> {
  UpdateNotifier() : super(UpdateState()) {
    _loadDownloadedApkPath();
  }

  static const String _apkPathFileName = 'downloaded_apk_path.txt';

  Future<void> _loadDownloadedApkPath() async {
    try {
      final dir = await getDownloadsDirectory(); // Use external Downloads directory
      if (dir == null) {
        debugPrint('UpdateService: Downloads directory not available.');
        state = state.copyWith(downloadedApkPath: '');
        return;
      }
      final file = File('${dir.path}/$_apkPathFileName');
      if (await file.exists()) {
        final path = await file.readAsString();
        if (await File(path).exists()) {
          state = state.copyWith(downloadedApkPath: path);
          debugPrint('UpdateService: Loaded downloaded APK path: $path');
        } else {
          // If the file doesn't exist at the recorded path, clear the record
          await file.delete();
          state = state.copyWith(downloadedApkPath: '');
          debugPrint('UpdateService: Recorded APK file not found, cleared path.');
        }
      }
    } catch (e) {
      debugPrint('UpdateService: Error loading downloaded APK path: $e');
      state = state.copyWith(downloadedApkPath: '');
    }
  }

  Future<void> _saveDownloadedApkPath(String path) async {
    try {
      final dir = await getDownloadsDirectory(); // Use external Downloads directory
      if (dir == null) {
        debugPrint('UpdateService: Downloads directory not available for saving.');
        return;
      }
      final file = File('${dir.path}/$_apkPathFileName');
      await file.writeAsString(path);
      debugPrint('UpdateService: Saved downloaded APK path: $path');
    } catch (e) {
      debugPrint('UpdateService: Error saving downloaded APK path: $e');
    }
  }

  Future<void> _clearDownloadedApkPath() async {
    try {
      final dir = await getDownloadsDirectory(); // Use external Downloads directory
      if (dir == null) {
        debugPrint('UpdateService: Downloads directory not available for clearing.');
        return;
      }
      final file = File('${dir.path}/$_apkPathFileName');
      if (await file.exists()) {
        await file.delete();
        debugPrint('UpdateService: Cleared downloaded APK path record.');
      }
    } catch (e) {
      debugPrint('UpdateService: Error clearing downloaded APK path: $e');
    }
  }

  Future<void> checkForUpdate() async {
    debugPrint('UpdateService: Checking for updates...');
    if (state.isLoading) {
      debugPrint('UpdateService: Already checking for updates. Aborting.');
      return;
    }
    state = state.copyWith(isLoading: true, errorMessage: '');

    // Always re-check if the downloaded APK still exists before checking for updates
    if (state.downloadedApkPath.isNotEmpty) {
      final fileExists = await File(state.downloadedApkPath).exists();
      if (!fileExists) {
        state = state.copyWith(downloadedApkPath: '');
        await _clearDownloadedApkPath();
        debugPrint('UpdateService: Previously downloaded APK not found, cleared state.');
      }
    }

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
      final rawFileSize = apkAsset['size'] as int; // Get raw file size in bytes
      final formattedFileSize = _formatBytes(rawFileSize); // Format for display
      debugPrint('UpdateService: Found APK: ${apkAsset['name']}. Download URL: $apkDownloadUrl, Size: $formattedFileSize');

      // 3. Compare versions
      if (_isNewerVersion(latestVersion, fullCurrentVersion)) {
        debugPrint('UpdateService: New version available: $latestVersion');
        state = state.copyWith(
          isLoading: false,
          newVersionAvailable: true,
          latestVersion: latestVersion,
          releaseNotes: releaseNotes,
          apkDownloadUrl: apkDownloadUrl,
          apkFileName: Uri.decodeComponent(apkAsset['name'] as String), // Store the decoded filename
          fileSize: formattedFileSize, // Store formatted file size
          rawFileSize: rawFileSize, // Store raw file size
        );
      } else {
        debugPrint('UpdateService: No newer version available.');
        state = state.copyWith(isLoading: false, newVersionAvailable: false);

        if (state.downloadedApkPath.isNotEmpty) {
          debugPrint('UpdateService: Cleaning up obsolete APK: ${state.downloadedApkPath}');
          try {
            final oldApkFile = File(state.downloadedApkPath);
            if (await oldApkFile.exists()) {
              await oldApkFile.delete();
              debugPrint('UpdateService: Obsolete APK deleted successfully.');
            }
          } catch (e) {
            debugPrint('UpdateService: Error deleting obsolete APK: $e');
          } finally {
            // Always clear the path from state and storage after attempting deletion
            state = state.copyWith(downloadedApkPath: '');
            await _clearDownloadedApkPath();
          }
        }
        // --- END OF NEW LOGIC ---
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
      Directory? dir;
      
      if (Platform.isAndroid) {
        debugPrint('UpdateService: Attempting download on Android platform');
        
        // First, try to use app-specific external files directory (doesn't require permissions)
        try {
          final externalDir = await getExternalStorageDirectory();
          if (externalDir != null) {
            dir = Directory('${externalDir.path}/downloads');
            if (!await dir.exists()) {
              await dir.create(recursive: true);
            }
            debugPrint('UpdateService: Using external storage directory: ${dir.path}');
          }
        } catch (e) {
          debugPrint('UpdateService: Failed to access external storage directory: $e');
        }
        
        // Fallback: Use app-specific files directory
        if (dir == null) {
          final appDir = await getApplicationDocumentsDirectory();
          dir = Directory('${appDir.path}/downloads');
          if (!await dir.exists()) {
            await dir.create(recursive: true);
          }
          debugPrint('UpdateService: Using app-specific directory: ${dir.path}');
        }
      } else {
        // For non-Android platforms, use the regular downloads directory
        dir = await getDownloadsDirectory();
      }

      if (dir == null) {
        throw Exception('Downloads directory not available.');
      }
      
      final filePath = '${dir.path}/${state.apkFileName}'; // Use the stored decoded filename
      debugPrint('UpdateService: Downloading APK to: $filePath with name: ${state.apkFileName}');
      
      await dio.Dio().download(
        state.apkDownloadUrl,
        filePath,
        onReceiveProgress: (received, total) {
          if (total != -1) {
            final progress = received / total;
            state = state.copyWith(downloadProgress: progress, rawFileSize: total);
          }
        },
      );

      // Verify file size after download
      final downloadedFile = File(filePath);
      if (!await downloadedFile.exists()) {
        throw Exception('Downloaded APK file not found at $filePath');
      }
      final actualFileSize = await downloadedFile.length();
      if (state.rawFileSize != null && actualFileSize != state.rawFileSize) {
        // Delete incomplete file
        await downloadedFile.delete();
        throw Exception('Downloaded APK size mismatch. Expected ${state.rawFileSize} bytes, got $actualFileSize bytes.');
      }

      state = state.copyWith(isDownloading: false, downloadedApkPath: filePath);
      await _saveDownloadedApkPath(filePath);
      debugPrint('UpdateService: APK downloaded successfully to: $filePath');
    } catch (e) {
      state = state.copyWith(isDownloading: false, errorMessage: e.toString());
    }
  }

  Future<void> installUpdate() async {
    if (state.downloadedApkPath.isEmpty) {
      debugPrint('UpdateService: No APK downloaded to install.');
      return;
    }

    debugPrint('UpdateService: Attempting to install APK from: ${state.downloadedApkPath}');
    
    try {
      await _requestInstallApkPermission(state.downloadedApkPath);
      debugPrint('UpdateService: Install permission requested and APK opened.');
      // // Delete the APK file after successful installation
      // try {
      //   final file = File(state.downloadedApkPath);
      //   if (await file.exists()) {
      //     await file.delete();
      //     debugPrint('UpdateService: Downloaded APK deleted successfully.');
      //     state = state.copyWith(downloadedApkPath: ''); // Clear the path after deletion
      //     await _clearDownloadedApkPath(); // Clear the saved path
      //   }
      // } catch (e) {
      //   debugPrint('UpdateService: Error deleting downloaded APK: $e');
      // }
    } catch (e) {
      state = state.copyWith(errorMessage: 'Could not open installer: $e');
      debugPrint('UpdateService: Failed to open installer: $e');
    }
  }

  // Request permission to install unknown apps
  static Future<void> _requestInstallApkPermission(String savePath) async {
    final status = await Permission.requestInstallPackages.status;
    if (status.isGranted) {
      await _openDownloadedUpdateApk(savePath);
    } else {
      final newStatus = await Permission.requestInstallPackages.request();
      if (newStatus.isGranted) {
        await _openDownloadedUpdateApk(savePath);
      } else {
        debugPrint('Permission to install unknown apps on Android not granted');
      }
    }
  }

  // Install the APK using open_file
  static Future<void> _openDownloadedUpdateApk(String savePath) async {
    final result = await OpenFile.open(savePath, type: 'application/vnd.android.package-archive');
    if (result.type != ResultType.done) {
      debugPrint('Open APK Failed: ${result.message}');
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

  String _formatBytes(int bytes) {
    if (bytes <= 0) return "0 B";
    const suffixes = ["B", "KB", "MB", "GB", "TB"];
    int i = (bytes > 0 ? (bytes.toString().length - 1) : 0) ~/ 3;
    return '${(bytes / (1 << (i * 10))).toStringAsFixed(1)} ${suffixes[i]}';
  }
}
