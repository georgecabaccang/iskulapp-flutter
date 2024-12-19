import 'package:school_erp/models/student.dart';
import 'package:school_erp/utils/sql_statements.dart';
import 'package:powersync/powersync.dart';
import 'package:school_erp/features/powersync/db.dart';

class StudentRepository {
  PowerSyncDatabase database;

  StudentRepository({PowerSyncDatabase? database}) : database = database ?? db;

  Future<List<Student>> getStudentsBySection(
    String sectionId,
  ) async {
    var results = await database.execute(
      studentsBySectionSql,
      [sectionId],
    );

    if (results.isEmpty) {
      return [];
    }

    return results.map(Student.fromRow).toList(growable: false);
  }
}
