import 'package:powersync/sqlite3_common.dart' as sqlite;

class SubjectYear {
  final String id;
  final String academicYearId;
  final String subjectId;

  // from relation
  final String? subjectName;

  SubjectYear({
    required this.id,
    required this.academicYearId,
    required this.subjectId,
    this.subjectName,
  });

  factory SubjectYear.fromRow(sqlite.Row row) {
    return SubjectYear(
        id: row['id'],
        academicYearId: row['academic_year_id'],
        subjectId: row['subject_id'],
        subjectName: row['subject_name']);
  }
}
