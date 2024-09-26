import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/bloc/auth_bloc_barrel.dart';
import 'package:school_erp/pages/login/widgets/forgot_password.dart';
import 'package:school_erp/pages/login/widgets/login_body.dart';
import 'package:school_erp/pages/login/widgets/login_stack.dart';
import 'package:school_erp/pages/common_widgets/loading_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/theme/colors.dart';
class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocBuilder<AuthBloc, AuthState>(
        builder: (context, state) {
          return Stack(
            children: [
              const LoginView(),
              if (state is AuthLoading) const LoadingOverlay(),
            ],
          );
        },
      ),
    );
  }
}

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  _LoginViewState createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final PageController _pageController = PageController();
  bool _showForgotPassword = false;

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
    return LoginStack(
      image: Image.asset(
        'assets/images/loginPageImage.png',
        width: 150,
        height: 180,
        fit: BoxFit.contain,
      ),
      containerContent: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: LoginBody(onForgotPassword: _toggleForgotPassword),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 60.0),
            child: ForgotPassword(onBackToLogin: _toggleForgotPassword),
          ),
        ],
      ),
    );
  }
}
