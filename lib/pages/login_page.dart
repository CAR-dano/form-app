import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final int _pinLength = 6;
  late List<TextEditingController> _pinControllers;
  late List<FocusNode> _pinFocusNodes;

  @override
  void initState() {
    super.initState();
    _pinControllers = List.generate(_pinLength, (index) => TextEditingController());
    _pinFocusNodes = List.generate(_pinLength, (index) => FocusNode());

    for (int i = 0; i < _pinLength; i++) {
      _pinControllers[i].addListener(() {
        if (_pinControllers[i].text.length == 1 && i < _pinLength - 1) {
          _pinFocusNodes[i + 1].requestFocus();
        } else if (_pinControllers[i].text.isEmpty && i > 0) {
          _pinFocusNodes[i - 1].requestFocus();
        }
        _checkPinCompletion();
      });
    }
  }

  void _checkPinCompletion() {
    String currentPin = _pinControllers.map((controller) => controller.text).join();
    if (currentPin.length == _pinLength) {
      _verifyPin(currentPin);
    }
  }

  void _verifyPin(String pin) {
    // TODO: Implement PIN verification logic here
    debugPrint('PIN entered: $pin');
    // For now, just clear the PIN after a short delay for demonstration
    Future.delayed(const Duration(milliseconds: 300), () {
      for (var controller in _pinControllers) {
        controller.clear();
      }
      _pinFocusNodes[0].requestFocus();
    });
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
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: pageNumberStyle,
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Masukkan PIN 6 digit Anda',
                    style: labelStyle,
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pinLength, (index) {
                      return Container(
                        width: 40,
                        height: 40,
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        decoration: BoxDecoration(
                          border: Border.all(color: borderColor, width: 2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Center(
                          child: TextFormField(
                            controller: _pinControllers[index],
                            focusNode: _pinFocusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            obscureText: true,
                            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              counterText: '',
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.zero,
                            ),
                            onChanged: (value) {
                              if (value.isNotEmpty && index < _pinLength - 1) {
                                _pinFocusNodes[index + 1].requestFocus();
                              } else if (value.isEmpty && index > 0) {
                                _pinFocusNodes[index - 1].requestFocus();
                              }
                              _checkPinCompletion();
                            },
                          ),
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
