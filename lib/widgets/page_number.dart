import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageNumber extends StatelessWidget {
  const PageNumber({super.key, required this.data});
  final String data;

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: GoogleFonts.rubik( // Use Rubik font from Google Fonts
        fontSize: 48,
        color: const Color(0xFFF4622F), // Hex color #F4622F
        fontWeight: FontWeight.w300, 
      ),
    );
  }
}