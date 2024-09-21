import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_animation.dart';
import 'package:school_erp/pages/teacher/widget/add_assignment_form.dart';

class AnimationState {
  final bool animate;
  final bool isBackNavigation;

  AnimationState({
    this.animate = false,
    this.isBackNavigation = false,
  });
}

class AddAssignmentPage extends StatefulWidget {
  const AddAssignmentPage({super.key});

  @override
  _AddAssignmentPageState createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage>
    with SingleTickerProviderStateMixin {
  late AssignmentAnimationManager animationManager;
  bool _animate = false;
  bool _isTransitioning = false;

  @override
  void initState() {
    super.initState();
    animationManager = AssignmentAnimationManager(vsync: this);
    _startAnimation();
  }

  void _handleBackPress() {
    animationManager.reverseAnimation();
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.pop(context);
    });
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 200), () {
      setState(() {
        _animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: _handleBackPress,
        ),
        title: const Text(
          'Add Assignment',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xFF5278C1),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF5278C1), // Set body background color
        child: Column(
          children: [
            const SizedBox(height: 25),
            Expanded(
              // This ensures the Container occupies all available space
              child: Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.0),
                    topRight: Radius.circular(30.0),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const AddAssignmentForm(),
                    SizedBox(
                      height: 150,
                      width: double.infinity, 
                      child: Image.asset(
                        'assets/images/AddAssignmentImage.png', // Replace with your image path
                        fit: BoxFit.cover,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    animationManager.dispose();
    super.dispose();
  }
}
