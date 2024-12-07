
import 'package:powersync/sqlite3_common.dart' as sqlite;

class SubjectClass {
  final String id;
  final String subjectYearId;
  final String teacherId;
  final String sectionId;

  const SubjectClass({
    required this.id,
    required this.subjectYearId,
    required this.teacherId,
    required this.sectionId,
  });

  factory SubjectClass.fromRow(sqlite.Row row) {
    return SubjectClass(
      id: row['id'],
      subjectYearId: row['subject_year_id'],
      teacherId: row['teacher_id'],
      sectionId: row['section_id'],
    );
  }
}
