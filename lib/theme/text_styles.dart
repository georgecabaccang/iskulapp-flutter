import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';


TextStyle headingStyle() {
  return const TextStyle(
    fontWeight: FontWeight.bold,
    fontFamily: 'SourceSans',
    color: AppColors.whiteColor
  );
}



TextStyle bodyStyle() {
  return const TextStyle(
    fontFamily: 'SourceSans',
    color: Colors.black
  );
}


TextStyle buttonTextStyle() {
  return const TextStyle(
    fontWeight: FontWeight.w500,
    fontFamily: 'SourceSans',
    color: AppColors.whiteColor,
    fontSize: 16.0
  );
}