import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'assignment_animation.dart'; // Ensure this is the correct path for AssignmentAnimationManager
import 'widgets/check_assingment_appbar.dart';
import 'widgets/student_list.dart';
import 'widgets/close_button_widget.dart';

class CheckAssignmentPage extends StatefulWidget {
  const CheckAssignmentPage({super.key});

  @override
  _CheckAssignmentPageState createState() => _CheckAssignmentPageState();
}

class _CheckAssignmentPageState extends State<CheckAssignmentPage>
    with SingleTickerProviderStateMixin {
  late AssignmentAnimationManager animationManager;

  @override
  void initState() {
    super.initState();
    animationManager = AssignmentAnimationManager(vsync: this);
    _startAnimation();
  }

  void _startAnimation() {
    animationManager.startAnimation();
  }

  @override
  Widget build(BuildContext context) {
    // Use MediaQuery to get the screen height and set a relative app bar height
    final double screenHeight = MediaQuery.of(context).size.height;
    final double appBarHeight = screenHeight * 0.12; // 12% of screen height

    return Scaffold(
      body: Stack(
        children: [
          Container(
            color: AppColors.primaryColor, // Background remains the same
          ),
          Positioned(
            top: appBarHeight, // Start below the AppBar using relative height
            left: 0,
            right: 0,
            bottom: 0, // Extend to the bottom
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: StudentList(),
                  ),
                  const CloseButtonWidget(),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: CheckAssignmentAppBar(
              animationManager: animationManager,
              onBackPressed: () {
                animationManager.reverseAnimation();
                Navigator.pop(context); // Close the page
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    animationManager.dispose();
    super.dispose();
  }
}
