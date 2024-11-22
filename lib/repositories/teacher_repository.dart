import 'package:powersync/powersync.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/utils/sql_statements.dart';

class TeacherRepository {
  PowerSyncDatabase database;
  TeacherRepository({database}) : database = database ?? db;

  Future<List<Section>> activeSections() async {
    final results = await db.execute(teacherActiveSectionsSql);
    return results.map(Section.fromRow).toList(growable: false);
  }

  Future<List<SubjectYear>> activeSubjects() async {
    final results = await db.execute(teacherActiveSubjectsSql);
    return results.map(SubjectYear.fromRow).toList(growable: false);
  }
}
