import 'package:flutter/material.dart';
import 'package:form_app/pages/page_one.dart';
import 'package:form_app/widgets/common_layout.dart'; // Import the new layout


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

      debugShowCheckedModeBanner: false,
      // Wrap PageOne with CommonLayout
      // You can optionally pass a title here if needed for PageOne's AppBar
      home: const CommonLayout(child: PageOne()),
    );
  }
}
