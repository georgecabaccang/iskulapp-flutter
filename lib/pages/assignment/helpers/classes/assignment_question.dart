// ignore_for_file: non_constant_identifier_names

enum QuestionType  {
    multipleChoice,
    essay,
    shortAnswer,
    trueOrFalse;
}

class AssignmentQuestion {
    final QuestionType type;  
    final String question;    
    final List<Answers> answers;    
    final int points;         

    AssignmentQuestion(this.type, this.question, this.answers, this.points);

    factory AssignmentQuestion.fromJson(Map<String, dynamic> json) {
        QuestionType questionType = _mapStringToQuestionType(json['type']);

        return AssignmentQuestion(
            questionType,
            json['question'] ?? '',  
            (json['answers'] as List).map((answerJson) => Answers.fromJson(answerJson)).toList(),
            json['points'] ?? 0,  
        );
    }

    static QuestionType _mapStringToQuestionType(String type) {
        switch (type) {
            case 'multipleChoice':
                return QuestionType.multipleChoice;
            case 'essay':
                return QuestionType.essay;
            case 'shortAnswer':
                return QuestionType.shortAnswer;
            case 'trueOrFalse':
                return QuestionType.trueOrFalse;
            default:
            return QuestionType.multipleChoice;
        }
    }
}

class Answers  {

    final String text;
    final int is_correct;
    final int is_student_answered;

    Answers(
        this.text, 
        this.is_correct, 
        this.is_student_answered
    ); 

    factory Answers.fromJson(Map<String, dynamic> json) {
        return Answers(
            json['text'] ?? '',  
            json['is_correct'] ?? 0,  
            json['is_student_answered'] ?? 0, 
        );
    }

    int get isCorrect => is_correct;
    int get isStudentAnswered => is_student_answered;
}