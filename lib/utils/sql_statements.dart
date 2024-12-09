// when writing queries dont depend on sync rule logic
// when sync rules are changed we still want our queries to return the same result

const defaultSqlConsoleQuery = """
  SELECT * FROM ps_crud
""";

// Teacher
const teacherAssessmentsSql = """
  SELECT assessments.*, subjects.name AS subject_name
  FROM assessments
  LEFT JOIN subject_years ON subject_years.id = assessments.subject_year_id
  LEFT JOIN subjects ON subjects.id = subject_years.subject_id
  LEFT JOIN academic_years ON academic_years.id = subject_years.academic_year_id
  WHERE prepared_by = ?
    AND assessment_type = ?
    AND academic_years.id = ?
  ORDER BY created_at DESC
""";

const teacherSubjectsSql = """
  SELECT 
  	subject_years.*, 
	subjects.name AS subject_name
  FROM teacher_subjects
  LEFT JOIN subject_years ON subject_years.id = teacher_subjects.subject_year_id
  LEFT JOIN subjects ON subjects.id = subject_years.subject_id
  LEFT JOIN academic_years ON academic_years.id = subject_years.academic_year_id
  WHERE teacher_subjects.teacher_id = ?
    AND academic_years.id = ?
""";

const teacherClassesSql = """
  SELECT subject_classes.*
  FROM subject_classes
  LEFT JOIN academic_years ON academic_years.id = subject_years.academic_year_id
  WHERE subject_classes.teacher_id = ?
    AND academic_years.id = ?
""";

const teacherSectionsBySubjectSql = """
  SELECT sections.*
  FROM sections
  LEFT JOIN subject_classes ON subject_classes.section_id = sections.id
  WHERE subject_classes.teacher_id = ?
    AND subject_classes.subject_year_id = ?
""";

const assessmentTakersSql = """
  SELECT assessment_takers.*, sections.name AS section_name
  FROM assessment_takers
  LEFT JOIN assessments ON assessments.id = assessment_takers.assessment_id
  LEFT JOIN sections ON sections.id = assessment_takers.section_id
  WHERE assessments.id = ?
""";

const sectionSql = """
  SELECT *
  FROM sections
  WHERE id = ?
""";

const subjectYearSql = """
  SELECT *
  FROM subject_years
  WHERE id = ?
""";
