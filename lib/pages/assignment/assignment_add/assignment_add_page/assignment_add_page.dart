import 'package:flutter/material.dart';
import 'widgets/add_assignment_form.dart';
import 'package:school_erp/pages/assignment/assignment_add/assignment_setup_page/question_setup_page.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class AssignmentAddPage extends StatefulWidget {
  const AssignmentAddPage({super.key});

  @override
  _AssignmentAddPageState createState() => _AssignmentAddPageState();
}

class _AssignmentAddPageState extends State<AssignmentAddPage> {

  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        title: "Add Assignment", content: [AddAssignmentForm()]);
  }
}
