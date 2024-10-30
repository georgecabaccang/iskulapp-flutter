import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart';
import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';
import 'package:school_erp/dtos/assessment/assessment_taker_create_dto.dart';
import 'package:school_erp/repositories/assessment_repository.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;
import 'package:school_erp/repositories/assessment_taker_repository.dart';

class AssessmentService {
  late PowerSyncDatabase db;
  late AssessmentRepository assessmentRepository;
  late AssessmentTakerRepository assessmentTakerRepository;

  AssessmentService({PowerSyncDatabase? database}) {
    db = database ?? ps.db;
    assessmentRepository = AssessmentRepository(database: db);
    assessmentTakerRepository = AssessmentTakerRepository(database: db);
  }

  Future<(bool, (ResultSet, ResultSet))> create({
    required AssessmentCreateDTO assessmentDTO,
    required AssessmentTakerCreateDTOBuilder assessmentTakerDTOBuilder,
  }) async {
    try {
      final result = await db.writeTransaction((tx) async {
        final ResultSet resultAssessment =
            await assessmentRepository.createTransaction(assessmentDTO, tx);
        assessmentTakerDTOBuilder.assessmentId = resultAssessment.first['id'];
        final assessmentTakerDTO = assessmentTakerDTOBuilder.build();
        final ResultSet resultAssessmentTaker = await assessmentTakerRepository
            .createTransaction(assessmentTakerDTO, tx);

        return (true, (resultAssessment, resultAssessmentTaker));
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }
}      //final ResultSet resultAssessment =
      //    await assessmentRepository.create(assessmentDTO);
      //assessmentTakerDTOBuilder.assessmentId = resultAssessment.first['id'];
      //final assessmentTakerDTO = assessmentTakerDTOBuilder.build();
      //final resultAssessmentTaker =
      //    await assessmentTakerRepository.create(assessmentTakerDTO);
      //
      //return (true, (resultAssessment, resultAssessmentTaker));
    //} catch (e) {
    //  rethrow;
    //}

  //static Future<(bool, (ResultSet, ResultSet))> createOld({
  //  required PowerSyncDatabase db,
  //  required AssessmentCreateDTO data,
  //}) async {
  //  try {
  //    final result = await db.writeTransaction((tx) async {
  //      final resultAssessment = await tx.execute("""
  //        INSERT INTO assessments (
  //          id,
  //          prepared_by,
  //          assessment_type,
  //          title,
  //          total_questions,
  //          start_time,
  //          dead_line,
  //          duration_mins,
  //          status,
  //          created_at,
  //          updated_at
  //        )
  //        data.preparedById,
  //        data.assessmentType.value,
  //        data.title,
  //        data.totalQuestions,
  //        data.startTime.toIso8601String(),
  //        data.deadLine.toIso8601String(),
  //        data.durationMinutes,
  //        data.status.value,
  //      ]);
  //      final resultTaker = await tx.execute("""
  //        INSERT INTO assessment_takers (
  //          id,
  //          assessment_id,
  //          subject_year_id,
  //          section_id,
  //          created_at,
  //          updated_at
  //        )
  //        VALUES (
  //          uuid(),
  //          ?,
  //          ?,
  //          ?,
  //          datetime('now'),
  //          datetime('now')
  //        )
  //        RETURNING *
  //      """, [
  //        resultAssessment.first['id'],
  //        data.subjectYearId,
  //        data.sectionId,
  //      ]);
  //      return (resultAssessment, resultTaker);
  //    });
  //    return (true, result);
  //  } catch (e) {
  //    rethrow;
  //  }
  //        VALUES (
  //          uuid(),
  //          ?,
  //          ?,
  //          ?,
  //          ?,
  //          ?,
  //          ?,
  //          ?,
  //          ?,
  //          datetime('now'),
  //          datetime('now')
  //        )
  //        RETURNING *
  //      """, [
  //        data.preparedById,
  //        data.assessmentType.value,
  //        data.title,
  //        data.totalQuestions,
  //        data.startTime.toIso8601String(),
  //        data.deadLine.toIso8601String(),
  //        data.durationMinutes,
  //        data.status.value,
  //      ]);
  //      final resultTaker = await tx.execute("""
  //        INSERT INTO assessment_takers (
  //          id,
  //          assessment_id,
  //          subject_year_id,
  //          section_id,
  //          created_at,
  //          updated_at
  //        )
  //        VALUES (
  //          uuid(),
  //          ?,
  //          ?,
  //          ?,
  //          datetime('now'),
  //          datetime('now')
  //        )
  //        RETURNING *
  //      """, [
  //        resultAssessment.first['id'],
  //        data.subjectYearId,
  //        data.sectionId,
  //      ]);
  //      return (resultAssessment, resultTaker);
  //    });
  //    return (true, result);
  //  } catch (e) {
  //    rethrow;
  //  }
  //}
