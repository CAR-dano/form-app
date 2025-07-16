import 'package:flutter/material.dart';
import 'package:form_app/services/auth_service.dart'; // Import AuthService
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles
import 'package:form_app/widgets/custom_message_overlay.dart'; // Import CustomMessageOverlay
import 'package:form_app/widgets/labeled_text_field.dart'; // Import LabeledTextField
import 'package:form_app/widgets/pin_input.dart'; // Import PinInputWidget
import 'package:form_app/pages/multi_step_form_screen.dart'; // Import MultiStepFormScreen

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String _currentPin = ''; // To store the PIN from PinInputWidget
  final ValueNotifier<bool> _formSubmitted = ValueNotifier<bool>(false);
  final AuthService _authService = AuthService(); // Instance of AuthService
  bool _isLoading = false; // To manage loading state

  Future<void> _verifyPin(String pin) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final email = _emailController.text;
      final authResponse = await _authService.loginInspector(email, pin);
      debugPrint('Login successful for user: ${authResponse.user.name}');
      // Navigate to the next screen upon successful login
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const MultiStepFormScreen()),
        );
      }
    } catch (e) {
      debugPrint('Login failed: $e');
      // Show error message to the user
      if (mounted) {
        CustomMessageOverlay().show(
          context: context,
          message: e.toString().replaceFirst('Exception: ', ''),
          color: Colors.red,
          icon: Icons.error,
        );
      }
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _formSubmitted.dispose();
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
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 48.0),
          child: ValueListenableBuilder<bool>(
            valueListenable: _formSubmitted,
            builder: (context, isFormSubmitted, child) {
              return Form(
                key: _formKey,
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
                      hintText: 'yourname@gmail.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'mohon isi email';
                        } else if (!value.contains('@') || !value.contains('.')) {
                          return 'Format email tidak valid';
                        }
                        // Add more email validation logic if needed
                        return null;
                      },
                      formSubmitted: isFormSubmitted,
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
                        onPressed: _isLoading
                            ? null
                            : () {
                                _formSubmitted.value = true;
                                if (_formKey.currentState!.validate()) {
                                  if (_currentPin.length == 6) {
                                    _verifyPin(_currentPin);
                                  } else {
                                    CustomMessageOverlay().show(
                                      context: context,
                                      message: 'Mohon masukkan PIN lengkap',
                                      color: Colors.orange,
                                      icon: Icons.warning_rounded,
                                    );
                                  }
                                }
                              },
                        style: baseButtonStyle.copyWith(
                            backgroundColor: WidgetStateProperty.all(toggleOptionSelectedLengkapColor)),
                        child: _isLoading
                            ? const CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              )
                            : Text('Login', style: buttonTextStyle),
                      ),
                    ),
                    const SizedBox(height: 24),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
