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
    Key? key,
    required this.question,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.onNextPressed,
    required this.onUpdatePressed,
    required this.questionType,
    this.isInteractionEnabled = true,
  }) : super(key: key);

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

    Color backgroundColor;

    if (isSelected) {
      // If selected, use a light version of the border color
      backgroundColor = borderColor.withOpacity(0.2);
    } else if (!isCorrect && isStudentAnswered) {
      // If incorrect and answered by the student, use a red background
      backgroundColor = Colors.red.withOpacity(0.2);
    } else {
      // Default white background
      backgroundColor = Colors.white;
    }

    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
      child: ListTile(
        title: Row(
          children: [
            Expanded(
              child: Text(
                optionText,
                style: bodyStyle().copyWith(
                  color: isCorrect
                      ? Colors.green
                      : isStudentAnswered
                          ? Colors.red
                          : Colors.grey,
                ),
              ),
            ),
            if (isStudentAnswered && !isCorrect)
              const Icon(
                Icons.close,
                color: Colors.red,
              ),
            if (isCorrect)
              const Icon(
                Icons.check,
                color: Colors.green,
              ),
          ],
        ),
        leading: Radio<int>(
          value: optionId,
          groupValue: isStudentAnswered ? optionId : null,
          onChanged: isInteractionEnabled
              ? (value) => onOptionSelected(optionId)
              : null,
          activeColor: borderColor,
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
      // Ensure the Card takes the full width of the screen
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
                padding: const EdgeInsets.only(
                    top: 0.0, left: 10, right: 10, bottom: 0),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Questions ${currentQuestionIndex + 1}/$totalQuestions',
                          style: headingStyle().copyWith(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        Chip(
                          elevation: 0,
                          label: Text(
                            status,
                            style: bodyStyle().copyWith(color: Colors.white),
                          ),
                          backgroundColor: statusColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                            side: const BorderSide(
                              color: Colors.transparent,
                              width: 0,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Text(
                      question['q'] ?? 'No question available',
                      style: bodyStyle().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 16),
                    _buildQuestionContent(),
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
