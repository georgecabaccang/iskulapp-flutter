import 'package:powersync/sqlite3_common.dart' as sqlite;

class Student {
  final String id;
  final String userId;
  final String studentNo;

  // from relation
  final String? firstName;
  final String? lastName;

  Student({
    required this.id,
    required this.userId,
    required this.studentNo,
    this.firstName,
    this.lastName,
  });

  factory Student.fromRow(sqlite.Row row) => Student(
        id: row['id'],
        userId: row['user_id'],
        studentNo: row['student_no'],
        firstName: row['first_name'],
        lastName: row['last_name'],
      );
}
