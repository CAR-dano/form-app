import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles

class PinInputWidget extends StatefulWidget {
  final int pinLength;
  final Function(String pin) onPinCompleted;

  const PinInputWidget({
    super.key,
    required this.pinLength,
    required this.onPinCompleted,
  });

  @override
  State<PinInputWidget> createState() => _PinInputWidgetState();
}

class _PinInputWidgetState extends State<PinInputWidget> {
  late List<TextEditingController> _pinControllers;
  late List<FocusNode> _pinFocusNodes;

  // Flag to prevent re-entrant calls when clearing text programmatically
  bool _isClearingProgrammatically = false;

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
                focusNode: FocusNode(), // Dummy focus node for the listener
                onKeyEvent: (event) {
                  if (event is KeyDownEvent &&
                      event.logicalKey == LogicalKeyboardKey.backspace) {
                    if (index > 0 && _pinControllers[index].text.isEmpty) {
                      _isClearingProgrammatically = true;
                      _pinFocusNodes[index - 1].requestFocus();
                      _pinControllers[index - 1].clear();
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        _isClearingProgrammatically = false;
                      });
                    }
                  }
                },
                child: TextFormField(
                  controller: _pinControllers[index],
                  focusNode: _pinFocusNodes[index],
                  keyboardType: TextInputType.number,
                  textAlign: TextAlign.center,
                  maxLength: 1,
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
                      borderRadius: BorderRadius.circular(16),
                      borderSide: BorderSide(
                          color: borderColor,
                          width: _pinFocusNodes[index].hasFocus ? 2.0 : 1.5),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: const BorderSide(
                          color: borderColor, width: 2.0),
                    ),
                  ),
                  onChanged: (value) {
                    if (_isClearingProgrammatically) return;
                    if (value.isNotEmpty) {
                      if (index < widget.pinLength - 1) {
                        _pinFocusNodes[index + 1].requestFocus();
                      }
                    } else {
                      if (index > 0) {
                        _pinFocusNodes[index - 1].requestFocus();
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
