import 'package:flutter/material.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/assessment_setup_form.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/models/assessment.dart';

class AssessmentSetupPage extends StatelessWidget {
  final Assessment? assessment;
  final String title;

  const AssessmentSetupPage({required this.title, this.assessment, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: title,
      content: [
        AssessmentSetupForm(assessment: assessment),
      ],
    );
  }
}
