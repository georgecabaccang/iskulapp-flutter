import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import './base_model/base_model.dart';

part 'assessment.freezed.dart';

@freezed
class Assessment extends BaseModel with _$Assessment {
  const Assessment._();

  const factory Assessment({
    String? id,
    required String preparedById,
    required String subjectYearId,
    required AssessmentType assessmentType,
    required String title,
    required String instructions,
    required int totalQuestions,
    required bool randomizeSequence,
    required AssessmentStatus status,
    int? durationMinutes,

    /// from relationships, populated only depending on the SELECT statements
    String? subjectName,
  }) = _Assessment;

  factory Assessment.initialize({
    required String preparedById,
    required String subjectYearId,
    required AssessmentType assessmentType,
  }) {
    return Assessment(
      preparedById: preparedById,
      subjectYearId: subjectYearId,
      assessmentType: assessmentType,
      title: '',
      instructions: '',
      totalQuestions: 0,
      randomizeSequence: false,
      status: AssessmentStatus.toBeCompleted,
    );
  }

  @override
  Map<String, dynamic> get tableData => {
        'id': id,
        'subject_year_id': subjectYearId,
        'prepared_by': preparedById,
        'assessment_type': assessmentType.value,
        'title': title,
        'instructions': instructions,
        'total_questions': totalQuestions,
        'duration_mins': durationMinutes,
        'randomize_sequence': randomizeSequence,
        'status': status.value,
      };

  factory Assessment.fromRow(sqlite.Row row) => Assessment(
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
