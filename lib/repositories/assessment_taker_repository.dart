import 'package:powersync/powersync.dart';
import 'package:school_erp/dtos/assessment_taker_dto.dart';
import 'package:school_erp/models/tables/assessment_takers_table.dart';
import 'package:school_erp/repositories/base_crud_repository.dart';

class AssessmentTakerRepository extends BaseCrudRepository<
    AssessmentTakerCreateDTO, AssessmentTakerUpdateDTO> {
  AssessmentTakerRepository({required PowerSyncDatabase database})
      : super(table: assessmentTakersTable, database: database);

  @override
  Map<String, dynamic> toCreateMap(AssessmentTakerCreateDTO dto) {
    return {
      'assessment_id': dto.assessmentId,
      'section_id': dto.sectionId,
      'start_time': dto.startTime.toIso8601String(),
      'dead_line': dto.deadLine.toIso8601String(),
    };
  }

  @override
  Map<String, dynamic> toUpdateMap(AssessmentTakerUpdateDTO dto) {
    return {
      'assessment_id': dto.assessmentId,
      'section_id': dto.sectionId,
      'start_time': dto.startTime?.toIso8601String(),
      'dead_line': dto.deadLine?.toIso8601String(),
    };
  }
}
