import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart';
import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';

class AssessmentService {
  static Future<(bool, (ResultSet, ResultSet))> create(
      {required PowerSyncDatabase db,
      required AssessmentCreateDTO data}) async {
    try {
      final result = await db.writeTransaction((tx) async {
        final resultAssessment = await tx.execute("""
          INSERT INTO assessments (
            id,
            prepared_by,
            assessment_type,
            title,
            total_questions,
            start_time,
            dead_line,
            duration_mins,
            status,
            created_at,
            updated_at
          )
          VALUES (
            uuid(),
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            ?,
            datetime('now'),
            datetime('now')
          )
          RETURNING *
        """, [
          data.preparedById,
          data.assessmentType.value,
          data.title,
          data.totalQuestions,
          data.startTime.toIso8601String(),
          data.deadLine.toIso8601String(),
          data.durationMinutes,
          data.status.value
        ]);

        final resultTaker = await tx.execute("""
          INSERT INTO assessment_takers (
            id,
            assessment_id,
            subject_year_id,
            section_id,
            created_at,
            updated_at
          )
          VALUES (
            uuid(),
            ?,
            ?,
            ?,
            datetime('now'),
            datetime('now')
          )
          RETURNING *
        """, [
          resultAssessment.first['id'],
          data.subjectYearId,
          data.sectionId,
        ]);

        return (resultAssessment, resultTaker);
      });
      return (true, result);
    } catch (e) {
      rethrow; //temp
    }
  }
}
