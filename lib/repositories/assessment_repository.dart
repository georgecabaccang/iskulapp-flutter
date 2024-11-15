import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/models/assessment_taker.dart';
import 'package:school_erp/models/tables/assessments_table.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/repositories/base_crud_repository/base_crud_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class AssessmentRepository extends BaseCrudRepository<Assessment> {
  AssessmentRepository({super.database})
      : super(table: assessmentsTable, fromRow: Assessment.fromRow);

  Future<List<AssessmentTaker>> getAssessmentTakers(String assessmentId) async {
    var results = await database.execute(assessmentTakersSql, [assessmentId]);
    return results.map(AssessmentTaker.fromRow).toList(growable: false);
  }

  Stream<List<Assessment>> watchAssessmentList(AssessmentType assessmentType) {
    return database.watch(
      assessmentsSql,
      parameters: [assessmentType.value],
    ).map((results) {
      return results.map(Assessment.fromRow).toList(growable: false);
    });
  }
}
