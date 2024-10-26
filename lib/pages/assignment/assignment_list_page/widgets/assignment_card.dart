import 'package:flutter/material.dart';
import 'package:school_erp/enums/assessment_status.dart';
<<<<<<< HEAD
import 'package:intl/intl.dart';
import 'package:school_erp/pages/assignment/assignment_check_page/assignment_check_page.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';
=======
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/assignment/assignment_check_page/assignment_check_page.dart';
>>>>>>> 0a335b30071591f3932911ecc4b57dbd7a23cec5

class AssignmentCard extends StatelessWidget {
  final String subject;
  final String title;
  final String assignDate;
  final String lastSubmissionDate;
  final AssessmentStatus status;

  const AssignmentCard({
    super.key,
    required this.subject,
    required this.title,
    required this.assignDate,
    required this.lastSubmissionDate,
    required this.status,
  });

  String getStatusText() => status.displayName;

  Color getStatusTextColor() {
    switch (status) {
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
    switch (status) {
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
      onTap: () {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const AssignmentCheckPage(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              var fadeTween = Tween(begin: 0.0, end: 1.0)
                  .chain(CurveTween(curve: Curves.easeInOut));
              var fadeAnimation = animation.drive(fadeTween);

              return FadeTransition(
                opacity: fadeAnimation,
                child: child,
              );
            },
          ),
        );
      },
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
          side: const BorderSide(color: Colors.grey, width: 1.0),
        ),
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
<<<<<<< HEAD
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Text(
                      subject.capitalize(),
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                      ),
                    ),
                  ),
                  Container(
                    width: 98.0,
                    height: 28.0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
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
                            fontSize: 8.0),
                      ),
                    ),
                  ),
=======
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    subject,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Container(
                    width: 98.0,
                    height: 28.0,
                    padding: const EdgeInsets.symmetric(
                        vertical: 4.0, horizontal: 8.0),
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
                        ),
                      ),
                    ),
                  ),
>>>>>>> 0a335b30071591f3932911ecc4b57dbd7a23cec5
                ],
              ),
              const SizedBox(height: 8.0),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 8.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Assign Date',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    assignDate,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
              const SizedBox(height: 4.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Last Submission Date',
                    style: TextStyle(color: Colors.grey),
                  ),
                  Text(
                    lastSubmissionDate,
                    style: const TextStyle(fontWeight: FontWeight.w500),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
