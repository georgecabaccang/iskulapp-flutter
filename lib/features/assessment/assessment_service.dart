import 'package:powersync/powersync.dart';
import 'package:powersync/sqlite3_common.dart';
import 'package:school_erp/dtos/assessment_dto.dart';
import 'package:school_erp/dtos/assessment_taker_dto.dart';
import 'package:school_erp/features/assessment/schemas/assessment_result.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;
import 'package:school_erp/repositories/assessment_repository.dart';
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

  Future<AssessmentWithTakersCreateResult> create({
    required AssessmentCreateDTO assessmentDTO,
    required List<AssessmentTakerCreateDTO> assessmentTakerDTOs,
  }) async {
    try {
      final result = await db.writeTransaction((tx) async {
        final ResultSet assessment =
            await assessmentRepository.create(assessmentDTO, tx);

        for (final assessmentTakerDTO in assessmentTakerDTOs) {
          assessmentTakerDTO.assessmentId = assessment.first['id'];
        }

        final List<ResultSet> assessmentTakers =
            await assessmentTakerRepository.bulkCreate(assessmentTakerDTOs, tx);

        return AssessmentWithTakersCreateResult(
          assessment: assessment,
          assessmentTakers: assessmentTakers,
        );
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }

  Future<AssessmentWithTakersUpdateResult> update({
    AssessmentUpdateDTO? assessmentDTO,
    List<AssessmentTakerUpdateDTO>? assessmentTakerDTOs,
    List<String>? removeAssessmentTakerIds,
  }) async {
    _validateUpdateArgs(assessmentTakerDTOs, removeAssessmentTakerIds);

    ResultSet? assessment;
    var assessmentTakers = <ResultSet>[];
    ResultSet? removedAssessmentTakers;

    try {
      final result = await db.writeTransaction((tx) async {
        if (assessmentDTO != null) {
          assessment = await assessmentRepository.update(assessmentDTO, tx);
        }

        if (assessmentTakerDTOs != null) {
          final assessmentTakerFutures = <Future<ResultSet>>[];
          for (final assessmentTakerDTO in assessmentTakerDTOs) {
            assessmentTakerFutures.add(
              assessmentTakerRepository.createOrUpdate(
                assessmentTakerDTO,
                ['id'],
                tx,
              ),
            );
          }
          assessmentTakers = await Future.wait(assessmentTakerFutures);
        }

        if (removeAssessmentTakerIds != null) {
          removedAssessmentTakers = await assessmentTakerRepository.delete(
              removeAssessmentTakerIds, tx);
        }

        return AssessmentWithTakersUpdateResult(
          assessment: assessment,
          assessmentTakers: assessmentTakers,
          removedAssessmentTakers: removedAssessmentTakers,
        );
      });
      return result;
    } catch (e) {
      rethrow;
    }
  }

  /// validate that item that is being updated is not being removed at the same time
  void _validateUpdateArgs(
    List<AssessmentTakerUpdateDTO>? assessmentTakerDTOs,
    List<String>? removeAssessmentTakerIds,
  ) {
    if (assessmentTakerDTOs != null && removeAssessmentTakerIds != null) {
      final updateIds = assessmentTakerDTOs
          .where((dto) => dto.id != null)
          .map((dto) => dto.id!)
          .toSet();
      final removeIds = removeAssessmentTakerIds.toSet();
      final intersection = updateIds.intersection(removeIds);

      if (intersection.isNotEmpty) {
        throw ArgumentError(
          'Cannot update and remove the same assessment takers: ${intersection.join(", ")}',
        );
      }
    }
  }
}
