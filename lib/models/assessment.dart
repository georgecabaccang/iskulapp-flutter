import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/models/assessment_taker.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/utils/sql_statements.dart';

class Assessment {
  final String id;
  final String subjectYearId;
  final String preparedById;
  final AssessmentType assessmentType;
  final String title;
  final String? instructions;
  final int totalQuestions;
  final bool randomizeSequence;
  final AssessmentStatus status;
  final int? durationMinutes;

  /// related fields
  final String? subjectName;

  Assessment({
    required this.id,
    required this.subjectYearId,
    required this.preparedById,
    required this.assessmentType,
    required this.title,
    this.instructions,
    required this.totalQuestions,
    required this.randomizeSequence,
    required this.status,
    this.durationMinutes,
    this.subjectName,
  });

  factory Assessment.fromRow(sqlite.Row row) {
    return Assessment(
      id: row['id'],
      subjectYearId: row['subject_year_id'],
      preparedById: row['prepared_by'],
      assessmentType: AssessmentType.fromString(row['assessment_type']),
      title: row['title'],
      instructions: row['instructions'],
      totalQuestions: row['total_questions'],
      randomizeSequence: (row['randomize_sequence'] == 1),
      durationMinutes: row['duration_mins'],
      status: AssessmentStatus.fromString(row['status']),
      subjectName: row['subject_name'],
    );
  }

  Future<List<AssessmentTaker>> assessmentTakers() async {
    var results = await db.execute(assessmentTakersSql, [id]);
    return results.map(AssessmentTaker.fromRow).toList(growable: false);
  }

  Future<SubjectYear> subjectYear() async {
    var results = await db.execute(subjectYearSql, [subjectYearId]);
    return SubjectYear.fromRow(results.first);
  }

  static Future<List<AssessmentTaker>> getAssessmentTakers(assessmentId) async {
    var results = await db.execute(assessmentTakersSql, [assessmentId]);
    return results.map(AssessmentTaker.fromRow).toList(growable: false);
  }

  static Stream<List<Assessment>> watchLists(AssessmentType assessmentType) {
    return db.watch(
      assessmentsSql,
      parameters: [assessmentType.value],
    ).map((results) {
      return results.map(Assessment.fromRow).toList(growable: false);
    });
  }
}
