import 'package:powersync/sqlite3_common.dart' as sqlite;

class Section {
  final String id;
  final String academicYearId;
  final String gradeLevelId;
  final String? advisorId;
  final String name;

  Section({
    required this.id,
    required this.academicYearId,
    required this.gradeLevelId,
    this.advisorId,
    required this.name,
  });

  factory Section.fromRow(sqlite.Row row) {
    return Section(
      id: row['id'],
      academicYearId: row['academic_year_id'],
      gradeLevelId: row['grade_level_id'],
      advisorId: row['advisor_id'],
      name: row['name'],
    );
  }
}
