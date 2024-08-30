import 'package:flutter/material.dart';
import 'package:school_erp/pages/login/widgets/forgot_password.dart';
import 'package:school_erp/pages/login/widgets/login_stack.dart'; // Import the custom container widget

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _obscureText = true; // State variable to manage password visibility

  void _togglePasswordVisibility() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF5278C1),
      body: LoginStack(
        image: Image.asset(
          'assets/images/loginPageImage.png',
          width: 150,
          height: 150,
          fit: BoxFit.contain,
        ),
        containerContent: SingleChildScrollView(
          child: ForgotPassword()
        ),
      ),
    );
  }
}
