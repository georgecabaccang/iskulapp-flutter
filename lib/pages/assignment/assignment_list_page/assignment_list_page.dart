import 'package:flutter/material.dart';
import 'widgets/assignment_card.dart';
import 'widgets/assignment_appbar.dart';
import 'package:school_erp/pages/assignment/widgets/assignment_animation_manager.dart';

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
    Future.delayed(const Duration(milliseconds: 800), () {
      Navigator.pop(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(color: const Color(0xFF5278C1)),
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
                  child: Opacity(
                    opacity: animationManager
                        .opacity, // Apply fade effect to the content
                    child: child ?? Container(),
                  ),
                ),
              );
            },
            child: Column(
              children: [
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
                        statusColor: Color(0xFF5278C1),
                      ),
                      AssignmentCard(
                        subject: 'Science',
                        title: 'Structure of Atoms',
                        assignDate: '10 Oct 20',
                        lastSubmissionDate: '30 Oct 20',
                        status: 'TO BE SUBMITTED',
                        statusColor: Color(0xFF5278C1),
                      ),
                      AssignmentCard(
                        subject: 'English',
                        title: 'My Bestfriend Essay',
                        assignDate: '10 Sep 20',
                        lastSubmissionDate: '30 Sep 20',
                        status: 'TO BE SUBMITTED',
                        statusColor: Color(0xFF5278C1),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: AssignmentAppBar(
              animationManager: animationManager,
              onBackPressed: _handleBackPress,
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
