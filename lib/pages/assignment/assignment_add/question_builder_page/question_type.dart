enum QuestionType {
  multipleChoice('Multiple Choice'),
  trueFalse('True or False'),
  shortAnswer('Short Answer'),
  essay('Essay');

  final String displayName;

  const QuestionType(this.displayName);
}
