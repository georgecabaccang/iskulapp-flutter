import 'package:flutter/material.dart';
import '../question_type.dart';

class QuestionTypeSection extends StatelessWidget {
  final QuestionType questionType;
  final Function(QuestionType?) onQuestionTypeChanged;

  const QuestionTypeSection({
    super.key,
    required this.questionType,
    required this.onQuestionTypeChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Question 1', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          DropdownButtonFormField<QuestionType>(
            decoration: const InputDecoration(
              labelText: 'Question Type',
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
            ),
            value: questionType,
            items: QuestionType.values.map((QuestionType value) {
              return DropdownMenuItem<QuestionType>(
                value: value,
                child: Text(value.displayName),
              );
            }).toList(),
            onChanged: onQuestionTypeChanged,
            icon:
                const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}
