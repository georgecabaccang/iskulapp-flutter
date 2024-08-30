import 'package:flutter/material.dart';
import 'package:school_erp/widgets/forgot_password.dart';
import 'package:school_erp/widgets/login_body.dart';
import 'package:school_erp/widgets/login_stack.dart'; // Import the custom container widget
import 'package:school_erp/pages/home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final PageController _pageController = PageController();
  bool _showForgotPassword =
      false; // State to toggle between login and forgot password

  void _toggleForgotPassword() {
    setState(() {
      _showForgotPassword = !_showForgotPassword;
      _pageController.animateToPage(
        _showForgotPassword ? 1 : 0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
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
          height: 180,
          fit: BoxFit.contain,
        ),
        containerContent: PageView(
          controller: _pageController,
          physics:
              const NeverScrollableScrollPhysics(), // Disable manual swiping
          children: [
            Padding(
              padding: const EdgeInsets.only(
                  top: 60.0), // Adjust the top padding as needed
              child: LoginBody(onForgotPassword: _toggleForgotPassword),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 60.0), // Adjust the top padding as needed
              child: ForgotPassword(onBackToLogin: _toggleForgotPassword),
            ),
          ],
        ),
      ),
    );
  }
}
