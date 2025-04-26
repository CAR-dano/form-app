import 'package:flutter/material.dart';
import 'package:form_app/pages/identitas_page.dart';

void main() {
  runApp(const FormApp());
}

class FormApp extends StatelessWidget {
  const FormApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Form App',
      theme: ThemeData(),
      home: Placeholder(),
    );
  }
}
