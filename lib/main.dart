import 'package:form_app/utils/crashlytics_util.dart';
import 'package:form_app/utils/focus_navigator_observer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/pages/login_page.dart';
import 'package:form_app/pages/multi_step_form_screen.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:form_app/providers/auth_provider.dart';
import 'package:form_app/providers/tambahan_image_data_provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'dart:ui';
import 'package:flutter_native_splash/flutter_native_splash.dart'; // Import flutter_native_splash

Future<void> main() async {
  final WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding); // Preserve the native splash screen

  await SystemChrome.setPreferredOrientations([ // Add this block
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env"); // Load environment variables

  await Firebase.initializeApp();

  // Create a ProviderContainer to access providers before runApp
  final container = ProviderContainer();
  final crashlyticsUtil = container.read(crashlyticsUtilProvider);

  // Set up global error handling using the single instance from the container
  FlutterError.onError = (FlutterErrorDetails details) {
    crashlyticsUtil.recordError(
      details.exception,
      details.stack,
      reason: 'FlutterError',
      fatal: true,
    );
  };

  PlatformDispatcher.instance.onError = (error, stack) {
    crashlyticsUtil.recordError(
      error,
      stack,
      reason: 'PlatformDispatcher',
      fatal: true,
    );
    return true; // Indicate that the error has been handled
  };

  // Use UncontrolledProviderScope to pass the existing container to the widget tree
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const FormApp(),
    ),
  );
}

class FormApp extends ConsumerStatefulWidget {
  const FormApp({super.key});

  @override
  ConsumerState<FormApp> createState() => _FormAppState();
}

class _FormAppState extends ConsumerState<FormApp> {
  late Future<bool> _tokenValidityFuture;

  // List of all identifiers for TambahanImageSelection widgets
  final List<String> _tambahanImageIdentifiers = const [
    'General Tambahan',
    'Eksterior Tambahan',
    'Interior Tambahan',
    'Mesin Tambahan',
    'Kaki-kaki Tambahan',
    'Alat-alat Tambahan',
    'Foto Dokumen',
  ];

  @override
  void initState() {
    super.initState();
    final authService = ref.read(authServiceProvider);
    _tokenValidityFuture = authService.checkTokenValidity();
    // Schedule pre-caching after the first frame
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _precacheAllTambahanImages();
    });
  }

  Future<void> _precacheAllTambahanImages() async {
    // Use the provider to get the CrashlyticsUtil instance
    final crashlytics = ref.read(crashlyticsUtilProvider);

    for (String identifier in _tambahanImageIdentifiers) {
      final images = ref.read(tambahanImageDataProvider(identifier));
      for (var image in images) {
        if (mounted) {
          // Use a try-catch block for robustness, as file might not exist
          try {
            await precacheImage(FileImage(File(image.imagePath)), context);
          } catch (e, stackTrace) {
            crashlytics.recordError(
              e,
              stackTrace,
              reason: 'Error pre-caching image for $identifier',
              fatal: false, // This is not a fatal error
            );
          }
        }
      }
    }
    debugPrint('All Tambahan images pre-cached.');
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Palapa Inspeksi',
      theme: ThemeData(
        useMaterial3: true,
      ),
      debugShowCheckedModeBanner: false,
      navigatorObservers: [FocusNavigatorObserver()],
      home: FutureBuilder<bool>(
        future: _tokenValidityFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            FlutterNativeSplash.remove(); // Remove the splash screen once the future is done
            if (snapshot.data == true) {
              return const MultiStepFormScreen();
            } else {
              return const LoginPage();
            }
          }
          // Return an empty container or null to keep the splash screen visible
          return const SizedBox.shrink(); // Use SizedBox.shrink() to prevent rendering a black screen
        },
      ),
    );
  }
}
