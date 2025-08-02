import 'package:flutter/foundation.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A utility class for handling Crashlytics error reporting.
/// Provided via Riverpod to ensure a single instance and testability.
class CrashlyticsUtil {
  final FirebaseCrashlytics _crashlytics;

  CrashlyticsUtil(this._crashlytics);

  /// Records an error with Crashlytics if in release mode.
  /// In debug mode, it prints the error to the console.
  ///
  /// - [exception]: The exception object.
  /// - [stack]: The stack trace.
  /// - [reason]: An optional description of the error.
  /// - [fatal]: Whether the error should be recorded as fatal. Defaults to `false`.
  void recordError(
    dynamic exception,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) {
    if (kDebugMode) {
      // Log to console in debug mode for immediate feedback.
      debugPrint('--- Crashlytics Suppressed in Debug Mode ---');
      debugPrint('Error: $exception');
      if (reason != null) {
        debugPrint('Reason: $reason');
      }
      debugPrint('Stack trace:\n$stack');
      debugPrint('-------------------------------------------');
      return;
    }

    // Send to Crashlytics in release mode.
    _crashlytics.recordError(
      exception,
      stack,
      reason: reason,
      fatal: fatal,
    );
  }
}

/// Riverpod provider for the CrashlyticsUtil singleton.
final crashlyticsUtilProvider = Provider<CrashlyticsUtil>((ref) {
  return CrashlyticsUtil(FirebaseCrashlytics.instance);
});
