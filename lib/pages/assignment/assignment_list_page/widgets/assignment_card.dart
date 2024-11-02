import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/pages/assignment/assignment_preview/assignment_preview_page.dart';
import 'package:school_erp/pages/common_widgets/default_button.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';
import 'package:school_erp/theme/colors.dart';

class AssignmentCard extends StatelessWidget {
  final Assessment assessment;

  const AssignmentCard({
    Key? key,
    required this.assessment,
  }) : super(key: key);

  String getStatusText() => assessment.status.displayName;

  Color getStatusTextColor() {
    switch (assessment.status) {
      case AssessmentStatus.toBeCompleted:
        return Colors.blue;
      case AssessmentStatus.toBePublished:
        return Colors.orange;
      case AssessmentStatus.published:
        return Colors.green;
      case AssessmentStatus.toFinishEvaluation:
        return Colors.yellow.shade700;
      case AssessmentStatus.finishedEvaluation:
        return Colors.grey.shade900;
    }
  }

  Color getStatusColor() {
    switch (assessment.status) {
      case AssessmentStatus.toBeCompleted:
        return Colors.lightBlue.shade50;
      case AssessmentStatus.toBePublished:
        return Colors.orange.shade100;
      case AssessmentStatus.published:
        return Colors.green.shade100;
      case AssessmentStatus.toFinishEvaluation:
        return Colors.yellow.shade200;
      case AssessmentStatus.finishedEvaluation:
        return Colors.grey.shade400;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        createSlideRoute(const AssignmentPreviewPage()),
      ),
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
                  _buildHeader(),
                  const SizedBox(height: 8.0),
                  _buildTitle(),
                  const SizedBox(height: 4.0),
                  _buildDates(),
                  const SizedBox(height: 8.0),
                  _buildActionButton(),
                ],
              ),
            ),
            _buildEditButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      children: [
        Expanded(
          child: Text(
            assessment.subject.capitalize(),
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: getStatusColor(),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              getStatusText(),
              style: TextStyle(
                color: getStatusTextColor(),
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildTitle() {
    return Text(
      assessment.title,
      style: const TextStyle(
        fontSize: 16.0,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildDates() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Start Date: ${DateFormat('yyyy-MM-dd HH:mm').format(assessment.startTime)}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
        Text(
          'Submission Date: ${DateFormat('yyyy-MM-dd HH:mm').format(assessment.deadLine)}',
          style: const TextStyle(
            color: Colors.grey,
            fontSize: 14.0,
          ),
        ),
      ],
    );
  }

  Widget _buildActionButton() {
    return Padding(
      padding: const EdgeInsets.only(top: 10.0),
      child: DefaultButton(
        text: getStatusText(),
        onPressed: () {},
      ),
    );
  }

  Widget _buildEditButton(BuildContext context) {
    return Positioned(
      top: 8.0,
      right: 8.0,
      child: IconButton(
        icon: const Icon(Icons.edit, color: Colors.grey),
        onPressed: () {
          Navigator.push(
            context,
            createSlideRoute(const AssignmentPreviewPage()),
          );
        },
      ),
    );
  }
}
