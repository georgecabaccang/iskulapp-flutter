import 'package:school_erp/dtos/dto.dart';

class AssessmentTakerCreateDTO extends CreateDTO {
  String? assessmentId;
  final String sectionId;
  final DateTime startTime;
  final DateTime deadLine;

  AssessmentTakerCreateDTO({
    required this.sectionId,
    required this.startTime,
    required this.deadLine,
    this.assessmentId,
  });
}

class AssessmentTakerUpdateDTO extends UpdateDTO {
  String? assessmentId;
  final String? sectionId;
  final DateTime? startTime;
  final DateTime? deadLine;

  AssessmentTakerUpdateDTO(
    super.id, {
    this.assessmentId,
    this.sectionId,
    this.startTime,
    this.deadLine,
  });
}
