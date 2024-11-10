import 'package:powersync/powersync.dart';

const assessmentTakersTable = Table('assessment_takers', [
  Column.text('assessment_id'),
  Column.text('section_id'),
  Column.text('start_time'),
  Column.text('dead_line'),
  Column.text('created_at'),
  Column.text('updated_at'),
]);
