enum AssessmentType {
  assignment('assignment', 'Assignment'),
  quiz('quiz', 'Quiz'),
  exam('exam', 'Exam');

  final String value;
  final String displayName;

  const AssessmentType(this.value, this.displayName);

  static AssessmentType fromString(String value) {
    return values.firstWhere(
      (v) => v.value == value,
      orElse: () => throw ArgumentError('Invalid AssessmentType value: $value'),
    );
  }

  static AssessmentType fromDisplayName(String displayName) {
    return values.firstWhere(
      (v) => v.displayName.toLowerCase() == displayName.toLowerCase(),
      orElse: () => throw ArgumentError(
          'Invalid AssessmentType display name: $displayName'),
    );
  }
}
