import 'package:flutter/material.dart';

class AnimationManager {
  late final AnimationController controller;
  late final Animation<double> positionAnimation;
  late final Animation<double> opacityAnimation;

  AnimationManager({required TickerProvider vsync}) {
    controller = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: vsync,
    );

    // Initialize animations in the constructor body
    positionAnimation = Tween<double>(begin: 380.0, end: 100.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );

    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  void startAnimation() {
    controller.forward();
  }

  void stopAnimation() {
    controller.reverse();
  }

  void dispose() {
    controller.dispose();
  }
}
