import 'package:powersync/powersync.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/utils/sql_statements.dart';

class SectionRepository {
  PowerSyncDatabase database;

  SectionRepository({PowerSyncDatabase? database}) : database = database ?? db;

  Future<List<Section>> getTeacherSectionsBySubject({
    required String teacherId,
    required String subjectYearId,
  }) async {
    final results = await database.execute(
      teacherSectionsBySubjectSql,
      [teacherId, subjectYearId],
    );

    if (results.isEmpty) {
      return [];
    }

    return results.map(Section.fromRow).toList(growable: false);
  }

  Future<List<Section>> getTeacherSectionsAll({
    required String teacherId,
    required String academicYearId,
  }) async {
    final results = await database.execute(
      teacherSectionsSql,
      [teacherId, academicYearId],
    );

    if (results.isEmpty) {
      return [];
    }

    return results.map(Section.fromRow).toList(growable: false);
  }
}
