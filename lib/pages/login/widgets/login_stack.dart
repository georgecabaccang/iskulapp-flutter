import 'package:flutter/material.dart';
import 'package:school_erp/pages/login/widgets/rounded_container.dart'; // Import the custom container widget

class LoginStack extends StatelessWidget {
  final Widget image;
  final Widget containerContent;

  const LoginStack({
    super.key,
    required this.image,
    required this.containerContent,
  });

  @override
  Widget build(BuildContext context) {
    // Get the height of the device
    final double screenHeight = MediaQuery.of(context).size.height;

    return Stack(
      children: [
        Positioned(
          top: screenHeight * 0.28, // Positioned 28% from the top of the screen
          left: 0,
          right: 0,
          bottom: 0,
          child: RoundedContainer(
            height: double.infinity, // Container takes the remaining space
            borderRadius: 30.0,
            child: containerContent,
          ),
        ),
        Positioned(
          top: screenHeight * 0.1,
          left: 0,
          right: 0,
          child: Center(
            child: SizedBox(
              width: double.infinity,
              child: image,
            ),
          ),
        ),
      ],
    );
  }
}
