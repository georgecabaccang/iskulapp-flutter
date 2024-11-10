import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/utils/sql_statements.dart';

class Teacher {
  final String id;
  final String userId;
  final DateTime employedDate;
  final DateTime endDate;

  Teacher({
    required this.id,
    required this.userId,
    required this.employedDate,
    required this.endDate,
  });

  static Future<List<Section>> activeSections() async {
    final results = await db.execute(teacherActiveSectionsSql);
    return results.map(Section.fromRow).toList(growable: false);
  }

  static Future<List<SubjectYear>> activeSubjects() async {
    final results = await db.execute(teacherActiveSubjectsSql);
    return results.map(SubjectYear.fromRow).toList(growable: false);
  }
}
