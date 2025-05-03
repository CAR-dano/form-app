import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/statics/app_styles.dart';
import 'dart:math'; // Import math for min function

class ExpandableTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<List<String>>? onChangedList;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool formSubmitted;
  final List<String>? initialLines;

  const ExpandableTextField({
    super.key,
    required this.label,
    required this.hintText,
    this.controller,
    this.onChangedList,
    this.validator,
    this.focusNode,
    this.formSubmitted = false,
    this.initialLines,
  });

  @override
  State<ExpandableTextField> createState() => _ExpandableTextFieldState();
}

class _ExpandableTextFieldState extends State<ExpandableTextField> {
  final _formFieldKey = GlobalKey<FormFieldState>();
  late TextEditingController _internalController;
  late FocusNode _focusNode;
  List<String> _lines = [];

  @override
  void initState() {
    super.initState();

    // Initialize _lines directly from initialLines or empty list
    // DON'T add the bullet point here initially.
    _lines = List<String>.from(widget.initialLines ?? []);

    // Initialize controller with joined lines (might be empty)
    _internalController = widget.controller ?? TextEditingController(text: _lines.join('\n'));

    if (widget.controller != null) {
      widget.controller!.addListener(_handleExternalControllerChange);
    }

    _focusNode = widget.focusNode ?? FocusNode();
    // Add the listener *after* initializing _internalController
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant ExpandableTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
     // Handle external changes if necessary, ensuring not to overwrite user input without care
    if (widget.initialLines != oldWidget.initialLines && widget.controller == null) {
      //final newInitialText = (widget.initialLines ?? []).join('\n');
      // Only update if the initial text changed AND the current text matches the OLD initial text
      // OR if the current text is empty/just the placeholder bullet (safer update)
      final oldInitialText = (oldWidget.initialLines ?? []).join('\n');
      if (_internalController.text == oldInitialText || _internalController.text.isEmpty || _internalController.text == '• ') {
         _lines = List<String>.from(widget.initialLines ?? []);
         final currentSelection = _internalController.selection;
         _internalController.text = _lines.join('\n');
         // Try to restore selection
         try {
          _internalController.selection = currentSelection.copyWith(
            baseOffset: min(currentSelection.baseOffset, _internalController.text.length),
            extentOffset: min(currentSelection.extentOffset, _internalController.text.length),
          );
         } catch (e) {
            // Selection restoration might fail if text length changes drastically
            _internalController.selection = TextSelection.collapsed(offset: _internalController.text.length);
         }
      }
    }
  }

  @override
  void dispose() {
    // Important: Remove listener before disposing focus node
    _focusNode.removeListener(_handleFocusChange);
    if (widget.controller != null) {
      widget.controller!.removeListener(_handleExternalControllerChange);
    }
    // Dispose internal controller only if it was created internally
    if (widget.controller == null) {
      _internalController.dispose();
    }
    // Dispose focus node only if it was created internally
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _handleExternalControllerChange() {
    if (_internalController.text != widget.controller!.text) {
        _internalController.text = widget.controller!.text;
        _lines = _internalController.text.split('\n');
        // Usually, external controller changes shouldn't auto-trigger onChangedList
        // unless that's the desired behavior for your specific use case.
        // widget.onChangedList?.call(_lines);
    }
  }

  void _handleFocusChange() {
     if (!mounted) return; // Ensure widget is still in the tree

     // Use setState to ensure the UI rebuilds correctly for hint visibility
     setState(() {
        if (_focusNode.hasFocus && _internalController.text.isEmpty) {
          // === GAINED FOCUS and EMPTY: Add bullet point ===
          _lines = ['• '];
          _internalController.text = _lines.join('\n');
          // Position cursor *after* the bullet point and space
          _internalController.selection = TextSelection.fromPosition(
              TextPosition(offset: _internalController.text.length));
          // Notify parent that the content changed programmatically
          widget.onChangedList?.call(_lines);
        } else if (!_focusNode.hasFocus && _internalController.text == '• ') {
           // === LOST FOCUS and ONLY BULLET REMAINS: Clear it ===
           _lines = []; // Clear internal state list
           _internalController.clear(); // Clear the controller text
           // Notify parent about the clearance
           widget.onChangedList?.call(_lines);
        }
     });
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.enter) {
        final text = _internalController.text;
        final selection = _internalController.selection;
        if (selection.isValid) {
          final newText = text.replaceRange(selection.start, selection.end, '\n• ');
          setState(() { // Keep setState if key events directly impact build state
            _lines = newText.split('\n');
            _internalController.value = TextEditingValue(
              text: newText,
              selection: TextSelection.fromPosition(
                TextPosition(offset: selection.start + 3),
              ),
            );
            widget.onChangedList?.call(_lines);
            if (widget.controller != null) {
                widget.controller!.text = _internalController.text;
            }
          });
          return KeyEventResult.handled;
        }
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
          final text = _internalController.text;
          final selection = _internalController.selection;
          // Handle backspace at the beginning of a bulleted line (except the first '• ')
          if (selection.isCollapsed && selection.start > 2 && // Ensure we don't delete the very first bullet this way
              text.substring(selection.start - 3, selection.start) == '\n• ')
           {
             final newText = text.substring(0, selection.start - 3) + text.substring(selection.start);
             setState(() { // Keep setState
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
    return KeyEventResult.ignored;
  }

  @override
  Widget build(BuildContext context) {
    final formattedHintText = widget.hintText.split('\n').map((line) => '• $line').join('\n');

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: 8.0),
        Focus(
          focusNode: _focusNode,
          onKeyEvent: _handleKeyEvent,
          child: Stack(
            children: [
              TextFormField(
                key: _formFieldKey,
                controller: _internalController,
                keyboardType: TextInputType.multiline,
                maxLines: null,
                minLines: 3,
                onChanged: (value) {
                    _lines = value.split('\n');
                    widget.onChangedList?.call(_lines);
                    if (widget.controller != null && widget.controller!.text != value) {
                        widget.controller!.text = value;
                    }
                    if (widget.formSubmitted) {
                        _formFieldKey.currentState?.validate();
                    }
                    // No setState needed here usually, as text changes handled by controller
                },
                validator: widget.validator,
                style: inputTextStyling,
                decoration: InputDecoration(
                  // Hint text is now handled by the Positioned widget below
                  hintText: null, // Don't use TextFormField's hint
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
              // === Conditional Hint Text ===
              // Show if controller is empty AND the field does NOT have focus
              if (_internalController.text.isEmpty && !_focusNode.hasFocus)
                Positioned(
                  top: 12.0,
                  left: 16.0,
                  child: IgnorePointer(
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
