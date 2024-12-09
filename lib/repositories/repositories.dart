import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/repositories/assessment_repository.dart';
import 'package:school_erp/repositories/assessment_taker_repository.dart';
import 'package:school_erp/repositories/sections_repository.dart';
import 'package:school_erp/repositories/subject_year_repository.dart';

final assessmentRepository = AssessmentRepository(database: db);
final assessmentTakerRepository = AssessmentTakerRepository(database: db);
final sectionRepository = SectionRepository(database: db);
final subjectYearRepository = SubjectYearRepository(database: db);
