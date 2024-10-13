import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/widgets/assignment_add_button.dart';
import 'widgets/assignment_card.dart';
import 'package:school_erp/pages/assignment/widgets/assignment_animation_manager.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/theme/colors.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  _AssignmentListPageState createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage>
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
                    child: child ?? Container(),
                  ),
                ),
              );
            },
            child: Column(
              children: [
                const SizedBox(height: 25),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: const [
                      AssignmentCard(
                        subject: 'Mathematics',
                        title: 'Algebra 1',
                        assignDate: 'Dec 19, 2024 9:00pm',
                        lastSubmissionDate: 'Dec 19, 2024 11:59pm',
                        status: 'TO BE COMPLETED',
                        statusColor: AppColors.primaryColor,
                      ),
                      AssignmentCard(
                        subject: 'Science',
                        title: 'Structure of Atoms',
                        assignDate: '10 Oct 20',
                        lastSubmissionDate: '30 Oct 20',
                        status: 'TO BE SUBMITTED',
                        statusColor: AppColors.primaryColor,
                      ),
                      AssignmentCard(
                        subject: 'English',
                        title: 'My Bestfriend Essay',
                        assignDate: '10 Sep 20',
                        lastSubmissionDate: '30 Sep 20',
                        status: 'TO BE SUBMITTED',
                        statusColor:AppColors.primaryColor,
                      ),
                    ],
                  ),
                ),
              ],
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