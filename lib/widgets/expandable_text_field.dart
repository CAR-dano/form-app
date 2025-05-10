import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/statics/app_styles.dart'; // Re-enabled your original styles import
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

  // Store previous text and selection to analyze changes in onChanged
  String _previousText = '';
  TextSelection _previousSelection = const TextSelection.collapsed(offset: 0);

  @override
  void initState() {
    super.initState();

    _lines = List<String>.from(widget.initialLines ?? []);
    _internalController = widget.controller ?? TextEditingController(text: _lines.join('\n'));

    // Initialize previous state
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
      if (oldWidget.controller != null) {
        oldWidget.controller!.removeListener(_handleExternalControllerChange);
      }
      if (widget.controller != null) {
        widget.controller!.addListener(_handleExternalControllerChange);
        if (_internalController.text != widget.controller!.text) {
          _internalController.text = widget.controller!.text; // Triggers onChanged
        }
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
          _internalController.text = newText; // This will trigger onChanged
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
    if (widget.controller != null) {
      widget.controller!.removeListener(_handleExternalControllerChange);
    }
    if (widget.controller == null) {
      _internalController.dispose();
    }
    if (widget.focusNode == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  void _updatePreviousState() {
    if (!mounted) return;
    _previousText = _internalController.text;
    _previousSelection = _internalController.selection;
  }

  void _handleExternalControllerChange() {
    if (_internalController.text != widget.controller!.text) {
      _internalController.text = widget.controller!.text; // This triggers onChanged
    }
  }

  void _handleFocusChange() {
    if (!mounted) return;

    if (_focusNode.hasFocus && _internalController.text.isEmpty) {
      _internalController.text = '• ';
      _internalController.selection = TextSelection.collapsed(offset: _internalController.text.length);
      // onChanged will be triggered by text change.
    } else if (!_focusNode.hasFocus && _internalController.text == '• ') {
      _internalController.clear();
      // onChanged will be triggered by text change.
    }
    setState(() {}); // To update hint visibility
  }

  KeyEventResult _handleKeyEvent(FocusNode node, KeyEvent event) {
    if (event is KeyDownEvent) {
      final currentText = _internalController.text;
      final currentSelection = _internalController.selection;

      if (event.logicalKey == LogicalKeyboardKey.enter) {
        if (currentSelection.isValid) {
          final newText = currentText.replaceRange(currentSelection.start, currentSelection.end, '\n• ');
          _internalController.value = TextEditingValue(
            text: newText,
            selection: TextSelection.fromPosition(
              TextPosition(offset: currentSelection.start + 3),
            ),
          );
          return KeyEventResult.handled;
        }
      } else if (event.logicalKey == LogicalKeyboardKey.backspace) {
        if (currentSelection.isCollapsed &&
            currentSelection.start > 2 &&
            currentText.length >= currentSelection.start &&
            currentText.substring(currentSelection.start - 3, currentSelection.start) == '\n• ') {
          final newText = currentText.substring(0, currentSelection.start - 3) +
                          currentText.substring(currentSelection.start);
          _internalController.value = TextEditingValue(
            text: newText,
            selection: TextSelection.fromPosition(
              TextPosition(offset: currentSelection.start - 3),
            ),
          );
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
                  String newText = currentValueFromFramework;
                  TextSelection newSelection = _internalController.selection;

                  if (newText.length == _previousText.length + 1 &&
                      _previousSelection.isValid &&
                      newSelection.isValid && newSelection.isCollapsed &&
                      newSelection.baseOffset > 0 &&
                      newText[newSelection.baseOffset - 1] == '\n' &&
                      _previousSelection.baseOffset <= _previousText.length &&
                      newText.substring(0, newSelection.baseOffset - 1) == _previousText.substring(0, _previousSelection.baseOffset) &&
                      newText.substring(newSelection.baseOffset) == _previousText.substring(_previousSelection.baseOffset)
                    ) {
                    final beforeNewline = newText.substring(0, newSelection.baseOffset);
                    final afterNewlineContent = newText.substring(newSelection.baseOffset);
                    newText = '$beforeNewline• $afterNewlineContent';
                    newSelection = TextSelection.collapsed(offset: newSelection.baseOffset + 2);
                  }
                  else if (newText.length == _previousText.length - 1 &&
                           _previousSelection.isValid && _previousSelection.isCollapsed &&
                           newSelection.isValid && newSelection.isCollapsed &&
                           _previousText.length > newSelection.baseOffset &&
                           _previousText[newSelection.baseOffset] == '\n' &&
                           newText.length >= newSelection.baseOffset + 2 &&
                           newText.substring(newSelection.baseOffset, newSelection.baseOffset + 2) == '• ' &&
                           _previousText.substring(0, newSelection.baseOffset) == newText.substring(0, newSelection.baseOffset) &&
                           _previousText.substring(newSelection.baseOffset + 1).startsWith(newText.substring(newSelection.baseOffset))
                          ) {
                      newText = newText.substring(0, newSelection.baseOffset) +
                                newText.substring(newSelection.baseOffset + 2);
                      newSelection = TextSelection.collapsed(offset: newSelection.baseOffset);
                  }

                  if (newText != _internalController.text || newSelection != _internalController.selection) {
                      _internalController.value = TextEditingValue(
                          text: newText,
                          selection: newSelection,
                      );
                  }

                  _lines = _internalController.text.split('\n');
                  widget.onChangedList?.call(_lines);

                  if (widget.controller != null && widget.controller!.text != _internalController.text) {
                    widget.controller!.text = _internalController.text;
                  }

                  if (widget.formSubmitted) {
                    _formFieldKey.currentState?.validate();
                  }
                  _updatePreviousState();
                },
                validator: widget.validator,
                style: inputTextStyling, // Uses inputTextStyling from app_styles.dart
                decoration: InputDecoration(
                  hintText: null,
                  hintStyle: hintTextStyling, // Uses hintTextStyling from app_styles.dart
                  contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                  isDense: true,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: toggleOptionSelectedLengkapColor, width: 1.5), // Uses color from app_styles.dart
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: toggleOptionSelectedLengkapColor, width: 1.5), // Uses color from app_styles.dart
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: toggleOptionSelectedLengkapColor, width: 2.0), // Uses color from app_styles.dart
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: errorBorderColor, width: 1.5), // Uses color from app_styles.dart
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: const BorderSide(color: errorBorderColor, width: 2.0), // Uses color from app_styles.dart
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
                      style: hintTextStyling, // Uses hintTextStyling from app_styles.dart
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