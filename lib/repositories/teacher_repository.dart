import 'package:powersync/powersync.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/models/subject_class.dart';
import 'package:school_erp/models/subject_year.dart';
import 'package:school_erp/utils/sql_statements.dart';

class TeacherRepository {
  PowerSyncDatabase database;
  TeacherRepository({PowerSyncDatabase? database}) : database = database ?? db;

  Future<List<SubjectYear>> getSubjects({
    required String teacherId,
    required String academicYearId,
  }) async {
    final results = await db.execute(
      teacherSubjectsSql,
      [teacherId, academicYearId],
    );
    return results.map(SubjectYear.fromRow).toList(growable: false);
  }

  Future<List<SubjectClass>> getClasses({
    required String teacherId,
    required String academicYearId,
  }) async {
    final results = await db.execute(
      teacherClassesSql,
      [teacherId, academicYearId],
    );
    return results.map(SubjectClass.fromRow).toList(growable: false);
  }

  Future<List<Section>> getSectionsBySubject({
    required String teacherId,
    required String subjectYearId,
  }) async {
    final results = await db.execute(
      teacherSectionsBySubjectSql,
      [teacherId, subjectYearId],
    );
    return results.map(Section.fromRow).toList(growable: false);
  }

  Future<List<Assessment>> getAssessments({
    required String teacherId,
    required AssessmentType assessmentType,
    required String academicYearId,
  }) async {
    final results = await db.execute(
      teacherAssessmentsSql,
      [teacherId, assessmentType.value, academicYearId],
    );
    return results.map(Assessment.fromRow).toList(growable: false);
  }
}
