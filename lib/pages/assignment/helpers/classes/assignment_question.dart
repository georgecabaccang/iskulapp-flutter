enum QuestionType  {
    multipleChoice,
    essay,
    shortAnswer,
    trueOrFalse;
}

class AssignmentQuestion {
    final QuestionType questionType;
    final String question;
    final List<String>? options;
    final String answer;
    final int points;

    AssignmentQuestion(
        this.questionType, 
        this.question, 
        this.options,
        this.answer, 
        this.points, 
    );
}