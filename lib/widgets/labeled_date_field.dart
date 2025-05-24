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
    _selectedDate = widget.initialDate;
    _focusNode = widget.focusNode ?? FocusNode(); // Use provided or internal
  }

  @override
  void didUpdateWidget(LabeledDateField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialDate != oldWidget.initialDate) {
      if (_selectedDate != widget.initialDate) {
         WidgetsBinding.instance.addPostFrameCallback((_) {
           if(mounted) {
            setState(() {
              _selectedDate = widget.initialDate;
            });
            _fieldKey.currentState?.didChange(_selectedDate);
           }
         });
      }
    }
    if (widget.focusNode != oldWidget.focusNode) {
        // If an external focus node is now provided, or changes, update our _focusNode.
        // Dispose the old internal one if we created it and it's no longer needed.
        if (oldWidget.focusNode == null && _focusNode != widget.focusNode) {
          _focusNode.dispose();
        }
        _focusNode = widget.focusNode ?? FocusNode();
    }
  }

  @override
  void dispose() {
    // Only dispose the focus node if it was created internally
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  InputDecoration _getBaseInputDecoration() { // Renamed to avoid conflict with FormFieldState's decoration
    return InputDecoration(
      contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 20.0), // Re-added contentPadding
      isDense: true,
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
      // Error borders will be merged from FormFieldState
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: widget.lastDate ?? DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData(
            colorScheme: const ColorScheme.light(
              primary: pickedDateColor,
              onSurface: Colors.black,
              surface: Colors.white,
            ),
            textTheme: Theme.of(context).textTheme.apply(
              fontFamily: GoogleFonts.rubik().fontFamily,
            ),
          ),
          child: child!,
        );
      },
    );

    _focusNode.requestFocus();
    if (!mounted) return;

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
      widget.onChanged?.call(picked);
      // Manually trigger validation on the FormField
      _fieldKey.currentState?.didChange(picked); // Update FormField's value
      if (widget.formSubmitted) {
        _fieldKey.currentState?.validate();
      }
    } else if (picked == null && _selectedDate != null && widget.onChanged != null) {
      // If user cancelled and there was a date, and onChanged is provided,
      // it might be desirable to notify with null if the field should be clearable this way.
      // Or, retain the old date. For now, we only update if 'picked' is different and not null.
      // If you want to clear it on cancel, you might call:
      // setState(() { _selectedDate = null; });
      // widget.onChanged?.call(null);
      // _fieldKey.currentState?.didChange(null);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: 4.0),
        FormField<DateTime?>(
          key: _fieldKey,
          initialValue: _selectedDate,
          validator: widget.validator,
          builder: (FormFieldState<DateTime?> field) {
            // Combine base decoration with error state from FormField
            final effectiveDecoration = _getBaseInputDecoration().copyWith(
              errorText: field.errorText,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: field.hasError ? errorBorderColor : borderColor,
                  width: 1.5,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: BorderSide(
                  color: field.hasError ? errorBorderColor : borderColor,
                  width: 2.0,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: errorBorderColor, width: 1.5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: errorBorderColor, width: 2.0),
              ),
            );

            return InkWell(
              onTap: () => _selectDate(context),
              focusNode: _focusNode,
              customBorder: RoundedRectangleBorder( // Make InkWell's shape match the border
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: InputDecorator(
                decoration: effectiveDecoration,
                isEmpty: field.value == null,
                child: Container( // Ensure the Row takes up the decorator's padded space
                  // This container helps define the minimum height if content is small
                  // The actual padding for content comes from effectiveDecoration.contentPadding
                  // which is implicitly applied by InputDecorator to its child.
                  // If explicit padding control is needed here, ensure it aligns with InputDecoration's contentPadding.
                  // For this use case, relying on InputDecorator's padding of its child (the Row) is standard.
                  constraints: const BoxConstraints(minHeight: 20), // Typical minimum height for a form field line
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        field.value == null
                            ? widget.hintText
                            : DateFormat('dd/MM/yyyy').format(field.value!),
                        style: field.value == null
                            ? hintTextStyle
                            : selectedDateTextStyle.copyWith(color: selectedDateColor),
                      ),
                      Icon(Icons.arrow_drop_down, color: field.hasError ? errorBorderColor : iconColor),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
