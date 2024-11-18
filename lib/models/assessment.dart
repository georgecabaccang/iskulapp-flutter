import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/enums/assessment_type.dart';
import './base_model/base_model.dart';

class Assessment extends BaseModel {
  final String preparedById;
  final String? subjectYearId;
  final AssessmentType assessmentType;
  final String title;
  final String instructions;
  final int totalQuestions;
  final bool randomizeSequence;
  final AssessmentStatus status;
  final int? durationMinutes;

  /// from relationships, populated only depending on the SELECT statements
  final String? subjectName;

  Assessment._({
    super.id,
    required this.preparedById,
    this.subjectYearId,
    required this.assessmentType,
    required this.title,
    required this.instructions,
    required this.totalQuestions,
    required this.randomizeSequence,
    required this.status,
    this.durationMinutes,
    this.subjectName,
  });

  factory Assessment({
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
    String? subjectName,
  }) {
    final assessment = Assessment._(
      id: id,
      preparedById: preparedById,
      subjectYearId: subjectYearId,
      assessmentType: assessmentType,
      title: title,
      instructions: instructions,
      totalQuestions: totalQuestions,
      randomizeSequence: randomizeSequence,
      status: status,
      durationMinutes: durationMinutes,
      subjectName: subjectName,
    );
    return assessment;
  }

  factory Assessment.initialize({
    required String preparedById,
    required AssessmentType assessmentType,
  }) {
    return Assessment._(
      preparedById: preparedById,
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

  Assessment copyWith({
    String? id,
    String? preparedById,
    String? subjectYearId,
    AssessmentType? assessmentType,
    String? title,
    String? instructions,
    int? totalQuestions,
    bool? randomizeSequence,
    AssessmentStatus? status,
    int? durationMinutes,
    String? subjectName,
  }) {
    final assessment = Assessment._(
      id: id ?? this.id,
      preparedById: preparedById ?? this.preparedById,
      subjectYearId: subjectYearId ?? this.subjectYearId,
      assessmentType: assessmentType ?? this.assessmentType,
      title: title ?? this.title,
      instructions: instructions ?? this.instructions,
      totalQuestions: totalQuestions ?? this.totalQuestions,
      randomizeSequence: randomizeSequence ?? this.randomizeSequence,
      status: status ?? this.status,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      subjectName: subjectName ?? this.subjectName,
    );
    return assessment;
  }
}
