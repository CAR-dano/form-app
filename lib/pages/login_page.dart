import 'package:flutter/material.dart';
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  String _pin = '';
  final int _pinLength = 6;

  void _onNumpadTap(String value) {
    setState(() {
      if (value == 'backspace') {
        if (_pin.isNotEmpty) {
          _pin = _pin.substring(0, _pin.length - 1);
        }
      } else if (value == 'clear') {
        _pin = '';
      } else if (_pin.length < _pinLength) {
        _pin += value;
      }
    });
    if (_pin.length == _pinLength) {
      _verifyPin();
    }
  }

  void _verifyPin() {
    // TODO: Implement PIN verification logic here
    debugPrint('PIN entered: $_pin');
    // For now, just clear the PIN after a short delay for demonstration
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        _pin = '';
      });
    });
  }

  Widget _buildPinCircle(int index) {
    bool isFilled = index < _pin.length;
    return Container(
      width: 20,
      height: 20,
      margin: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? borderColor : Colors.transparent,
        border: Border.all(
          color: borderColor,
          width: 2,
        ),
      ),
    );
  }

  Widget _buildNumpadButton(String text, {VoidCallback? onPressed, IconData? icon}) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: AspectRatio(
          aspectRatio: 1, // Make buttons square
          child: ElevatedButton(
            onPressed: onPressed ?? () => _onNumpadTap(text),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.transparent,
              elevation: 0,

            ),
            child: icon != null
                ? Icon(icon, color: darkTextColor, size: 16)
                : Text(
                    text,
                    style: buttonTextStyle.copyWith(fontSize: 16.0, color: darkTextColor), // Use buttonTextStyle
                  ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Set background to white
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start, // Align title to start
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Login',
              style: pageNumberStyle, // Apply titleStyle
            ),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    'Enter your 6-digit PIN',
                    style: labelStyle, // Apply labelStyle
                  ),
                  const SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(_pinLength, (index) => _buildPinCircle(index)),
                  ),
                  const SizedBox(height: 40),
                  // Numpad
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNumpadButton('1'),
                          _buildNumpadButton('2'),
                          _buildNumpadButton('3'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNumpadButton('4'),
                          _buildNumpadButton('5'),
                          _buildNumpadButton('6'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNumpadButton('7'),
                          _buildNumpadButton('8'),
                          _buildNumpadButton('9'),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildNumpadButton('clear', onPressed: () => _onNumpadTap('clear')),
                          _buildNumpadButton('0'),
                          _buildNumpadButton('backspace', icon: Icons.backspace),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

