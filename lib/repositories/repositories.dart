import 'package:school_erp/features/powersync/db.dart';
import 'package:school_erp/repositories/assessment_repository.dart';
import 'package:school_erp/repositories/assessment_taker_repository.dart';
import 'package:school_erp/repositories/sections_repository.dart';
import 'package:school_erp/repositories/subject_year_repository.dart';

// TODO: this is not ideal when used in services check potential DI solutions as this would be difficult to test,
// but maybe alright if only used when loading selections;
//
final assessmentRepository = AssessmentRepository(database: db);
final assessmentTakerRepository = AssessmentTakerRepository(database: db);
final sectionRepository = SectionRepository(database: db);
final subjectYearRepository = SubjectYearRepository(database: db);
