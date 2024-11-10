import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/dtos/assessment_taker_dto.dart';

class AssessmentTaker {
  final String id;
  final String assessmentId;
  final String sectionId;
  final DateTime startTime;
  final DateTime? deadLine;

  // from relationships
  final String? sectionName;

  AssessmentTaker({
    required this.id,
    required this.assessmentId,
    required this.sectionId,
    required this.startTime,
    this.deadLine,
    this.sectionName,
  });

  factory AssessmentTaker.fromRow(sqlite.Row row) {
    return AssessmentTaker(
      id: row['id'],
      assessmentId: row['assessment_id'],
      sectionId: row['section_id'],
      startTime: DateTime.parse(row['start_time']),
      deadLine: DateTime.parse(row['dead_line']),
      sectionName: row['section_name'],
    );
  }

  // ahhhhhhhhhhhhhh i dont think this is the way @.@
  AssessmentTakerUpdateDTO toUpdateDTO() {
    return AssessmentTakerUpdateDTO(
      id,
      assessmentId: assessmentId,
      sectionId: sectionId,
      startTime: startTime,
      deadLine: deadLine,
    );
  }
}
