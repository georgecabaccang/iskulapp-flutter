import 'package:powersync/powersync.dart';

const attendancesTable = Table('attendances', [
  Column.text('student_id'),
  Column.text('checked_by'),
  Column.text('section_id'),
  Column.text('attendance_date'),
  Column.text('time_in'),
  Column.text('status'),
  Column.text('created_at'),
  Column.text('updated_at')
]);
