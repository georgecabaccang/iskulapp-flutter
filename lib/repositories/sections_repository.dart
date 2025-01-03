import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/tables/sections_table.dart';
import 'package:school_erp/repositories/base_repository/read_only_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class SectionRepository extends ReadOnlyRepository<Section> {
  SectionRepository({super.database})
      : super(table: sectionsTable, fromRow: Section.fromRow);

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
