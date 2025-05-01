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
  late TextEditingController _internalController;
  late FocusNode _focusNode;
  List<String> _lines = []; // List to store lines

  @override
  void initState() {
    super.initState();
    _internalController = widget.controller ?? TextEditingController(text: widget.initialValue);
    if (widget.initialValue != null && widget.initialValue!.isNotEmpty) {
      _lines = widget.initialValue!.split('\n'); // Initialize lines from initial value
    } else {
      _lines = ['']; // Start with one empty line
    }

    if (widget.controller != null) {
      // If an external controller is provided, copy its text and listen for changes
      widget.controller!.addListener(_handleExternalControllerChange);
    }

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange); // Listen for focus changes
  }

  @override
  void dispose() {
    if (widget.controller != null) {
      widget.controller!.removeListener(_handleExternalControllerChange);
    }
    if (widget.controller == null) {
      _internalController.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.removeListener(_handleFocusChange); // Remove listener
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleExternalControllerChange() {
    // Update internal controller and lines when external controller changes
    _internalController.text = widget.controller!.text;
    _lines = _internalController.text.split('\n');
  }

  void _handleFocusChange() {
    if (_focusNode.hasFocus && _internalController.text.isEmpty) {
      // If gains focus and is empty, add the first bullet point line
      setState(() {
        _lines = ['• '];
        _internalController.text = _lines.join('\n');
        // Position cursor after the bullet point
        _internalController.selection = TextSelection.fromPosition(
            TextPosition(offset: _internalController.text.length));
      });
    }
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        final text = _internalController.text;
        final selection = _internalController.selection;
        if (selection.isValid) {
          final currentLineIndex = text.substring(0, selection.start).split('\n').length - 1;
          final newText = text.replaceRange(selection.start, selection.end, '\n• ');

          setState(() {
            _lines = newText.split('\n');
            _internalController.value = TextEditingValue(
              text: newText,
              selection: TextSelection.fromPosition(
                TextPosition(offset: selection.start + 3), // Move cursor after bullet and space
              ),
            );
             widget.onChanged?.call(_internalController.text); // Call onChanged
             if (widget.controller != null) {
                widget.controller!.text = _internalController.text; // Update external controller
             }
          });
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
                  setState(() {
                    _lines = value.split('\n'); // Update lines on text change
                     widget.onChanged?.call(_internalController.text); // Call onChanged
                     if (widget.controller != null) {
                        widget.controller!.text = _internalController.text; // Update external controller
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
