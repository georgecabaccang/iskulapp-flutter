import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/subject_year.dart';

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

  static Future<List<Section?>> sections() async {
    final results = await db.execute("""
    SELECT sections.*
    FROM teacher_sections
    LEFT JOIN sections ON sections.id = teacher_sections.section_id
    """);
    return results.map(Section.fromRow).toList(growable: false);
  }

  // on the assumption that only current academic year gets synced
  static Future<List<SubjectYear?>> activeSubjects() async {
    final results = await db.execute("""
    SELECT subject_years.*, subjects.name AS subject_name
    FROM teacher_subjects
    LEFT JOIN subject_years ON subject_years.id = teacher_subjects.subject_year_id
    LEFT JOIN subjects ON subjects.id = subject_years.subject_id
    """);
    return results.map(SubjectYear.fromRow).toList(growable: false);
  }

  /// gets subjects for teacher for current academic_year only
  /// based on the idea that ONLY his/her own data gets synced on teacher_subjects
  //static Future<List<Subject?>> activeSubjects() async {
  //  final results = await db.execute("""
  //  SELECT subjects.id, subjects.name
  //  FROM teacher_subjects
  //  LEFT JOIN subject_years ON subject_years.id = teacher_subjects.subject_year_id
  //  LEFT JOIN academic_years ON academic_years.id = subject_years.academic_year_id
  //  LEFT JOIN subjects ON subjects.id = subject_years.subject_id
  //  WHERE academic_years.id = (
  //      SELECT id
  //      FROM academic_years
  //      ORDER BY academic_years.end DESC LIMIT 1
  //  )
  //  """);
  //  return results.map(Subject.fromRow).toList(growable: false);
  //}
  //
}
