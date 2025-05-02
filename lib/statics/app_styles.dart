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
const Color pageNumberColor = Color(0xFFF4622F); // Hex color #F4622F

// Error Color
const Color errorBorderColor = Color(0xFFE24717);

// Date Picker Colors
const Color pickedDateColor = Color(0xFFFF7D43); // Orange color for picked date

// Navigation Button Colors
const Color buttonColor = Color(0xFFFF7D43);
const Color disabledButtonColor = Colors.grey;
const Color buttonTextColor = Colors.white;

// Toggle Option Colors
const Color toggleOptionSelectedLengkapColor = Color(0xFF30B6ED);
const Color toggleOptionSelectedTidakColor = Color(0xFFFF80B4);

// Numbered Button Colors
const Map<int, Color> numberedButtonColors = {
  1: Color(0xFFF14091),
  2: Color(0xFFE35488),
  3: Color(0xFFD76582),
  4: Color(0xFFCF727D),
  5: Color(0xFFC38377),
  6: Color(0xFFB79271),
  7: Color(0xFFAD9F6A),
  8: Color(0xFFA2B164),
  9: Color(0xFF97BF5E),
  10: Color(0xFF98BE5F),
};

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

final TextStyle pageTitleStyle = GoogleFonts.rubik(
  fontSize: 40.0,
  fontWeight: FontWeight.w500,
  color: labelTextColor, // Assuming page title color is the same as label text color
);

final TextStyle pageNumberStyle = GoogleFonts.rubik(
  fontSize: 48,
  color: pageNumberColor,
  fontWeight: FontWeight.w300,
);

// Toggle Option Text Styles
final TextStyle toggleOptionTextStyle = GoogleFonts.rubik(
  fontSize: 16.0,
  fontWeight: FontWeight.bold,
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
