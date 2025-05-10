import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart';

class LabeledDropdownField<T> extends StatefulWidget {
  final String label;
  final List<DropdownMenuItem<T>> items;
  final String? hintText;
  final ValueChanged<T?>? onChanged;
  final T? value;
  final FormFieldValidator<T?>? validator;

  const LabeledDropdownField({
    super.key,
    required this.label,
    required this.items,
    this.hintText,
    this.onChanged,
    this.value,
    this.validator,
  });

  @override
  State<LabeledDropdownField<T>> createState() => _LabeledDropdownFieldState<T>();
}

class _LabeledDropdownFieldState<T> extends State<LabeledDropdownField<T>> {
  final _formFieldKey = GlobalKey<FormFieldState>(); // Key for managing form field state

  @override
  Widget build(BuildContext context) {
    // Determine icon color based on validation state
    Color dropdownIconColor = _formFieldKey.currentState?.hasError == true
        ? errorBorderColor
        : iconColor; // Use the default icon color from AppStyles

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: 4.0),
        SizedBox( // Wrap with SizedBox
          width: double.infinity, // Set width to match parent
          child: DropdownButtonFormField<T>(
            key: _formFieldKey, // Assign the key
            value: widget.value,
            hint: Text(widget.hintText!, style: hintTextStyling),
            items: widget.items,
            onChanged: (newValue) {
              widget.onChanged?.call(newValue);
              // Trigger validation on change to update icon color
              _formFieldKey.currentState?.validate();
            },
            validator: widget.validator,
            style: inputTextStyling, // Apply inputTextStyling to selected text
            dropdownColor: Colors.white, // Set the dropdown menu background color to white
            iconEnabledColor: dropdownIconColor, // Use the dynamic icon color
            iconDisabledColor: dropdownIconColor, // Use the dynamic icon color
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.white,
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
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: errorBorderColor, width: 1.5),
              ),
               focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
                borderSide: const BorderSide(color: errorBorderColor, width: 2.0),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
