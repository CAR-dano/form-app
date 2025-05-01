import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Shared styles and colors for the application

// Colors
const Color borderColor = Color(0xFFC28CFF);
const Color labelTextColor = Colors.black87;
const Color hintTextColor = Color(0xFFCBCBCB);
const Color selectedDateColor = Color(
  0xFF4C1C82,
); // Specific selected date color

const Color iconColor = borderColor; // Color for the dropdown icon

// Error Color
const Color errorBorderColor = Color(0xFFE24717);

// Date Picker Colors
const Color pickedDateColor = Color(0xFFFF7D43); // Orange color for picked date

// Navigation Button Colors
const Color buttonColor = Color(0xFFFF7D43);
const Color disabledButtonColor = Colors.grey;
const Color buttonTextColor = Colors.white;

// Text Styles
final TextStyle labelStyle = GoogleFonts.rubik(
  fontSize: 20.0,
  fontWeight: FontWeight.w400,
  color: labelTextColor,
);

final TextStyle hintTextStyle = GoogleFonts.rubik(
  fontSize: 16.0,
  color: hintTextColor,
  fontWeight: FontWeight.w400,
);

// Navigation Button Text Style
final TextStyle buttonTextStyle = GoogleFonts.rubik(
  fontSize: 18.0,
  fontWeight: FontWeight.bold,
  color: buttonTextColor,
);

final TextStyle selectedDateTextStyle = GoogleFonts.rubik(
  fontSize: 16.0,
  color: selectedDateColor,
  fontWeight: FontWeight.w400,
);

final TextStyle inputTextStyling = GoogleFonts.rubik(
  fontSize: 16.0,
  color: Colors.black,
  fontWeight: FontWeight.w400,
);

final TextStyle hintTextStyling = GoogleFonts.rubik(
  fontSize: 16.0,
  color: hintTextColor,
  fontWeight: FontWeight.w400,
);
