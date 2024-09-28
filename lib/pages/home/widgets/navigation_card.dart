import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';


class NavigationCard extends StatelessWidget {
  const NavigationCard(this.title, this.icon, this.callback, {super.key});

  final String title;
  final IconData icon;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.whiteColor,
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: AppColors.primaryColor,
              child: Icon(
                icon,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: bodyStyle(context)
            ),
          ],
        ),
      ),
    );
  }
}
