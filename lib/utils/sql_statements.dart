// GENERAL
//
// TODO: IMPORTANT temporary academic years query where academic_years.id = 4
const assessmentsSql = """
  SELECT assessments.*, subjects.name AS subject_name
  FROM assessments
  LEFT JOIN subject_years ON subject_years.id = assessments.subject_year_id
  LEFT JOIN subjects ON subjects.id = subject_years.subject_id
  LEFT JOIN academic_years ON academic_years.id = subject_years.academic_year_id
  WHERE assessment_type = ? AND academic_years.id = 4
  ORDER BY created_at DESC
""";

// TEACHER
// on the assumption that only the current academic year gets synced
const teacherActiveSubjectsSql = """
  SELECT subject_years.*, subjects.name AS subject_name
  FROM teacher_subjects
  LEFT JOIN subject_years ON subject_years.id = teacher_subjects.subject_year_id
  LEFT JOIN subjects ON subjects.id = subject_years.subject_id
""";

const teacherActiveSectionsSql = """
  SELECT sections.*
  FROM teacher_sections
  LEFT JOIN sections ON sections.id = teacher_sections.section_id
""";

const defaultSqlConsoleQuery = """
  SELECT * FROM ps_crud
""";

/// general model queries
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
