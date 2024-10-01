import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:school_erp/theme/colors.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black
            .withOpacity(0.5), // Optional: semi-transparent background
        child:  Center(
          child: SpinKitPumpingHeart(
            color: AppColors.dangerColor.withOpacity(0.5),
            size: 75.0,
            duration:const Duration(milliseconds: 1000),
          ),
        ),
      ),
    );
  }
}
