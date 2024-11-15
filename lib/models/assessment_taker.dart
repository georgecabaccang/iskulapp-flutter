import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:powersync/sqlite3_common.dart' as sqlite;
import './base_model/base_model.dart';

part 'assessment_taker.freezed.dart';

@freezed
class AssessmentTaker extends BaseModel with _$AssessmentTaker {
  const AssessmentTaker._();

  const factory AssessmentTaker({
    String? id,
    required String assessmentId,
    required String sectionId,
    required DateTime startTime,
    DateTime? deadLine,

    /// from relationships, populated only depending on the SELECT statements
    String? sectionName,
  }) = _AssessmentTaker;

  factory AssessmentTaker.initialize({
    required String assessmentId,
    required String sectionId,
  }) {
    return AssessmentTaker(
      assessmentId: assessmentId,
      sectionId: sectionId,
      startTime: DateTime.now().add(Duration(days: 1)),
    );
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
    return AssessmentTaker(
      id: row['id'],
      assessmentId: row['assessment_id'],
      sectionId: row['section_id'],
      startTime: DateTime.parse(row['start_time']),
      deadLine:
          row['dead_line'] != null ? DateTime.parse(row['dead_line']) : null,
      sectionName: row['section_name'],
    );
  }
}
