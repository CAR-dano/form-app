import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/statics/app_styles.dart'; // Assuming these exist
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

  String _previousText = '';
  TextSelection _previousSelection = const TextSelection.collapsed(offset: 0);

  @override
  void initState() {
    super.initState();
    _lines = List<String>.from(widget.initialLines ?? []);
    _internalController = widget.controller ?? TextEditingController(text: _lines.join('\n'));
    _updatePreviousState();
    if (widget.controller != null) {
      widget.controller!.addListener(_handleExternalControllerChange);
    }
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  @override
  void didUpdateWidget(covariant ExpandableTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleExternalControllerChange);
      widget.controller?.addListener(_handleExternalControllerChange);
      if (widget.controller != null && _internalController.text != widget.controller!.text) {
        _internalController.text = widget.controller!.text;
      }
    }
    if (widget.initialLines != oldWidget.initialLines && widget.controller == null) {
      final oldInitialTextJoined = (oldWidget.initialLines ?? []).join('\n');
      if (_internalController.text == oldInitialTextJoined ||
          _internalController.text.isEmpty ||
          _internalController.text == '• ') {
        _lines = List<String>.from(widget.initialLines ?? []);
        final newText = _lines.join('\n');
        if (_internalController.text != newText) {
          final currentSelection = _internalController.selection;
          _internalController.text = newText;
          try {
            _internalController.selection = currentSelection.copyWith(
              baseOffset: min(currentSelection.baseOffset, _internalController.text.length),
              extentOffset: min(currentSelection.extentOffset, _internalController.text.length),
            );
          } catch (e) {
            _internalController.selection = TextSelection.collapsed(offset: _internalController.text.length);
          }
        }
      }
    }
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }
  }

  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    widget.controller?.removeListener(_handleExternalControllerChange);
    if (widget.controller == null) _internalController.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  void _updatePreviousState() {
    if (!mounted) return;
    _previousText = _internalController.text;
    _previousSelection = _internalController.selection;
  }

  void _handleExternalControllerChange() {
    if (_internalController.text != widget.controller!.text) {
      _internalController.text = widget.controller!.text;
    }
  }

  void _handleFocusChange() {
    if (!mounted) return;
    if (_focusNode.hasFocus && _internalController.text.isEmpty) {
      _internalController.text = '• ';
      _internalController.selection = TextSelection.collapsed(offset: _internalController.text.length);
    } else if (!_focusNode.hasFocus && _internalController.text == '• ') {
      _internalController.clear();
    }
    setState(() {});
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      final text = _internalController.text;
      final selection = _internalController.selection;

      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (selection.isValid) {
          final newText = text.replaceRange(selection.start, selection.end, '\n• ');
          _internalController.value = TextEditingValue(
            text: newText,
            selection: TextSelection.fromPosition(TextPosition(offset: selection.start + 3)),
          );
          return KeyEventResult.handled;
        }
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (selection.isCollapsed && selection.baseOffset > 0) {
          final offset = selection.baseOffset;

          // Case 1: Cursor is *immediately after* "• " from an empty bullet line.
          // Handles "...\n• |" -> "..."
          // Handles "• |" (at start) -> ""
          if (offset >= 2 && text.substring(offset - 2, offset) == '• ') {
            if (offset >= 3 && text[offset - 3] == '\n') { // Ends in "\n• "
              _internalController.value = TextEditingValue(
                text: text.substring(0, offset - 3), // Remove \n•
                selection: TextSelection.collapsed(offset: offset - 3),
              );
              return KeyEventResult.handled;
            } else if (offset == 2) { // Is "• " at the very start of the field
              _internalController.value = TextEditingValue(
                text: "", // Remove •
                selection: TextSelection.collapsed(offset: 0),
              );
              return KeyEventResult.handled;
            }
            // If "XYZ• ", this case is not met, falls through.
          }
          // Case 2: Cursor is at the start of a bulleted line's *content* (e.g., "...\n• |CONTENT")
          // This will remove the "\n• " prefix.
          else if (offset >= 3 && text.substring(offset - 3, offset) == '\n• ') {
            _internalController.value = TextEditingValue(
              text: text.substring(0, offset - 3) + text.substring(offset),
              selection: TextSelection.collapsed(offset: offset - 3),
            );
            return KeyEventResult.handled;
          }
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
        const SizedBox(height: 4.0),
        Focus(
          focusNode: _focusNode,
          onKeyEvent: _handleKeyEvent,
          child: Stack(
            children: [
              TextFormField(
                key: _formFieldKey,
                controller: _internalController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline,
                maxLines: null,
                minLines: 3,
                onChanged: (currentValueFromFramework) {
                  String currentText = _internalController.text; // Text after potential HW key event or IME action
                  TextSelection currentSelection = _internalController.selection;

                  String newText = currentText; // Start with current text
                  TextSelection newSelection = currentSelection; // Start with current selection

                  bool textModifiedByOnChangeLogic = false;

                  // --- Enter key press (newline insertion) detection for soft keyboards ---
                  if (currentText.length == _previousText.length + 1 &&
                      _previousSelection.isValid &&
                      currentSelection.isValid && currentSelection.isCollapsed &&
                      currentSelection.baseOffset > 0 &&
                      currentText[currentSelection.baseOffset - 1] == '\n' &&
                      _previousSelection.baseOffset <= _previousText.length &&
                      currentText.substring(0, currentSelection.baseOffset - 1) == _previousText.substring(0, _previousSelection.baseOffset) &&
                      currentText.substring(currentSelection.baseOffset) == _previousText.substring(_previousSelection.baseOffset)) {
                    final beforeNewline = currentText.substring(0, currentSelection.baseOffset);
                    final afterNewlineContent = currentText.substring(currentSelection.baseOffset);
                    newText = '$beforeNewline• $afterNewlineContent';
                    newSelection = TextSelection.collapsed(offset: currentSelection.baseOffset + 2);
                    textModifiedByOnChangeLogic = true;
                  }
                  // --- Soft keyboard backspace correction for empty bullet lines ---
                  // This handles when an IME (like Gboard) deletes the space from "• ", leaving "•".
                  else if (
                      currentText.length == _previousText.length - 1 && // Exactly one char (space) deleted
                      _previousSelection.isCollapsed &&
                      _previousSelection.baseOffset == _previousText.length && // Cursor was at the end of old text
                      _previousText.endsWith('• ') && // Old text ended with "• "
                      ( // And it was a proper empty bullet line
                        _previousText == '• ' || // was "• " at start
                        _previousText.endsWith('\n• ') // was "...\n• "
                      )
                    ) {
                      // At this point, currentText is _previousText minus the trailing space.
                      // So, currentText ends with "•".
                      if (currentText.endsWith('\n•')) { // Previous was "...\n• ", current is "...\n•"
                          newText = currentText.substring(0, currentText.length - 2); // Remove "\n•" -> "..."
                          newSelection = TextSelection.collapsed(offset: newText.length);
                          textModifiedByOnChangeLogic = true;
                      } else if (currentText == '•') { // Previous was "• ", current is "•"
                          newText = ""; // Remove "•" -> ""
                          newSelection = const TextSelection.collapsed(offset: 0);
                          textModifiedByOnChangeLogic = true;
                      }
                  }

                  // If our onChanged logic modified text/selection, update the controller
                  if (textModifiedByOnChangeLogic) {
                    if (newText != _internalController.text || newSelection != _internalController.selection) {
                      _internalController.value = TextEditingValue(
                        text: newText,
                        selection: newSelection,
                      );
                    }
                  }

                  // Common updates (always use the potentially modified text from _internalController)
                  _lines = _internalController.text.split('\n');
                  widget.onChangedList?.call(_lines);

                  if (widget.controller != null && widget.controller!.text != _internalController.text) {
                    widget.controller!.text = _internalController.text;
                  }

                  if (widget.formSubmitted) {
                    _formFieldKey.currentState?.validate();
                  }
                  _updatePreviousState(); // CRITICAL: Update for the *next* event
                },
                validator: widget.validator,
                style: inputTextStyling,
                decoration: InputDecoration(
                  hintText: null,
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