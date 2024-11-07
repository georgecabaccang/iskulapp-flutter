import 'package:powersync/sqlite3.dart';

final class AssessmentWithTakersCreateResult {
  final ResultSet assessment;
  final List<ResultSet> assessmentTakers;

  AssessmentWithTakersCreateResult({
    required this.assessment,
    required this.assessmentTakers,
  });
}

final class AssessmentWithTakersUpdateResult {
  final ResultSet? assessment;
  final List<ResultSet> assessmentTakers;
  final ResultSet? removedAssessmentTakers;

  AssessmentWithTakersUpdateResult({
    this.assessment,
    required this.assessmentTakers,
    this.removedAssessmentTakers,
  });
}
