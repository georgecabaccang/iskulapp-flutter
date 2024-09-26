import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'widgets/add_assignment_form.dart';

class AssignmentAddPage extends StatefulWidget {
  const AssignmentAddPage({super.key});

  @override
  _AssignmentAddPageState createState() => _AssignmentAddPageState();
}

class _AssignmentAddPageState extends State<AssignmentAddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Add Assignment",
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: const Color(0xFF5278C1),
        child: Column(
          children: [
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
}
