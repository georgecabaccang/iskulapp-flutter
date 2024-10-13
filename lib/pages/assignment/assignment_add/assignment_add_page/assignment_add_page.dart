import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'widgets/add_assignment_form.dart';
import 'package:school_erp/pages/EnterExitRoute.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/assignment/assignment_add/assignment_setup_page/question_setup_page.dart';
import 'package:school_erp/theme/colors.dart';

class AssignmentAddPage extends StatefulWidget {
  const AssignmentAddPage({super.key});

  @override
  _AssignmentAddPageState createState() => _AssignmentAddPageState();
}

class _AssignmentAddPageState extends State<AssignmentAddPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Assignment Add ',
          ),
          AppContent(
            content: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    const AddAssignmentForm(),
              SizedBox(
                height: MediaQuery.of(context).size.height *
                    0.12, 
                width: double.infinity,
                child: Image.asset(
                  'assets/images/AddAssignmentImage.png',
                  fit: BoxFit.cover,
                ),
              ),
                ],
              )
            
            ],
          ),
        ],
      ),
    );
  }
}
