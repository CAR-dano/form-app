import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles

class PinInput extends StatefulWidget {
  final int pinLength;
  final Function(String pin) onPinCompleted;

  const PinInput({
    super.key,
    required this.pinLength,
    required this.onPinCompleted,
  });

  @override
  State<PinInput> createState() => _PinInputState();
}

class _PinInputState extends State<PinInput> {
  late List<TextEditingController> _pinControllers;
  late List<FocusNode> _pinFocusNodes;

  @override
  void initState() {
    super.initState();
    _pinControllers =
        List.generate(widget.pinLength, (index) => TextEditingController());
    _pinFocusNodes = List.generate(widget.pinLength, (index) => FocusNode());

    for (int i = 0; i < widget.pinLength; i++) {
      _pinControllers[i].addListener(() => setState(() {}));
      _pinFocusNodes[i].addListener(() => setState(() {}));
    }
  }

  void _checkPinCompletion() {
    String currentPin =
        _pinControllers.map((controller) => controller.text).join();
    if (currentPin.length == widget.pinLength) {
      widget.onPinCompleted(currentPin);
    }
  }

  @override
  void dispose() {
    for (var controller in _pinControllers) {
      controller.dispose();
    }
    for (var focusNode in _pinFocusNodes) {
      focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'PIN',
          style: labelStyle,
        ),
        const SizedBox(height: 4.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(widget.pinLength, (index) {
            bool isFilled = _pinControllers[index].text.isNotEmpty;
            return SizedBox(
              width: 48,
              child: KeyboardListener(
                focusNode: FocusNode(), // Necessary for the listener to capture events
                onKeyEvent: (event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace) {
                    // This event fires when backspace is pressed.
                    // We check if the current field is empty to trigger backward movement.
                    if (_pinControllers[index].text.isEmpty && index > 0) {
                      _pinFocusNodes[index - 1].requestFocus();
                      _pinControllers[index - 1].clear();
                    }
                  }
                },
                child: TextFormField(
                  controller: _pinControllers[index],
                  focusNode: _pinFocusNodes[index],
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly], // Ensure only numbers can be entered
                  textAlign: TextAlign.center,
                  // maxLength: 1, // Remove maxLength to handle logic in onChanged
                  obscureText: false,
                  style: inputTextStyling.copyWith(
                    fontWeight: FontWeight.bold,
                    color: isFilled ? Colors.white : Colors.black,
                  ),
                  decoration: InputDecoration(
                    filled: isFilled,
                    fillColor: borderColor,
                    counterText: '',
                    contentPadding: const EdgeInsets.symmetric(vertical: 12.0),
                    isDense: true,
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(24),
                      borderSide: BorderSide(
                          color: borderColor,
                          width: _pinFocusNodes[index].hasFocus ? 2.0 : 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide:
                          const BorderSide(color: borderColor, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    if (value.length > 1) {
                      // If a new digit is entered in a full field,
                      // take the new digit and move to the next field.
                      String newDigit = value.substring(value.length - 1);
                      _pinControllers[index].text = newDigit;
                      if (index < widget.pinLength - 1) {
                        _pinFocusNodes[index + 1].requestFocus();
                      }
                    } else if (value.isNotEmpty) {
                      // This handles the standard case of typing into an empty field.
                      if (index < widget.pinLength - 1) {
                        _pinFocusNodes[index + 1].requestFocus();
                      }
                    }
                    _checkPinCompletion();
                  },
                ),
              ),
            );
          }),
        ),
      ],
    );
  }
}
