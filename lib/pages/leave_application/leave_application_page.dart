import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/assignment/widgets/assignment_animation_manager.dart';
import 'package:school_erp/pages/leave_application/widgets/leave_application_card.dart';

class LeaveApplicationPage extends StatefulWidget {
  const LeaveApplicationPage({super.key});

  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage>
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

  void _handleBackPress() {
    animationManager.reverseAnimation();
    Future.delayed(animationManager.duration, () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Leave Application",
        fadeAnimation: animationManager.fadeAnimation,
        onBackPressed: _handleBackPress,
      ),
      body: Stack(
        children: [
          Container(color: AppColors.primaryColor),
          AnimatedBuilder(
            animation: animationManager.controller,
            builder: (context, child) {
              return Positioned(
                top: animationManager.topPosition,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: animationManager.fadeAnimation,
                    child: const LeaveApplicationCard(),
                  ),
                ),
              );
            },
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
