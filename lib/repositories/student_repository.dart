import 'package:school_erp/models/student.dart';
import 'package:school_erp/models/tables/students_table.dart';
import 'package:school_erp/repositories/base_repository/read_only_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class StudentRepository extends ReadOnlyRepository<Student> {
  StudentRepository({super.database})
      : super(table: studentsTable, fromRow: Student.fromRow);

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
