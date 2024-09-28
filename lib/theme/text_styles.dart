import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
// Subject to change

// Function to get dynamic font size based on screen width
double getDynamicFontSize(BuildContext context, double factor) {
  double screenWidth = MediaQuery.of(context).size.width;
  return screenWidth * factor; // Adjust the factor to your preference
}

// Example text styles with dynamic font size
TextStyle headingStyle(BuildContext context) {
  return TextStyle(
    fontSize: getDynamicFontSize(context, 0.06), // 6% of screen width
    fontWeight: FontWeight.bold,
    fontFamily: 'SourceSans',
  );
}

TextStyle headingStyleSecondary(BuildContext context) {
  return TextStyle(
    fontSize: getDynamicFontSize(context, 0.07), // 8% of screen width
    fontWeight: FontWeight.bold,
    fontFamily: 'SourceSans',
    color: AppColors.whiteColor,
  );
}

TextStyle bodyStyle(BuildContext context) {
  return TextStyle(
    fontSize: getDynamicFontSize(context, 0.04), // 4% of screen width
    fontFamily: 'SourceSans',
    color: Colors.black
  );
}
TextStyle bodyStyleSecondary(BuildContext context) {
  return TextStyle(
    fontSize: getDynamicFontSize(context, 0.04), // 4% of screen width
    fontFamily: 'SourceSans',
    color: AppColors.whiteColor
  );
}

TextStyle buttonTextStyle(BuildContext context) {
  return TextStyle(
    fontSize: getDynamicFontSize(context, 0.045), // 4.5% of screen width
    fontWeight: FontWeight.w500,
    fontFamily: 'SourceSans',
    color: Colors.white,
  );
}