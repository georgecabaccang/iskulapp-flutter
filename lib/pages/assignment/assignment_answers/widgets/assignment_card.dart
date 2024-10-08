import 'package:flutter/material.dart';
import 'package:school_erp/theme/text_styles.dart';

enum QuestionType {
  multipleChoice,
  essay,
  shortAnswer,
  trueOrFalse,
}

class AssignmentCard extends StatelessWidget {
  final dynamic question;
  final int currentQuestionIndex;
  final int totalQuestions;
  final int? selectedOption;
  final Function(int) onOptionSelected;
  final Function onNextPressed;
  final Function onUpdatePressed;
  final QuestionType questionType;
  final bool isInteractionEnabled;

  const AssignmentCard({
    super.key,
    required this.question,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.onNextPressed,
    required this.onUpdatePressed,
    required this.questionType,
    this.isInteractionEnabled = true,
  });

  String _getAnswerStatus() {
    if (questionType == QuestionType.essay) {
      return 'Pending';
    }

    if (questionType == QuestionType.multipleChoice && selectedOption != null) {
      final selectedAnswer = question['answers']?.firstWhere(
        (option) => option['id'] == selectedOption,
        orElse: () => null,
      );

      if (selectedAnswer != null) {
        final isStudentAnswered = selectedAnswer['is_student_answered'] == 1;

        if (isStudentAnswered) {
          return selectedAnswer['is_correct'] == 1 ? 'Correct' : 'Incorrect';
        }
      }
    }

    return 'Wrong';
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Correct':
        return Colors.green;
      case 'Incorrect':
        return Colors.red;
      case 'Wrong':
        return Colors.red;
      case 'Pending':
        return Colors.orange;
      default:
        return Colors.transparent;
    }
  }

  Widget _buildOption(
      String optionText, int optionId, bool isCorrect, bool isStudentAnswered) {
    bool isSelected = selectedOption == optionId;

    Color borderColor = isCorrect
        ? Colors.green
        : (isStudentAnswered ? Colors.red : Colors.grey);
    Color backgroundColor = isSelected ? Colors.grey[200]! : Colors.white;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
      child: ListTile(
        title: Text(
          optionText,
          style: bodyStyle().copyWith(
            color: isCorrect ? Colors.green : Colors.grey,
          ),
        ),
        trailing: Container(
          width: 30,
          height: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: borderColor,
              width: 2,
            ),
            color: isSelected ? borderColor : Colors.transparent,
          ),
          child: isSelected
              ? Icon(
                  isCorrect ? Icons.check : Icons.close,
                  color: Colors.white,
                  size: 24,
                )
              : (isStudentAnswered && !isCorrect)
                  ? Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.red,
                      ),
                      child: const Icon(
                        Icons.close,
                        color: Colors.white,
                        size: 24,
                      ),
                    )
                  : null,
        ),
      ),
    );
  }

  Widget _buildQuestionContent() {
    switch (questionType) {
      case QuestionType.multipleChoice:
        return Column(
          children: question['answers']?.map<Widget>((option) {
                final isStudentAnswered = option['is_student_answered'] == 1;
                return _buildOption(
                    option['text'] ?? 'No text',
                    option['id'] ?? 0,
                    option['is_correct'] == 1,
                    isStudentAnswered);
              }).toList() ??
              [],
        );
      case QuestionType.essay:
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Text(question['answers']?.toString() ?? 'No answer available'),
        );
      case QuestionType.shortAnswer:
        return TextFormField(
          decoration: const InputDecoration(hintText: 'Type your answer here'),
        );
      case QuestionType.trueOrFalse:
        return Column(
          children: [
            _buildOption('True', 1, false, false),
            _buildOption('False', 2, false, false),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = _getAnswerStatus();
    final statusColor = _getStatusColor(status);

    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 21,
                        right: 39,
                        top: 11,
                        bottom: 24,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Questions ${currentQuestionIndex + 1}/$totalQuestions',
                            style: bodyStyle().copyWith(
                              fontSize: 34,
                              color: Colors.black,
                            ),
                          ),
                          Chip(
                            elevation: 0,
                            label: Text(
                              status,
                              style: bodyStyle()
                                  .copyWith(color: Colors.white, fontSize: 18),
                            ),
                            backgroundColor: statusColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                              side: const BorderSide(
                                color: Colors.transparent,
                                width: 3,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 32, right: 32),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(
                          maxHeight: 160,
                        ),
                        child: SingleChildScrollView(
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              question['q'] ?? 'No question available',
                              style: bodyStyle().copyWith(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(
                          top: 0.0, left: 28.0, right: 28.0, bottom: 28),
                      child: _buildQuestionContent(),
                    ),
                    const Spacer(),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: ElevatedButton(
                onPressed: () => onUpdatePressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.grey),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 0,
                ),
                child: Text(
                  'Update Correct Answer',
                  style: buttonTextStyle().copyWith(color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: ElevatedButton(
                onPressed: () => onNextPressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5278C1),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  minimumSize: const Size(double.infinity, 50),
                  elevation: 0,
                ),
                child: Text(
                  currentQuestionIndex < totalQuestions - 1 ? 'Next' : 'Submit',
                  style: buttonTextStyle().copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
