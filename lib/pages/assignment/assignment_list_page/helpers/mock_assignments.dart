import 'dart:math';

import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/enums/assessment_type.dart';

class Assignment {
  final String preparedById;
  final String? subjectYearId;
  final AssessmentType assessmentType;
  final String title;
  final String instructions;
  final int totalQuestions;
  final bool randomizeSequence;
  final AssessmentStatus status;
  final int? durationMinutes;
  final String subjectName;

  Assignment({
    required this.preparedById,
    this.subjectYearId,
    required this.assessmentType,
    required this.title,
    required this.instructions,
    required this.totalQuestions,
    required this.randomizeSequence,
    required this.status,
    this.durationMinutes,
    required this.subjectName,
  });

  static Assignment fromIndex(int index) {
    return Assignment(
      preparedById: generateString(10),
      subjectYearId: null,
      assessmentType: AssessmentType.assignment,
      title: generateString(20),
      instructions: "This is the instruction.",
      totalQuestions: 10,
      randomizeSequence: true,
      status: AssessmentStatus.toBeCompleted,
      durationMinutes: null,
      subjectName: generateString(15),
    );
  }
}

class DummyAssignmentDatabase {
  final List<Assignment> _assignments;
  static const int _numberOfAssignments = 23;

  DummyAssignmentDatabase()
      : _assignments = List.generate(
            _numberOfAssignments, (index) => Assignment.fromIndex(index),
            growable: true);

  Future<List<Assignment>> getFeeds(int startIndex, int count) async {
    // This will handle things to not exceed existing "rows" of data.
    int endIndex = (startIndex + count) > _assignments.length
        ? _assignments.length
        : startIndex + count;

    // Simlute request delay
    await Future.delayed(Duration(seconds: 2));

    // Return "rows" starting from the new startIndex on each request and the new endIndex
    return _assignments.sublist(startIndex, endIndex);
  }
}

String generateString(int length) {
  String aplphabet = "abcdefghijklmnopqrstuvwxyz ";
  Random random = Random();
  String string = "";

  for (var i = 0; i < length; i++) {
    int randomNum = random.nextInt(25) + 1;
    string += aplphabet[randomNum];
  }
  return string;
}
