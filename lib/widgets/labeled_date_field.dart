import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:form_app/statics/app_styles.dart';
import 'package:google_fonts/google_fonts.dart';

class LabeledDateField extends StatefulWidget {
  final String label;
  final String hintText; // Placeholder when no date is selected
  final DateTime? initialDate; // Optional initial date
  final ValueChanged<DateTime?>? onChanged; // Callback when date changes
  final FocusNode? focusNode; // Optional focus node
  final FormFieldValidator<DateTime?>? validator; // Optional validator
  final bool formSubmitted; // Add formSubmitted parameter
  final DateTime? lastDate; // Add lastDate parameter

  // --- End Styles ---

  const LabeledDateField({
    super.key,
    required this.label,
    this.hintText = 'Pilih tanggal', // Default hint
    this.initialDate,
    this.onChanged,
    this.focusNode, // Accept optional focus node
    this.validator, // Accept optional validator
    this.formSubmitted = false, // Default to false
    this.lastDate, // Accept optional lastDate
  });

  @override
  State<LabeledDateField> createState() => _LabeledDateFieldState();
}

class _LabeledDateFieldState extends State<LabeledDateField> {
  DateTime? _selectedDate;
  late FocusNode _focusNode;
  final _fieldKey = GlobalKey<FormFieldState>(); // Key for managing form field state

  @override
  void initState() {
    super.initState();
    // Initialize the state with the initialDate provided to the widget
    _selectedDate = widget.initialDate;
    _focusNode = FocusNode();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  // Helper function to build the input decoration, similar to LabeledTextField
  InputDecoration _buildInputDecoration() {
    return InputDecoration(
      // No hintText here, handled by the Text widget logic
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0),
      isDense: true, // Make the input decorator more compact
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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000), // Sensible default range start
      lastDate: widget.lastDate ?? DateTime.now(), // Use the provided lastDate or default to today
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

    // Request focus for this widget after the date picker is closed
    _focusNode.requestFocus();

    // Check if the widget is still mounted before interacting with context or state
    if (!mounted) return; // Exit if the widget was removed during the await

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
        // Use FormField to integrate with Form and provide validation
        FormField<DateTime?>(
          key: _fieldKey, // Assign the field key
          initialValue: _selectedDate,
          validator: widget.validator, // Use the provided validator
          builder: (FormFieldState<DateTime?> field) {
            return InputDecorator( // Use InputDecorator for consistent styling
              decoration: _buildInputDecoration().copyWith(
                // Display error text if validation fails
                errorText: field.errorText,
                // Customize border color based on validation state
                 enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: field.hasError ? errorBorderColor : borderColor, // Error color or default
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide(
                    color: field.hasError ? errorBorderColor : borderColor, // Error color or default
                    width: 2.0,
                  ),
                ),
                 errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: errorBorderColor, width: 1.5), // Error color
                ),
                 focusedErrorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: const BorderSide(color: errorBorderColor, width: 2.0), // Error color
                ),
              ),
              isEmpty: field.value == null,
              child: InkWell(
                onTap: () async {
                   // Use the provided focusNode if available, otherwise use the internal one
                  (widget.focusNode ?? _focusNode).requestFocus(); // Request focus for this widget
                  await _selectDate(context); // Call the _selectDate function

                  // After _selectDate updates _selectedDate, update the FormField's value
                  // and call the onChanged callback if a date was picked and is different.
                  // _selectDate already handles the mounted check and the picked != null check.
                  if (_selectedDate != null && _selectedDate != field.value) {
                     field.didChange(_selectedDate);
                     widget.onChanged?.call(_selectedDate);
                     // Trigger validation if the form has been submitted
                     if (widget.formSubmitted) {
                       _fieldKey.currentState?.validate();
                     }
                  }
                },
                 focusNode: widget.focusNode ?? _focusNode, // Assign the focus node to InkWell
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    // --- Display Text (Hint or Formatted Date) ---
                    Text(
                      field.value == null
                          ? widget.hintText // Show hint text if no date selected
                          : DateFormat('dd/MM/yyyy').format(field.value!), // Show formatted date
                      style: field.value == null
                          ? hintTextStyle // Access hintTextStyle from AppStyles
                          : selectedDateTextStyle.copyWith(color: selectedDateColor), // Explicitly set color
                    ),
                    // --- Dropdown Icon ---
                    Icon(Icons.arrow_drop_down, color: field.hasError ? errorBorderColor : iconColor), // Access iconColor from AppStyles
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
