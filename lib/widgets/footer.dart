import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      
      child: Padding(
        padding: EdgeInsets.only(bottom: 20),
        child: Text(
          'copyright by Inspeksi Mobil Jogja',
          style: GoogleFonts.rubik(
            fontSize: 14,
            color: Color(0xFFA8A8A8),
            fontWeight: FontWeight.w300,
          ),
        ),
      ),
    );
  }
}