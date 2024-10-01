import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class DefaultButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const DefaultButton({super.key, required this.onPressed, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppColors.whiteColor, AppColors.primaryColor],
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
        ),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
        ),
        child: Text(
          text,
          style: const TextStyle(
            color: Colors.white, // White text color
            fontSize: 16.0,
            fontWeight: FontWeight.bold, // Bold text
            letterSpacing: 2.0, // Increase letter spacing
          ),
        ),
      ),
    );
  }
}
