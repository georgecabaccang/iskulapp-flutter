import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/models/assessment_taker.dart';

final class AssessmentWithTakersCreateResult {
  final Assessment assessment;
  final List<AssessmentTaker> assessmentTakers;

  AssessmentWithTakersCreateResult({
    required this.assessment,
    required this.assessmentTakers,
  });
}

final class AssessmentWithTakersUpdateResult {
  final Assessment assessment;
  final List<AssessmentTaker> assessmentTakers;
  final List<String> assessmentTakerIdsRemoved;

  AssessmentWithTakersUpdateResult({
    required this.assessment,
    required this.assessmentTakers,
    required this.assessmentTakerIdsRemoved,
  });
}
