import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart';
import 'package:school_erp/dtos/assessment/assessment_create_dto.dart';
import 'package:school_erp/dtos/assessment_taker/assessment_taker_create_dto.dart';
import 'package:school_erp/repositories/assessment_repository.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;
import 'package:school_erp/repositories/assessment_taker_repository.dart';

class AssessmentService {
  final PowerSyncDatabase db;
  final AssessmentRepository assessmentRepository;
  final AssessmentTakerRepository assessmentTakerRepository;

  AssessmentService(PowerSyncDatabase? database)
      : db = database ?? ps.db,
        assessmentRepository =
            AssessmentRepository(database: database ?? ps.db),
        assessmentTakerRepository =
            AssessmentTakerRepository(database: database ?? ps.db);

  Future<(bool, (ResultSet, ResultSet))> create({
    required AssessmentCreateDTO assessmentCreateDTO,
    required AssessmentTakerCreateDTO assessmentTakerCreateDTO,
  }) async {
    try {
      final result = await db.writeTransaction((tx) async {
        final ResultSet resultAssessment = await assessmentRepository
            .createTransaction(assessmentCreateDTO, tx);

        assessmentTakerCreateDTO.assessmentId = resultAssessment.first['id'];

        final ResultSet resultAssessmentTaker = await assessmentTakerRepository
            .createTransaction(assessmentTakerCreateDTO, tx);

        return (true, (resultAssessment, resultAssessmentTaker));
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }
}
