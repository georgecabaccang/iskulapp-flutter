import 'package:flutter/material.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_takers/assessment_takers_form.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class AssessmentTakersPage extends StatelessWidget {
  final Assessment? assessment;
  final String title;

  const AssessmentTakersPage({required this.title, this.assessment, super.key});

  String get pageTitle => '${assessment != null ? 'Update' : 'Assign'} $title';

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: pageTitle,
      content: [
        AssessmentTakersForm(assessment: assessment),
      ],
    );
  }
}
