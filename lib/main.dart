import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_app/pages/multi_step_form_screen.dart'; // Import MultiStepFormScreen


void main() {
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
