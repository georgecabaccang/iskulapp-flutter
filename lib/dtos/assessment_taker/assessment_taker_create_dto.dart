import 'package:school_erp/dtos/dto.dart';

class AssessmentTakerCreateDTO extends CreateDTO {
  String? assessmentId;
  final String subjectYearId;
  final String sectionId;

  AssessmentTakerCreateDTO({
    required this.subjectYearId,
    required this.sectionId,
    this.assessmentId,
  });
}
