import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class ForgotPassword extends StatelessWidget {
  final VoidCallback onBackToLogin; // Callback to switch back to Login screen

  const ForgotPassword({super.key, required this.onBackToLogin});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20), // Space at the top
              const Text(
                'Hi Student',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const Text(
                'Forgot Password',
                style: TextStyle(
                    fontWeight: FontWeight.w300,
                    fontSize: 24,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const SizedBox(height: 40),
              const Text(
                'Mobile Number/Email',
                style: TextStyle(
                    fontWeight: FontWeight.w100,
                    fontSize: 14,
                    color: Colors.black),
                textAlign: TextAlign.start,
              ),
              const TextField(
                decoration: InputDecoration(
                  border: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: Directionality(
                  textDirection: TextDirection.rtl,
                  child: ElevatedButton.icon(
                    onPressed: () {}, // Handle send action
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: AppColors.whiteColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                    icon: const Icon(
                      Icons.arrow_back,
                    ),
                    label: const Text("Send"),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onTap: onBackToLogin, // Switch back to Login screen
                    child: const Text(
                      'Back to Login',
                      style: TextStyle(
                          fontWeight: FontWeight.w300,
                          fontSize: 14,
                          color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
