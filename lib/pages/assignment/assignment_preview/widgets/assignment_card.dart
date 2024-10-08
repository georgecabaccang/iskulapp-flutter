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
  final Function onOptionSelected;
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

  Widget _buildOption(String optionText, int optionId, bool isCorrect) {
    bool isSelected = selectedOption == optionId;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: BoxDecoration(
        border: Border.all(color: isCorrect ? Colors.green : Colors.grey),
        borderRadius: BorderRadius.circular(12),
        color: isSelected
            ? Colors.green.withOpacity(0.2)
            : isCorrect
                ? Colors.green.withOpacity(0.1)
                : Colors.white,
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
              color: isSelected ? Colors.green : Colors.grey,
              width: 2,
            ),
            color: isSelected ? Colors.green : Colors.transparent,
          ),
          child: isSelected
              ? const Icon(
                  Icons.check,
                  color: Colors.white,
                  size: 24,
                )
              : null,
        ),
        onTap: () => onOptionSelected(optionId),
      ),
    );
  }

  Widget _buildQuestionContent() {
    switch (questionType) {
      case QuestionType.multipleChoice:
        return Column(
          children: question['answers']?.map<Widget>((option) {
                final isCorrect = option['is_correct'] == 1;
                return _buildOption(
                    option['text'] ?? 'No text', option['id'] ?? 0, isCorrect);
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
            _buildOption('True', 1, true),
            _buildOption('False', 2, false),
          ],
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 0.0),
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          border: Border.all(color: Colors.white),
        ),
        child: Column(
          children: [
            // Question area with limited space for scrolling
            Padding(
              padding:
                  const EdgeInsets.only(top: 30.0, left: 23.0, right: 23.0),
              child: ConstrainedBox(
                constraints: const BoxConstraints(
                  maxHeight: 160, // Limit height for question area
                ),
                child: SingleChildScrollView(
                  child: Align(
                    alignment:
                        Alignment.centerLeft, // Ensure text aligns to the left
                    child: Text(
                      question['q'] ?? 'No question available',
                      style: bodyStyle().copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign:
                          TextAlign.left, // Align text within the Text widget
                    ),
                  ),
                ),
              ),
            ),

            // Spacer to push the options to the center
            const Spacer(),

            Padding(
              padding: const EdgeInsets.only(top: 0.0, left: 23.0, right: 23.0),
              child: _buildQuestionContent(),
            ),
            // Spacer to push the options to the middle
            const Spacer(),

            // Bottom buttons (fixed at the bottom)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
              child: ElevatedButton(
                onPressed: () => onUpdatePressed(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: const BorderSide(color: Colors.black),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
                ),
                child: Text(
                  'Update',
                  style: buttonTextStyle().copyWith(color: Colors.black),
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
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.infinity, 50),
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
