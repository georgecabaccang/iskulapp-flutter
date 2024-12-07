import 'package:powersync/powersync.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/utils/sql_statements.dart';

class SubjectYearRepository {
  PowerSyncDatabase database;

  SubjectYearRepository({PowerSyncDatabase? database})
      : database = database ?? db;

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
