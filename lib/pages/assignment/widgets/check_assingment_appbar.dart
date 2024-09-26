import 'package:flutter/material.dart';
import '../assignment_animation.dart';
import 'package:school_erp/theme/colors.dart';


class CheckAssignmentAppBar extends StatelessWidget {
  final AssignmentAnimationManager animationManager;
  final VoidCallback onBackPressed;

  const CheckAssignmentAppBar({
    super.key,
    required this.animationManager,
    required this.onBackPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0),
        child: AnimatedBuilder(
          animation: animationManager.controller,
          builder: (context, child) {
            return Opacity(
              opacity: animationManager.opacity,
              child: child,
            );
          },
          child: Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
                onPressed: onBackPressed,
              ),
              const Spacer(),
              const Text(
                'CHECK ASSIGNMENT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  // Handle the action for the plus button here
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: AppColors.successColor,
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(
                    Icons.add,
                    color:AppColors.whiteColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
