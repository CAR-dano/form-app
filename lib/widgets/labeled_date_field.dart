import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class LabeledDateField extends StatefulWidget {
  final String label;
  final String hintText; // Placeholder when no date is selected
  final DateTime? initialDate; // Optional initial date
  final ValueChanged<DateTime?>? onChanged; // Callback when date changes

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
        borderSide: const BorderSide(color: borderColor, width: 1.5), // Access borderColor from AppStyles
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderColor, width: 1.5), // Access borderColor from AppStyles
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8.0),
        borderSide: const BorderSide(color: borderColor, width: 2.0), // Access borderColor from AppStyles
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
      lastDate: DateTime.now(), // Restrict to today's date
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: pickedDateColor, // Color of the selected date
              onSurface: Colors.black, // Color of the dates in the calendar
              surface: Colors.white, // Background color of the date picker
            ),
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: GoogleFonts.rubik().fontFamily, // Use Rubik font
            ),
          ),
          child: child!,
        );
      },
    );

    // Check if the widget is still mounted before interacting with context or state
    if (!mounted) return; // Exit if the widget was removed during the await

    // Unfocus again after the picker is closed to prevent keyboard reappearing
    // on the previously focused text field.
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
        Text(widget.label, style: labelStyle), // Access labelStyle from AppStyles
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
                      ? hintTextStyle // Access hintTextStyle from AppStyles
                      : selectedDateTextStyle, // Access selectedDateTextStyle from AppStyles
                ),
                // --- Dropdown Icon ---
                const Icon(Icons.arrow_drop_down, color: iconColor), // Access iconColor from AppStyles
              ],
            ),
          ),
        ),
      ],
    );
  }
}
