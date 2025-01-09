import 'package:powersync/sqlite3_common.dart' as sqlite;

class AttendanceSummary {
  String id;
  String firstName;
  String lastName;
  int presentTotal;
  int absentTotal;
  int lateTotal;

  AttendanceSummary({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.presentTotal,
    required this.absentTotal,
    required this.lateTotal,
  });

  factory AttendanceSummary.fromRow(sqlite.Row row) => AttendanceSummary(
        id: row['id'],
        firstName: row['first_name'],
        lastName: row['last_name'],
        presentTotal: row['presentTotal'],
        absentTotal: row['absentTotal'],
        lateTotal: row['lateTotal'],
      );
}