import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add_page/assignment_add_page.dart';
import 'package:school_erp/pages/assignment/assignment_check_page/assignment_check_page.dart';
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

class AssignmentCard extends StatelessWidget {
  final String subject;
  final String title;
  final String assignDate;
  final String lastSubmissionDate;
  final String status;
  final Color statusColor;

  const AssignmentCard({
    super.key,
    required this.subject,
    required this.title,
    required this.assignDate,
    required this.lastSubmissionDate,
    required this.status,
    required this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AssignmentCheckPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = 0.0;
              const end = 1.0;
              const curve = Curves.easeInOut;
              var fadeTween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var fadeAnimation = animation.drive(fadeTween);

              return Stack(
                children: [
                  Container(
                    color: Colors.transparent,
                  ),
                  FadeTransition(
                    opacity: fadeAnimation,
                    child: child,
                  ),
                ],
              );
            },
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
                    decoration: BoxDecoration(
                      color: Colors.blue.shade100,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Text(
                      subject,
                      style: const TextStyle(
                        color: Color(0xFF5278C1),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4.0),
                  Text(
                    'Assign Date: $assignDate',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                  Text(
                    'Last Submission Date: $lastSubmissionDate',
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 14.0,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  ElevatedButton(
                    onPressed: () {
                      // Handle status button action here
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: statusColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                    ),
                    child: Text(
                      status,
                      style: const TextStyle(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 8.0,
              right: 8.0,
              child: IconButton(
                icon: const Icon(Icons.edit, color: Colors.grey),
                onPressed: () {
                  // Handle edit button press
                  print('Edit button pressed');
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

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
