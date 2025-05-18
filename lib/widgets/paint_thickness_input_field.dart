import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Import for inputFormatters
import 'package:form_app/statics/app_styles.dart';

class PaintThicknessInputField extends StatefulWidget {
  final double width; // Parameter for the width of the text field
  final ValueChanged<String>? onChanged; // Callback for changes
  final String? initialValue; // Add initialValue parameter

  const PaintThicknessInputField({
    super.key,
    this.width = 50.0, // Default width
    this.onChanged,
    this.initialValue,
  });

  @override
  State<PaintThicknessInputField> createState() => _PaintThicknessInputFieldState();
}

class _PaintThicknessInputFieldState extends State<PaintThicknessInputField> {
  late TextEditingController _controller;
  late FocusNode _focusNode;
  late ScrollController _scrollController; // Add ScrollController

  @override
  void initState() {
    super.initState();
    // Initialize the controller with the initial value
    _controller = TextEditingController(text: widget.initialValue);
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);
    _scrollController = ScrollController(); // Initialize ScrollController
  }

  @override
  void didUpdateWidget(covariant PaintThicknessInputField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.initialValue != oldWidget.initialValue) {
      if (_controller.text != widget.initialValue) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            final currentSelection = _controller.selection;
            _controller.text = widget.initialValue ?? '';
            if (currentSelection.start <= _controller.text.length &&
                currentSelection.end <= _controller.text.length) {
              _controller.selection = currentSelection;
            } else {
              _controller.selection = TextSelection.fromPosition(
                  TextPosition(offset: _controller.text.length));
            }
          }
        });
      }
    }
  }

  void _handleFocusChange() {
    if (!_focusNode.hasFocus) {
      // When the text field loses focus, scroll to the beginning
      _scrollController.jumpTo(_scrollController.position.minScrollExtent);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    _scrollController.dispose(); // Dispose ScrollController
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Use minimum space in the row
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: widget.width,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode, // Assign the FocusNode
            scrollController: _scrollController, // Assign the ScrollController
            keyboardType: TextInputType.numberWithOptions(decimal: true), // Allow decimal input
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*')), // Allow digits and one decimal point
            ],
            onChanged: widget.onChanged, // Use the provided onChanged callback
            style: disabledToggleTextStyle.copyWith(color: labelTextColor), // Use a text style from app_styles
            decoration: InputDecoration(
              contentPadding: const EdgeInsets.only(top: 4.0, bottom: 4.0, left: 8.0, right: 8.0), // Adjust padding
              isDense: true,
              hintText: '0.00',
              hintStyle: hintTextStyling.copyWith(fontSize: 14.0),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(color: borderColor, width: 2), // Use border color from app_styles
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(color: borderColor, width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(6.0),
                borderSide: const BorderSide(color: borderColor, width: 2),
              ),
            ),
          ),
        ),
        const SizedBox(width: 4.0), // Spacing between text field and "mm"
        Text(
          'mm',
          style: inputTextStyling, // Adjust style as needed
        ),
      ],
    );
  }
}
