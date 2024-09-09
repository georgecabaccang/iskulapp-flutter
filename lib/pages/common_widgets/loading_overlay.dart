import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LoadingOverlay extends StatelessWidget {
  const LoadingOverlay({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: Colors.black
            .withOpacity(0.5), // Optional: semi-transparent background
        child: const Center(
          child: SpinKitPumpingHeart(
            color: Colors.redAccent,
            size: 75.0,
            duration: Duration(milliseconds: 1000),
          ),
        ),
      ),
    );
  }
}
