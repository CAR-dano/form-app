import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for KeyEvent and TextEditingDelta
import 'package:form_app/statics/app_styles.dart';

class ExpandableTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool formSubmitted;
  final String? initialValue;

  const ExpandableTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.onChanged,
    this.validator,
    this.focusNode,
    this.formSubmitted = false,
    this.initialValue,
  });

  @override
  State<ExpandableTextField> createState() => _ExpandableTextFieldState();
}

class _ExpandableTextFieldState extends State<ExpandableTextField> {
  final _formFieldKey = GlobalKey<FormFieldState>();
  late TextEditingController _internalController; // Revert to standard controller
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController(text: widget.initialValue); // Fix initialization
    if (widget.controller != null) {
      // If an external controller is provided, copy its text and listen for changes
      widget.controller!.addListener(_handleExternalControllerChange);
    }
    _focusNode = widget.focusNode ?? FocusNode();
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.removeListener(_handleExternalControllerChange);
    }
    if (widget.controller == null) { // Only dispose if internal controller was created
      _internalController.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleExternalControllerChange() {
    // Update internal controller when external controller changes
    _internalController.text = widget.controller!.text;
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        final text = _internalController.text;
        final selection = _internalController.selection;
        if (selection.isValid) {
          final newText = text.replaceRange(selection.start, selection.end, '\n• ');
          _internalController.value = TextEditingValue(
            text: newText,
            selection: TextSelection.fromPosition(
              TextPosition(offset: selection.start + 3), // Move cursor after bullet and space
            ),
          );
          return KeyEventResult.handled; // Mark the event as handled
        }
      }
    }
    return KeyEventResult.ignored; // Let other events be handled
  }

  @override
  Widget build(BuildContext context) {
    // Format the hint text as a multi-line unordered list
    final formattedHintText = widget.hintText.split('\n').map((line) => '• $line').join('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: 8.0),
        Focus( // Wrap with Focus widget
          focusNode: _focusNode, // Use the local focus node
          onKeyEvent: _handleKeyEvent, // Use onKeyEvent
          child: Stack(
            children: [
              TextFormField(
                key: _formFieldKey,
                controller: _internalController, // Use the internal controller
                keyboardType: TextInputType.multiline,
                maxLines: null, // Allows the field to expand vertically
                minLines: 3, // Initial height of 3 lines
                onChanged: (value) {
                  setState(() { // Add setState here
                    widget.onChanged?.call(value);
                    if (widget.controller != null) {
                      // Update external controller if provided
                      widget.controller!.text = value;
                    }
                    if (widget.formSubmitted) {
                      _formFieldKey.currentState?.validate();
                    }
                  });
                },
                validator: widget.validator,
                style: inputTextStyling,
                // Removed focusNode from TextFormField
                decoration: InputDecoration(
                  hintText: _internalController.text.isEmpty && !_focusNode.hasFocus ? '' : null, // Hide default hint text
                  hintStyle: hintTextStyling,
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: toggleOptionSelectedLengkapColor, width: 1.5),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: toggleOptionSelectedLengkapColor, width: 1.5),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: toggleOptionSelectedLengkapColor, width: 2.0),
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
        if (_internalController.text.isEmpty) // Modified condition
          Positioned(
            top: 12.0, // Adjust as needed for padding
            left: 16.0, // Adjust as needed for padding
            child: IgnorePointer( // Wrap with IgnorePointer
              child: Text(
                formattedHintText,
                style: hintTextStyling,
              ),
            ),
          ),
            ],
          ),
        ),
      ],
    );
  }
}
