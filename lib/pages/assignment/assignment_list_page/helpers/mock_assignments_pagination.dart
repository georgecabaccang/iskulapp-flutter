import 'dart:math';

import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/helpers/mock_assignments.dart';

class AssignmentPagination extends Assignment {
    AssignmentPagination({
        required super.preparedById,
        super.subjectYearId,
        required super.assessmentType,
        required super.title,
        required super.instructions,
        required super.totalQuestions,
        required super.randomizeSequence,
        required super.status,
        super.durationMinutes,
        required super.subjectName,
    });

    static AssignmentPagination fromIndex(int index) {
        return AssignmentPagination(
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

class DummyAssignmentDatabasePagination {
    final List<AssignmentPagination> _assignments;
    static const int _numberOfAssignments = 90;

    DummyAssignmentDatabasePagination()
        : _assignments = List.generate(_numberOfAssignments,
            (index) => AssignmentPagination.fromIndex(index),
            growable: true);

    Future<List<AssignmentPagination>> getFeeds() async {
        await Future.delayed(Duration(seconds: 2));
        return _assignments;
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
