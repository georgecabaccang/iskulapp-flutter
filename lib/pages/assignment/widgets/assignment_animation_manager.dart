
import 'package:flutter/material.dart';

class AssignmentAnimationManager {
  final AnimationController controller;
  late final Animation<double> slideAnimation;
  late final Animation<double> fadeAnimation;

  AssignmentAnimationManager({required TickerProvider vsync})
      : controller = AnimationController(
          duration: const Duration(milliseconds: 1000),
          vsync: vsync,
        ) {
    slideAnimation = Tween<double>(begin: 380, end: 100).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
    fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeInOut),
    );
  }

  void startAnimation() {
    Future.delayed(const Duration(milliseconds: 100), () {
      controller.forward();
    });
  }

  void reverseAnimation() {
    controller.reverse();
  }

  double get topPosition => slideAnimation.value;
  double get opacity => fadeAnimation.value;

  void dispose() {
    controller.dispose();
  }
}
