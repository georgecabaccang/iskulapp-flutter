import 'package:powersync/sqlite3_common.dart' as sqlite;
import './base_model/base_model.dart';

class AssessmentTaker extends BaseModel {
  final String? assessmentId;
  final String? sectionId;
  final DateTime startTime;
  final DateTime? deadLine;

  /// from relationships, populated only depending on the SELECT statements
  final String? sectionName;

  AssessmentTaker._({
    super.id,
    this.assessmentId,
    this.sectionId,
    required this.startTime,
    this.deadLine,
    this.sectionName,
  });

  factory AssessmentTaker({
    String? id,
    required String assessmentId,
    required String sectionId,
    required DateTime startTime,
    DateTime? deadLine,
    String? sectionName,
  }) {
    return AssessmentTaker._(
      id: id,
      assessmentId: assessmentId,
      sectionId: sectionId,
      startTime: startTime,
      deadLine: deadLine,
      sectionName: sectionName,
    );
  }

  factory AssessmentTaker.initialize() {
    final assessmentTaker = AssessmentTaker._(
      startTime: DateTime.now().add(Duration(minutes: 30)),
      deadLine: DateTime.now().add(Duration(days: 1)),
    );
    return assessmentTaker;
  }

  @override
  Map<String, dynamic> get tableData => {
        'id': id,
        'assessment_id': assessmentId,
        'section_id': sectionId,
        'start_time': startTime.toIso8601String(),
        'dead_line': deadLine?.toIso8601String(),
      };

  factory AssessmentTaker.fromRow(sqlite.Row row) {
    return AssessmentTaker._(
      id: row['id'],
      assessmentId: row['assessment_id'],
      sectionId: row['section_id'],
      startTime: DateTime.parse(row['start_time'] as String),
      deadLine:
          row['dead_line'] != null ? DateTime.parse(row['dead_line']) : null,
      sectionName: row['section_name'] as String?,
    );
  }

  AssessmentTaker copyWith({
    String? id,
    String? assessmentId,
    String? sectionId,
    DateTime? startTime,
    DateTime? deadLine,
  }) {
    final assessmentTaker = AssessmentTaker._(
      id: id ?? this.id,
      assessmentId: assessmentId ?? this.assessmentId,
      sectionId: sectionId ?? this.sectionId,
      startTime: startTime ?? this.startTime,
      deadLine: deadLine ?? this.deadLine,
    );
    return assessmentTaker;
  }
}
