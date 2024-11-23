import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class ComingSoonWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Chat rooms are under construction!!!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
          const SizedBox(height: 16),
          Image.asset(
            'assets/images/under_construction.webp',
          ),
          const SizedBox(height: 16),
          const Text(
            "Thank you for your patience! \n Stay tuned for what's coming soon!",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }
}
