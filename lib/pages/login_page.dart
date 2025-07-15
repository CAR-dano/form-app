import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles
import 'package:form_app/widgets/labeled_text_field.dart'; // Import LabeledTextField

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final int _pinLength = 6;
  late List<TextEditingController> _pinControllers;
  late List<FocusNode> _pinFocusNodes;
  final TextEditingController _emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _pinControllers =
        List.generate(_pinLength, (index) => TextEditingController());
    _pinFocusNodes = List.generate(_pinLength, (index) => FocusNode());

    for (int i = 0; i < _pinLength; i++) {
      _pinControllers[i].addListener(() {
        if (_pinControllers[i].text.length == 1 && i < _pinLength - 1) {
          _pinFocusNodes[i + 1].requestFocus();
        } else if (_pinControllers[i].text.isEmpty && i > 0) {
          _pinFocusNodes[i - 1].requestFocus();
        }
        _checkPinCompletion();
        setState(() {}); // Rebuild to update PIN field style
      });
      _pinFocusNodes[i].addListener(() {
        setState(() {}); // Rebuild to update border width on focus change
      });
    }
  }

  void _checkPinCompletion() {
    String currentPin =
        _pinControllers.map((controller) => controller.text).join();
    if (currentPin.length == _pinLength) {
      _verifyPin(currentPin);
    }
  }

  void _verifyPin(String pin) {
    // TODO: Implement PIN verification logic here
    debugPrint('Email entered: ${_emailController.text}');
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
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: pageTitleStyle,
            ),
            const SizedBox(height: 40),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  LabeledTextField(
                    controller: _emailController,
                    label: 'Email',
                    hintText: 'Enter your email',
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 24),
                  Text(
                    'Masukkan PIN 6 digit Anda',
                    style: labelStyle,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pinLength, (index) {
                      bool isFilled = _pinControllers[index].text.isNotEmpty;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4.0), // Add horizontal padding
                        child: SizedBox(
                          width: 48,
                          child: TextFormField(
                            controller: _pinControllers[index],
                            focusNode: _pinFocusNodes[index],
                            keyboardType: TextInputType.number,
                            textAlign: TextAlign.center,
                            maxLength: 1,
                            obscureText: false, // Show the number
                            style: inputTextStyling.copyWith(
                              fontWeight: FontWeight.bold,
                              color: isFilled ? Colors.white : Colors.black,
                            ),
                            decoration: InputDecoration(
                              filled: isFilled,
                              fillColor: borderColor,
                              counterText: '',
                              contentPadding: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
                              isDense: true,
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: BorderSide(
                                    color: borderColor,
                                    width: _pinFocusNodes[index].hasFocus
                                        ? 2.0
                                        : 1.5),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(8),
                                borderSide: const BorderSide(
                                    color: borderColor, width: 2.0),
                              ),
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
                ],
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  String pin =
                      _pinControllers.map((controller) => controller.text).join();
                  if (pin.length == _pinLength) {
                    _verifyPin(pin);
                  }
                },
                style: baseButtonStyle.copyWith(
                    backgroundColor: WidgetStateProperty.all(buttonColor),
                    shadowColor: WidgetStateProperty.all(buttonColor.withAlpha(102)),
                ),           
                child: Text('Login', style: buttonTextStyle,),
              ),
            ),
            const SizedBox(
                height: 24), // Add some space at the bottom of the screen
          ],
        ),
      ),
    );
  }
}
