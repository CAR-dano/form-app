import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/pages/multi_step_form_screen.dart'; // Import MultiStepFormScreen
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Import flutter_dotenv


Future<void> main() async { // Made main async
  await dotenv.load(fileName: ".env"); // Load environment variables
  runApp(const ProviderScope(child: FormApp()));
}

class FormApp extends ConsumerWidget {
  const FormApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
