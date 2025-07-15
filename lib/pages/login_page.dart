import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles
import 'package:form_app/widgets/labeled_text_field.dart'; // Import LabeledTextField
import 'package:form_app/widgets/pin_input.dart'; // Import PinInputWidget

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  String _currentPin = ''; // To store the PIN from PinInputWidget

  void _verifyPin(String pin) {
    debugPrint('Email entered: ${_emailController.text}');
    debugPrint('PIN entered: $pin');
    // TODO: Implement PIN verification logic here
    // For now, just clear the PIN after a short delay for demonstration
    // The PinInputWidget handles its own clearing, so no need to clear here.
  }

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
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
              LabeledTextField(
                controller: _emailController,
                label: 'Email',
                hintText: 'Enter your email',
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 24),
              PinInput(
                pinLength: 6,
                onPinCompleted: (pin) {
                  setState(() {
                    _currentPin = pin;
                  });
                  _verifyPin(pin);
                },
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPin.length == 6) {
                      _verifyPin(_currentPin);
                    }
                  },
                  style: baseButtonStyle.copyWith(
                    backgroundColor: WidgetStateProperty.all(toggleOptionSelectedLengkapColor)),           
                  child: Text('Login', style: buttonTextStyle,),
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
