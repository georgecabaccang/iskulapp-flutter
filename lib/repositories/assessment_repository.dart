import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/models/tables/assessments_table.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/repositories/base_crud_repository/base_crud_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class AssessmentRepository extends BaseCrudRepository<Assessment> {
  AssessmentRepository({super.database})
      : super(table: assessmentsTable, fromRow: Assessment.fromRow);

  Stream<List<Assessment>> watchTeacherAssessments({
    required String teacherId,
    required AssessmentType assessmentType,
    required String academicYearId,
  }) {
    final stream = database.watch(
      teacherAssessmentsSql,
      parameters: [teacherId, assessmentType.value, academicYearId],
    );

    return stream.map((results) {
      if (results.isEmpty) {
        return [];
      }
      return results.map(Assessment.fromRow).toList(growable: false);
    });
  }
}
