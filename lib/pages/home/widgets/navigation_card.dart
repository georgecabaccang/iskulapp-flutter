import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';

class NavigationCard extends StatelessWidget {
  const NavigationCard({super.key, required this.title, required this.icon, required this.callback});

  final String title;
  final IconData icon;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    double iconSize = screenWidth * 0.11;
    double textSize = screenWidth * 0.04;
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        height: 150.0, // Set the desired height here
        decoration: BoxDecoration(
          color: AppColors.navigationCard,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
               Icon(
                icon,
                size: iconSize,
                color: const Color(0xFF6184C7),
              ),
            const SizedBox(height: 24.0),
            Text(title, style: bodyStyle().copyWith(fontSize: textSize)),
          ],
        ),
      ),
    );
  }
}
