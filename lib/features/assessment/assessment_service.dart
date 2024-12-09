import 'package:powersync/powersync.dart';
import 'package:school_erp/features/assessment/assessment_result.dart';
import 'package:school_erp/features/powersync/db.dart' as ps;
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/models/assessment_taker.dart';
import 'package:school_erp/repositories/assessment_repository.dart';
import 'package:school_erp/repositories/assessment_taker_repository.dart';

class AssessmentService {
  final PowerSyncDatabase db;
  final AssessmentRepository assessmentRepository;
  final AssessmentTakerRepository assessmentTakerRepository;

  AssessmentService([PowerSyncDatabase? database])
      : db = database ?? ps.db,
        assessmentRepository =
            AssessmentRepository(database: database ?? ps.db),
        assessmentTakerRepository =
            AssessmentTakerRepository(database: database ?? ps.db);

  Future<AssessmentWithTakersCreateResult> create({
    required Assessment assessment,
    required List<AssessmentTaker> assessmentTakers,
  }) async {
    try {
      final result = await db.writeTransaction((tx) async {
        final assessmentCreated =
            await assessmentRepository.create(assessment, tx: tx);

        // attach assessment id
        final assessmentTakersWithId = assessmentTakers
            .map((assessmentTaker) =>
                assessmentTaker.copyWith(assessmentId: assessmentCreated.id!))
            .toList();

        final assessmentTakersCreated = await assessmentTakerRepository
            .bulkCreate(assessmentTakersWithId, tx: tx);

        return AssessmentWithTakersCreateResult(
          assessment: assessmentCreated,
          assessmentTakers: assessmentTakersCreated,
        );
      });
      return result;
    } catch (e) {
      print(e);
      // temporary not sure what to handle here yet
      rethrow;
    }
  }

  Future<AssessmentWithTakersUpdateResult> update({
    required Assessment assessment,
    required List<AssessmentTaker> assessmentTakers,
    required List<AssessmentTaker> assessmentTakersForRemoval,
  }) async {
    Assessment assessmentUpdated;
    var assessmentTakersUpdated = <AssessmentTaker>[];
    var assessmentTakerIdsRemoved = <String>[];

    final result = await db.writeTransaction((tx) async {
      assessmentUpdated = await assessmentRepository.update(assessment, tx: tx);

      if (assessmentTakers.isNotEmpty) {
        // attach assessment id
        final takers = assessmentTakers
            .map((assessmentTaker) =>
                assessmentTaker.copyWith(assessmentId: assessment.id!))
            .toList();

        assessmentTakersUpdated =
            await assessmentTakerRepository.bulkUpsert(takers, tx: tx);
      }

      if (assessmentTakersForRemoval.isNotEmpty) {
        assessmentTakerIdsRemoved = await assessmentTakerRepository
            .delete(assessmentTakersForRemoval, tx: tx);
      }

      return AssessmentWithTakersUpdateResult(
        assessment: assessmentUpdated,
        assessmentTakers: assessmentTakersUpdated,
        assessmentTakerIdsRemoved: assessmentTakerIdsRemoved,
      );
    });

    return result;
  }
}
