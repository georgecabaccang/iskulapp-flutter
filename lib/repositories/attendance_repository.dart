import 'package:intl/intl.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/models/summaries/attendance_summary.dart';
import 'package:school_erp/models/tables/tables.dart';
import 'package:school_erp/repositories/base_repository/base_repository.dart';
import 'package:school_erp/repositories/base_repository/create_mixin.dart';
import 'package:school_erp/repositories/base_repository/update_mixin.dart';
import 'package:school_erp/repositories/base_repository/upsert_mixin.dart';
import 'package:school_erp/utils/sql_statements.dart';

class AttendanceRepository extends BaseRepository<Attendance>
    with
        CreateMixin<Attendance>,
        UpdateMixin<Attendance>,
        UpsertMixin<Attendance> {
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

  Future<List<Attendance>> getStudentsAttendanceBySection({
    required String sectionId,
  }) async {
    var results =
        await database.execute(studentsAttendanceBySectionSql, [sectionId]);

    if (results.isEmpty) {
      return [];
    }

    return results.map(Attendance.fromRow).toList(growable: false);
  }

  Future<List<AttendanceSummary>> getStudentsAttendanceSummaries({
    required String sectionId,
  }) async {
    var results =
        await database.execute(studentsAttendanceSummariesSql, [sectionId]);

    if (results.isEmpty) {
      return [];
    }

    return results.map(AttendanceSummary.fromRow).toList(growable: false);
  }
}