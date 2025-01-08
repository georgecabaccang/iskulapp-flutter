import 'package:flutter/material.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/assessment_setup_page.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/helpers/builders/build_dates.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/helpers/builders/build_header.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/helpers/builders/build_title.dart';
import 'package:school_erp/pages/common_widgets/cards/custom_item_card.dart';

class AssignmentCard extends StatelessWidget {
  // change type to Assignment for now
  final Assessment assessment;

  const AssignmentCard({
    super.key,
    required this.assessment,
  });

  @override
  Widget build(BuildContext context) {
    return CustomItemCard(
        slideRoute: AssessmentSetupPage(
          assessmentTypeOnCreate: AssessmentType.assignment,
          assessment: assessment,
        ),
        itemContents: [
          BuildHeader(assessment: assessment),
          const SizedBox(height: 3.2),
          BuildTitle(assessment: assessment),
          const SizedBox(height: 7.8),
          BuildDates()
        ]);
  }
}
