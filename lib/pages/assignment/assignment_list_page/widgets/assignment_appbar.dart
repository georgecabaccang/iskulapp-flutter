import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add_page/assignment_add_page.dart';
import 'package:school_erp/pages/assignment/widgets/assignment_animation_manager.dart';

class AssignmentAppBar extends StatelessWidget {
  final AssignmentAnimationManager animationManager;
  final VoidCallback onBackPressed;

  const AssignmentAppBar({
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
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBackPressed,
              ),
              const Spacer(),
              const Text(
                'ASSIGNMENT',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          const AssignmentAddPage(), // Replace with your target page
                      transitionsBuilder:
                          (context, animation, secondaryAnimation, child) {
                        const begin = 0.0;
                        const end = 1.0;
                        const curve = Curves.easeInOut;
                        var fadeTween = Tween(begin: begin, end: end)
                            .chain(CurveTween(curve: curve));
                        var fadeAnimation = animation.drive(fadeTween);

                        return FadeTransition(
                          opacity: fadeAnimation,
                          child: child,
                        );
                      },
                    ),
                  );
                },
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 255, 8),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: const Icon(
                    Icons.add,
                    color: Color.fromARGB(
                        255, 255, 255, 255), // Match the app's primary color
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
