import 'package:school_erp/dtos/dto.dart';
import 'package:school_erp/dtos/utils.dart';
import 'package:school_erp/enums/assessment_status.dart';
import 'package:school_erp/enums/assessment_type.dart';

class AssessmentCreateDTO extends CreateDTO {
  final AssessmentType assessmentType;
  final String subjectYearId;
  final String preparedById;
  final String title;
  final String? instructions;
  final int totalQuestions;
  final int randomizeSequence;
  final int? durationMinutes;
  final AssessmentStatus status;

  AssessmentCreateDTO({
    required this.assessmentType,
    required this.subjectYearId,
    required this.preparedById,
    required this.title,
    this.instructions,
    required this.totalQuestions,
    required bool randomizeSequence,
    this.durationMinutes,
  })  : randomizeSequence = boolAsInt(randomizeSequence),
        status = AssessmentStatus.toBeCompleted;
}

class AssessmentUpdateDTO extends UpdateDTO {
  final String? title;
  final String? subjectYearId;
  final String? instructions;
  final int? totalQuestions;
  final int? randomizeSequence;
  final int? durationMinutes;
  final AssessmentStatus? status;

  AssessmentUpdateDTO(
    super.id, {
    this.title,
    this.instructions,
    this.subjectYearId,
    this.totalQuestions,
    bool? randomizeSequence,
    this.durationMinutes,
    this.status,
  }) : randomizeSequence = boolAsInt(randomizeSequence);
}
