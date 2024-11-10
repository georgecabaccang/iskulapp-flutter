import 'package:powersync/powersync.dart';
import 'package:school_erp/dtos/assessment_dto.dart';
import 'package:school_erp/models/tables/assessments_table.dart';
import 'package:school_erp/repositories/base_crud_repository.dart';

class AssessmentRepository
    extends BaseCrudRepository<AssessmentCreateDTO, AssessmentUpdateDTO> {
  AssessmentRepository({required PowerSyncDatabase database})
      : super(table: assessmentsTable, database: database);

  @override
  Map<String, dynamic> toCreateMap(AssessmentCreateDTO dto) {
    return {
      'subject_year_id': dto.subjectYearId,
      'prepared_by': dto.preparedById,
      'assessment_type': dto.assessmentType.value,
      'title': dto.title,
      'instructions': dto.instructions,
      'total_questions': dto.totalQuestions,
      'duration_mins': dto.durationMinutes,
      'randomize_sequence': dto.randomizeSequence,
      'status': dto.status.value,
    };
  }

  @override
  Map<String, dynamic> toUpdateMap(AssessmentUpdateDTO dto) {
    return {
      'subject_year_id': dto.subjectYearId,
      'title': dto.title,
      'instructions': dto.instructions,
      'total_questions': dto.totalQuestions,
      'duration_mins': dto.durationMinutes,
      'randomize_sequence': dto.randomizeSequence,
      'status': dto.status?.value,
    };
  }
}
