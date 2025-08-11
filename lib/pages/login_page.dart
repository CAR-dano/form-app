import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // Import flutter_riverpod
import 'package:form_app/providers/auth_provider.dart';
import 'package:form_app/statics/app_styles.dart'; // Import AppStyles
import 'package:form_app/widgets/app_version_display.dart';
import 'package:form_app/widgets/labeled_text_field.dart'; // Import LabeledTextField
import 'package:form_app/widgets/pin_input.dart'; // Import PinInputWidget
import 'package:form_app/pages/multi_step_form_screen.dart'; // Import MultiStepFormScreen
import 'package:form_app/providers/message_overlay_provider.dart'; // Import message_overlay_provider

class LoginPage extends ConsumerStatefulWidget { // Change to ConsumerStatefulWidget
  const LoginPage({super.key});

  @override
  ConsumerState<LoginPage> createState() => _LoginPageState(); // Change to ConsumerState
}

class _LoginPageState extends ConsumerState<LoginPage> { // Change to ConsumerState
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  String _currentPin = ''; // To store the PIN from PinInputWidget
  final ValueNotifier<bool> _formSubmitted = ValueNotifier<bool>(false);
  bool _isLoading = false; // To manage loading state

  Future<void> _verifyPin(String pin) async {
    setState(() {
      _isLoading = true;
    });
    try {
      final email = _emailController.text;
      final authService = ref.read(authServiceProvider);
      final authResponse = await authService.loginInspector(email, pin);
      debugPrint('Login successful for user: ${authResponse.user.name}');
      // Navigate to the next screen upon successful login
      if (mounted) {
        Navigator.of(context).pushReplacement(
          CupertinoPageRoute(builder: (context) => const MultiStepFormScreen()),
        );
      }
    } catch (e) {
      debugPrint('Login failed: $e');
      // Show error message to the user
      if (mounted) {
        ref.read(customMessageOverlayProvider).show( // Use ref.read to access the provider
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
        appBar: AppBar(
          shadowColor: Colors.transparent,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          actions: [const AppVersionDisplay(), const SizedBox(width: 16,)],
        ),
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
                        // _verifyPin(pin);
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
                                    ref.read(customMessageOverlayProvider).show( // Use ref.read to access the provider
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
                            ? const SizedBox(
                              height: 24,
                              width: 24,
                              child: CircularProgressIndicator(
                                // ignore: deprecated_member_use
                                year2023: false,
                                strokeWidth: 3,
                                valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                              ),
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
