import 'package:powersync/sqlite3_common.dart' as sqlite;
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/utils/sql_statements.dart';

class Section {
  final String id;
  final String academicYearId;
  final String? advisorId;
  final String name;

  Section({
    required this.id,
    required this.name,
    required this.academicYearId,
    this.advisorId,
  });

  factory Section.fromRow(sqlite.Row row) {
    return Section(
      id: row['id'],
      academicYearId: row['academic_year_id'],
      advisorId: row['advisor_id'],
      name: row['name'],
    );
  }

  static Future<Section> find(String id) async {
    var results = await db.execute(sectionSql, [id]);
    return Section.fromRow(results.first);
  }
}
