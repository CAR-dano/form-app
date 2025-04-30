import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LabeledTextField extends StatelessWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller; // Allow passing a controller
  final TextInputType keyboardType;
  final bool obscureText;
  final ValueChanged<String>? onChanged; // Callback for changes
  final FormFieldValidator<String>? validator; // For form validation
  final int? maxLines;

  // Define styles and colors centrally or pass them in if needed
  static const Color borderColor = Color(0xFFC28CFF);
  static const Color labelTextColor = Colors.black87;
  static const Color hintTextColor = Color(0xFFCBCBCB);

  static final TextStyle labelStyle = GoogleFonts.rubik(
    fontSize: 20.0,
    fontWeight: FontWeight.w300,
    color: labelTextColor,
  );

  static final TextStyle inputTextStyling = GoogleFonts.rubik(
    fontSize: 16.0,
    color: Colors.black,
    fontWeight: FontWeight.w400,
  );

   static final TextStyle hintTextStyling = GoogleFonts.rubik(
    fontSize: 16.0,
    color: hintTextColor,
    fontWeight: FontWeight.w400,
  );

  const LabeledTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text, // Default to text
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.maxLines = 1, // Default to single line
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: labelStyle),
        const SizedBox(height: 8.0), // Consistent spacing
        TextFormField( // Use TextFormField for validation integration
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          onChanged: onChanged,
          validator: validator,
          maxLines: maxLines,
          style: inputTextStyling,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: hintTextStyling,
            contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: borderColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: borderColor, width: 1.5),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: borderColor, width: 2.0),
            ),
            // Add error border style if needed based on validation feedback
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.5),
            ),
             focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
              borderSide: const BorderSide(color: Colors.red, width: 2.0),
            ),
          ),
        ),
        // No SizedBox needed here usually, as the next LabeledTextField
        // will have its own top label and spacing.
        // Add if separating from non-LabeledTextField widgets
      ],
    );
  }
}