import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/pages/multi_step_form_screen.dart'; // Import MultiStepFormScreen
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import flutter_dotenv
import 'package:form_app/providers/tambahan_image_data_provider.dart'; // Import the provider
import 'dart:io'; // For FileImage
import 'package:flutter/services.dart'; // Import for SystemChrome

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter bindings are initialized
  await SystemChrome.setPreferredOrientations([ // Add this block
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await dotenv.load(fileName: ".env"); // Load environment variables
  runApp(const ProviderScope(child: FormApp()));
}

class FormApp extends ConsumerStatefulWidget {
  const FormApp({super.key});

  @override
  ConsumerState<FormApp> createState() => _FormAppState();
}

class _FormAppState extends ConsumerState<FormApp> {
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
          } catch (e) {
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
      home: const MultiStepFormScreen(), // Set MultiStepFormScreen as home
    );
  }
}
