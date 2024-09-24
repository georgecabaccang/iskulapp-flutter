import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add_page/widgets/add_assignment_form.dart';
import 'package:school_erp/pages/assignment/widgets/assignment_animation_manager.dart';

class AssignmentAddPage extends StatefulWidget {
  const AssignmentAddPage({super.key});

  @override
  _AssignmentAddPageState createState() => _AssignmentAddPageState();
}

class _AssignmentAddPageState extends State<AssignmentAddPage>
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
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Navigates back to the previous screen
          },
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
                      height: MediaQuery.of(context).size.height *
                          0.12, // Adjust height as needed
                      width: double.infinity,
                      child: Image.asset(
                        'assets/images/AddAssignmentImage.png',
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
