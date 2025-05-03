import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for KeyEvent and TextEditingDelta
import 'package:form_app/statics/app_styles.dart';

class ExpandableTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller; // Keep this if needed elsewhere, but prefer initialLines/onChangedList
  // final ValueChanged<String>? onChanged; // REMOVE or repurpose if needed
  final ValueChanged<List<String>>? onChangedList; // NEW: Callback for list of lines
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool formSubmitted;
  // final String? initialValue; // REMOVE
  final List<String>? initialLines; // NEW: Accept initial list of lines

  const ExpandableTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    // this.onChanged,
    this.onChangedList, // Accept new callback
    this.validator,
    this.focusNode,
    this.formSubmitted = false,
    // this.initialValue,
    this.initialLines, // Accept new initial data
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

    // Initialize _lines from initialLines or set default
    _lines = List<String>.from(widget.initialLines ?? []); // Create a mutable copy
    if (_lines.isEmpty || (_lines.length == 1 && _lines[0].isEmpty)) {
       _lines = ['• ']; // Start with one bullet point line if empty or just [""]
    } else if (_lines.isNotEmpty && !_lines.first.startsWith('• ')) {
       // Optional: Add bullet point if first line doesn't have one
       // _lines[0] = '• ${_lines[0]}';
    }

    // Initialize controller with joined lines
    _internalController = widget.controller ?? TextEditingController(text: _lines.join('\n'));


    if (widget.controller != null) {
      widget.controller!.addListener(_handleExternalControllerChange);
    }

    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

   @override
  void didUpdateWidget(covariant ExpandableTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Optional: If you need to react to external changes in initialLines
    // after the widget has been built once. Be careful with cursor position.
    // if (widget.initialLines != oldWidget.initialLines && widget.controller == null) {
    //   _lines = List<String>.from(widget.initialLines ?? []);
    //    if (_lines.isEmpty || (_lines.length == 1 && _lines[0].isEmpty)) {
    //      _lines = ['• '];
    //    }
    //    final currentSelection = _internalController.selection;
    //   _internalController.text = _lines.join('\n');
       // Try to restore selection if possible, might be tricky
       // _internalController.selection = currentSelection.copyWith(
       //   baseOffset: min(currentSelection.baseOffset, _internalController.text.length),
       //   extentOffset: min(currentSelection.extentOffset, _internalController.text.length),
       // );
    // }
  }


  @override
  void dispose() {
    // ... (dispose logic remains the same) ...
     if (widget.controller != null) {
      widget.controller!.removeListener(_handleExternalControllerChange);
    }
    if (widget.controller == null) {
      _internalController.dispose();
    }
    _focusNode.removeListener(_handleFocusChange);
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleExternalControllerChange() {
    // Update internal lines when external controller changes
    // This might be less common if using initialLines/onChangedList primarily
    if (_internalController.text != widget.controller!.text) {
        _internalController.text = widget.controller!.text;
        _lines = _internalController.text.split('\n');
        // Optionally call onChangedList here if external changes should propagate
        // widget.onChangedList?.call(_lines);
    }
  }


  void _handleFocusChange() {
    if (_focusNode.hasFocus && _internalController.text.isEmpty) {
      setState(() {
        _lines = ['• '];
        _internalController.text = _lines.join('\n');
        _internalController.selection = TextSelection.fromPosition(
            TextPosition(offset: _internalController.text.length));
        widget.onChangedList?.call(_lines); // Notify parent
      });
    } else if (!_focusNode.hasFocus && _internalController.text == '• ') {
       // Optional: Clear if only the initial bullet remains when losing focus
       // setState(() {
       //   _lines = [''];
       //   _internalController.clear();
       //   widget.onChangedList?.call(_lines); // Notify parent
       // });
    }
  }


  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        final text = _internalController.text;
        final selection = _internalController.selection;
        if (selection.isValid) {
          // final currentLineIndex = text.substring(0, selection.start).split('\n').length - 1;
          final newText = text.replaceRange(selection.start, selection.end, '\n• ');

          setState(() {
            _lines = newText.split('\n');
            _internalController.value = TextEditingValue(
              text: newText,
              selection: TextSelection.fromPosition(
                TextPosition(offset: selection.start + 3), // Move cursor after bullet and space
              ),
            );
             // widget.onChanged?.call(_internalController.text); // Remove/update
             widget.onChangedList?.call(_lines); // Call new callback
             if (widget.controller != null) {
                widget.controller!.text = _internalController.text; // Update external controller if used
             }
          });
          return KeyEventResult.handled; // Mark the event as handled
        }
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
          final text = _internalController.text;
          final selection = _internalController.selection;
           // Handle backspace at the beginning of a bulleted line (except the first line)
          if (selection.isCollapsed && selection.start > 1 && text[selection.start-1] == ' ' && text[selection.start-2] == '•' && text[selection.start-3] == '\n') {
             final newText = text.substring(0, selection.start - 3) + text.substring(selection.start);
             setState(() {
                _lines = newText.split('\n');
                 _internalController.value = TextEditingValue(
                   text: newText,
                   selection: TextSelection.fromPosition(
                     TextPosition(offset: selection.start - 3),
                   ),
                 );
                 widget.onChangedList?.call(_lines);
                 if (widget.controller != null) {
                   widget.controller!.text = _internalController.text;
                 }
             });
              return KeyEventResult.handled;
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
                    // Update internal _lines state first
                    _lines = value.split('\n');
                    // Then notify the parent widget via the callback
                    widget.onChangedList?.call(_lines);
                    // Also update external controller if provided (syncing)
                    if (widget.controller != null && widget.controller!.text != value) {
                        widget.controller!.text = value;
                    }
                    // Handle validation triggering
                    if (widget.formSubmitted) {
                        _formFieldKey.currentState?.validate();
                    }
                    // No need for setState here unless onChanged itself needs to trigger a rebuild
                    // of *this* widget specifically (which is unlikely for just text changes).
                },
                validator: widget.validator,
                style: inputTextStyling,
                // Removed focusNode from TextFormField
                decoration: InputDecoration(
                   hintText: _internalController.text.isEmpty && !_focusNode.hasFocus ? '' : null, // Hide default hint text when focused or has text
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
        // Show hint text only if the controller is truly empty and not focused
        if (_internalController.text.isEmpty && !_focusNode.hasFocus)
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
