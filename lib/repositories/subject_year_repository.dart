import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/models/tables/subject_years_table.dart';
import 'package:school_erp/repositories/base_repository/read_only_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class SubjectYearRepository extends ReadOnlyRepository<SubjectYear> {
  SubjectYearRepository({super.database})
      : super(table: subjectYearsTable, fromRow: SubjectYear.fromRow);

  Future<List<SubjectYear>> getTeacherSubjects({
    required String teacherId,
    required String academicYearId,
  }) async {
    final results = await db.execute(
      teacherSubjectsSql,
      [teacherId, academicYearId],
    );
    if (results.isEmpty) {
      return [];
    }
    return results.map(SubjectYear.fromRow).toList(growable: false);
  }
}
