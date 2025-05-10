import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/statics/app_styles.dart'; // Your project's style definitions.
import 'dart:math'; // Used for the min function.
import 'package:form_app/formatters/bullet_list_input_formatter.dart'; // Custom formatter for bullet lists.

// A text field that expands and supports bulleted list formatting.
class ExpandableTextField extends StatefulWidget {
  final String label;
  final String hintText;
  final TextEditingController? controller;
  final ValueChanged<List<String>>? onChangedList;
  final FormFieldValidator<String>? validator;
  final FocusNode? focusNode;
  final bool formSubmitted;
  final List<String>? initialLines;

  // Constructor for the ExpandableTextField.
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

  // Creates the mutable state for this widget.
  @override
  State<ExpandableTextField> createState() => _ExpandableTextFieldState();
}

// Manages the state for ExpandableTextField.
class _ExpandableTextFieldState extends State<ExpandableTextField> {
  // Key to manage FormField state (e.g., validation).
  final _formFieldKey = GlobalKey<FormFieldState>();
  // Internal controller if an external one isn't provided.
  late TextEditingController _internalController;
  // Internal focus node if an external one isn't provided.
  late FocusNode _focusNode;
  // Internal list of text lines.
  List<String> _lines = [];

  // Initializes state when the widget is first created.
  @override
  void initState() {
    super.initState();
    _lines = List<String>.from(widget.initialLines ?? []);
    _internalController = widget.controller ?? TextEditingController(text: _lines.join('\n'));
    if (widget.controller != null) {
      widget.controller!.addListener(_handleExternalControllerChange);
    }
    _focusNode = widget.focusNode ?? FocusNode();
    _focusNode.addListener(_handleFocusChange);
  }

  // Called when the widget configuration changes.
  @override
  void didUpdateWidget(covariant ExpandableTextField oldWidget) {
    super.didUpdateWidget(oldWidget);
    // Updates listeners if the external controller changes.
    if (widget.controller != oldWidget.controller) {
      oldWidget.controller?.removeListener(_handleExternalControllerChange);
      widget.controller?.addListener(_handleExternalControllerChange);
      if (widget.controller != null && _internalController.text != widget.controller!.text) {
        _internalController.text = widget.controller!.text;
      }
    }
    // Updates internal text if initial lines change and no external controller is used.
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
    // Updates listeners if the external focus node changes.
    if (widget.focusNode != oldWidget.focusNode) {
      _focusNode.removeListener(_handleFocusChange);
      _focusNode = widget.focusNode ?? FocusNode();
      _focusNode.addListener(_handleFocusChange);
    }
  }

  // Cleans up resources when the widget is removed from the tree.
  @override
  void dispose() {
    _focusNode.removeListener(_handleFocusChange);
    widget.controller?.removeListener(_handleExternalControllerChange);
    if (widget.controller == null) _internalController.dispose();
    if (widget.focusNode == null) _focusNode.dispose();
    super.dispose();
  }

  // Handles changes from an external TextEditingController.
  void _handleExternalControllerChange() {
    if (_internalController.text != widget.controller!.text) {
      _internalController.text = widget.controller!.text;
    }
  }

  // Handles focus changes to add/remove initial bullet point.
  void _handleFocusChange() {
    if (!mounted) return;
    if (_focusNode.hasFocus && _internalController.text.isEmpty) {
      _internalController.text = '• ';
      _internalController.selection = TextSelection.collapsed(offset: _internalController.text.length);
    } else if (!_focusNode.hasFocus && _internalController.text == '• ') {
      _internalController.clear();
    }
    setState(() {}); // Rebuilds for hint visibility or other focus-related UI.
  }

  // Handles specific key events, like backspacing before bulleted content.
  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      final text = _internalController.text;
      final selection = _internalController.selection;

      // Handles backspace at the start of bulleted line content (e.g., "...\n• |Content").
      if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (selection.isCollapsed && selection.baseOffset > 0) {
          final offset = selection.baseOffset;
          if (offset >= 3 && text.substring(offset - 3, offset) == '\n• ') {
            _internalController.value = TextEditingValue(
              text: text.substring(0, offset - 3) + text.substring(offset),
              selection: TextSelection.collapsed(offset: offset - 3),
            );
            return KeyEventResult.handled; // Indicates the event was handled.
          }
        }
      }
    }
    return KeyEventResult.ignored; // Ignores other key events or unhandled ones.
  }

  // Builds the UI for the ExpandableTextField.
  @override
  Widget build(BuildContext context) {
    // Formats hint text to also show bullets for consistency.
    final formattedHintText = widget.hintText.split('\n').map((line) => '• $line').join('\n');

    // Arranges label and text field vertically.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.label, style: labelStyle),
        const SizedBox(height: 4.0),
        // Manages focus and key events for the text field.
        Focus(
          focusNode: _focusNode,
          onKeyEvent: _handleKeyEvent,
          // Stacks TextFormField and custom hint text.
          child: Stack(
            children: [
              // The actual text input field.
              TextFormField(
                key: _formFieldKey,
                controller: _internalController,
                keyboardType: TextInputType.multiline,
                textInputAction: TextInputAction.newline, // Suggests newline action for Enter key.
                maxLines: null, // Allows unlimited lines.
                minLines: 3, // Default minimum height.
                // Applies the custom bullet list formatter.
                inputFormatters: [
                  BulletListInputFormatter(),
                ],
                // Called when the text changes (after formatters run).
                onChanged: (currentValueFromFramework) {
                  // Updates internal lines list and notifies parent.
                  _lines = _internalController.text.split('\n');
                  widget.onChangedList?.call(_lines);
                  // Syncs with external controller if provided.
                  if (widget.controller != null && widget.controller!.text != _internalController.text) {
                    widget.controller!.text = _internalController.text;
                  }
                  // Triggers validation if form has been submitted.
                  if (widget.formSubmitted) {
                    _formFieldKey.currentState?.validate();
                  }
                },
                validator: widget.validator,
                style: inputTextStyling,
                // Defines the appearance (decoration) of the text field.
                decoration: InputDecoration(
                  hintText: null, // Custom hint is handled by the Positioned widget.
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
              // Displays custom bulleted hint text when field is empty and not focused.
              if (_internalController.text.isEmpty && !_focusNode.hasFocus)
                Positioned(
                  top: 12.0,
                  left: 16.0,
                  child: IgnorePointer( // Prevents interaction with the hint text overlay.
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