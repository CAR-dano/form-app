import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class LabeledDateField extends StatefulWidget {
  final String label;
  final String hintText; // Placeholder when no date is selected
  final DateTime? initialDate; // Optional initial date
  final ValueChanged<DateTime?>? onChanged; // Callback when date changes

  // --- Define Styles and Colors here for consistency ---
  static const Color borderColor = Color(0xFFC28CFF); // Purple from LabeledTextField
  static const Color labelTextColor = Colors.black87;
  static const Color hintTextColor = Color(0xFFCBCBCB);
  static const Color selectedDateColor = Color(0xFF4C1C82); // Specific selected date color
  static const Color iconColor = Colors.grey; // Color for the dropdown icon

  static final TextStyle labelStyle = GoogleFonts.rubik(
    fontSize:20.0,
    fontWeight: FontWeight.w500,
    color: labelTextColor,
  );

  static final TextStyle hintTextStyle = GoogleFonts.rubik(
    fontSize: 16.0,
    color: hintTextColor,
    fontWeight: FontWeight.w400,
  );

  static final TextStyle selectedDateTextStyle = GoogleFonts.rubik(
    fontSize: 16.0,
    color: selectedDateColor, // Use the specific purple
    fontWeight: FontWeight.w400,
  );
  // --- End Styles ---

  const LabeledDateField({
    super.key,
    required this.label,
    this.hintText = 'Pilih tanggal', // Default hint
    this.initialDate,
    this.onChanged,
  });

  @override
  State<LabeledDateField> createState() => _LabeledDateFieldState();
}

class _LabeledDateFieldState extends State<LabeledDateField> {
  DateTime? _selectedDate;

  @override
  void initState() {
    super.initState();
    // Initialize the state with the initialDate provided to the widget
    _selectedDate = widget.initialDate;
  }

  // Helper function to build the input decoration, similar to LabeledTextField
  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      // No hintText here, handled by the Text widget logic
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: LabeledDateField.borderColor, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: LabeledDateField.borderColor, width: 1.5),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: LabeledDateField.borderColor, width: 2.0),
      ),
      // Could add error borders if validation is needed later
    );
  }

  // Date Picker Function
  Future<void> _selectDate(BuildContext context) async {
    // Dismiss keyboard if any field has focus
    FocusScope.of(context).unfocus();

    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // Sensible default range start
      lastDate: DateTime(2101), // Sensible default range end
      // Add theme customization here if needed
    );

    // Check if the widget is still mounted before interacting with context or state
    if (!mounted) return; // Exit if the widget was removed during the await

    // Unfocus again after the picker is closed to prevent keyboard reappearing
    // on the previously focused text field.
    FocusScope.of(context).unfocus();

    // Check if a date was actually picked and it's different
    if (picked != null && picked != _selectedDate) {
      // No need for another mounted check here as setState does it internally,
      // but it's good practice to be aware.
      setState(() {
        _selectedDate = picked; // Update local state to refresh UI
      });
      // Call the callback function provided by the parent widget
      widget.onChanged?.call(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // --- Label ---
        Text(widget.label, style: LabeledDateField.labelStyle),
        const SizedBox(height: 8.0),

        // --- Tappable Date Input Area ---
        InkWell(
          onTap: () => _selectDate(context),
          child: InputDecorator( // Use InputDecorator for consistent styling
            decoration: _buildInputDecoration(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                // --- Display Text (Hint or Formatted Date) ---
                Text(
                  _selectedDate == null
                      ? widget.hintText // Show hint text if no date selected
                      : DateFormat('dd/MM/yyyy').format(_selectedDate!), // Show formatted date
                  style: _selectedDate == null
                      ? LabeledDateField.hintTextStyle // Style for hint
                      : LabeledDateField.selectedDateTextStyle, // Specific style for selected date
                ),
                // --- Dropdown Icon ---
                const Icon(Icons.arrow_drop_down, color: LabeledDateField.iconColor),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
