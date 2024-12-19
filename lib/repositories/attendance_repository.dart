import 'package:intl/intl.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/models/tables/tables.dart';
import 'package:school_erp/repositories/base_crud_repository/base_crud_repository.dart';
import 'package:school_erp/utils/sql_statements.dart';

class AttendanceRepository extends BaseCrudRepository<Attendance> {
  AttendanceRepository({super.database})
      : super(table: attendancesTable, fromRow: Attendance.fromRow);

  Future<List<Attendance>> getStudentsAttendanceByDateAndSection({
    required DateTime attendanceDate,
    required String sectionId,
  }) async {
    var attendanceDateString = DateFormat('yyyy-MM-dd').format(attendanceDate);
    var results = await database.execute(studentsAttendanceByDateAndSectionSql,
        [attendanceDateString, sectionId]);

    if (results.isEmpty) {
      return [];
    }

    return results.map(Attendance.fromRow).toList(growable: false);
  }
}
