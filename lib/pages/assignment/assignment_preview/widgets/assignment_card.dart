// File: pages/assignments/assignment_preview/widgets/assignment_card.dart
import 'package:flutter/material.dart';

class AssignmentCard extends StatelessWidget {
  final dynamic question;
  final int currentQuestionIndex;
  final int totalQuestions;
  final int? selectedOption;
  final Function onOptionSelected;
  final Function onNextPressed;
  final Function onUpdatePressed;

  const AssignmentCard({
    Key? key,
    required this.question,
    required this.currentQuestionIndex,
    required this.totalQuestions,
    required this.selectedOption,
    required this.onOptionSelected,
    required this.onNextPressed,
    required this.onUpdatePressed,
  }) : super(key: key);

  Widget _buildOption(String optionText, int optionId, bool isCorrect) {
    bool isSelected =
        selectedOption == optionId; // Check if this option is selected

    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
        border: Border.all(color: isCorrect ? Colors.green : Colors.grey),
        borderRadius: BorderRadius.circular(12),
        color: isSelected ? Colors.grey[200] : Colors.white,
      ),
      child: ListTile(
        title: Text(
          optionText,
          style: TextStyle(color: isCorrect ? Colors.green : Colors.grey),
        ),
        leading: Radio<int>(
          value: optionId,
          groupValue: selectedOption,
          onChanged: (value) => onOptionSelected(optionId),
          activeColor: Colors.green,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question['q'] ?? 'No question available',
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 16),
                  if (question['type'] == 'multi') ...[
                    Column(
                      children: question['answers']?.map<Widget>((option) {
                            final isCorrect = option['is_correct'] == 1;
                            return _buildOption(option['text'] ?? 'No text',
                                option['id'] ?? 0, isCorrect);
                          }).toList() ??
                          [],
                    ),
                  ] else if (question['type'] == 'essay') ...[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      child: Text(question['answers']?.toString() ??
                          'No answer available'),
                    ),
                  ],
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 0),
            child: ElevatedButton(
              onPressed: () => onUpdatePressed(),
              child:
                  const Text('Update', style: TextStyle(color: Colors.black)),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                side: const BorderSide(color: Colors.black),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
            child: ElevatedButton(
              onPressed: () => onNextPressed(),
              child: Text(
                currentQuestionIndex < totalQuestions - 1 ? 'Next' : 'Submit',
                style: const TextStyle(color: Colors.white),
              ),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5278C1),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                minimumSize: const Size(double.infinity, 50),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
