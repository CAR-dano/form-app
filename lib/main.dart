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
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
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

  FlutterError.onError = FirebaseCrashlytics.instance.recordFlutterFatalError;

  PlatformDispatcher.instance.onError = (error, stack) {
    FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
    return true;
  };

  runApp(const ProviderScope(child: FormApp()));
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
    for (String identifier in _tambahanImageIdentifiers) {
      final images = ref.read(tambahanImageDataProvider(identifier));
      for (var image in images) {
        if (mounted) {
          // Use a try-catch block for robustness, as file might not exist
          try {
            await precacheImage(FileImage(File(image.imagePath)), context);
          } catch (e, stackTrace) {
            FirebaseCrashlytics.instance.recordError(e, stackTrace, reason: 'Error pre-caching image for $identifier');
            // Log error if image cannot be pre-cached
            debugPrint('Error precaching image ${image.imagePath}: $e');
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
