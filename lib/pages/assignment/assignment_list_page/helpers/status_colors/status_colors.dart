import 'package:flutter/material.dart';
import 'package:school_erp/enums/assessment_status.dart';

class StatusColors {
  Color getStatusTextColor(AssessmentStatus status) {
    switch (status) {
      case AssessmentStatus.toBeCompleted:
        return Colors.blue;
      case AssessmentStatus.toBePublished:
        return Colors.orange;
      case AssessmentStatus.published:
        return const Color.fromARGB(255, 255, 255, 255);
      case AssessmentStatus.toFinishEvaluation:
        return Colors.yellow.shade700;
      case AssessmentStatus.finishedEvaluation:
        return Colors.grey.shade900;
    }
  }

  Color getStatusColor(AssessmentStatus status) {
    switch (status) {
      case AssessmentStatus.toBeCompleted:
        return Colors.lightBlue.shade50;
      case AssessmentStatus.toBePublished:
        return Colors.orange.shade100;
      case AssessmentStatus.published:
        return const Color.fromARGB(255, 0, 255, 8);
      case AssessmentStatus.toFinishEvaluation:
        return Colors.yellow.shade200;
      case AssessmentStatus.finishedEvaluation:
        return Colors.grey.shade400;
    }
  }
}
