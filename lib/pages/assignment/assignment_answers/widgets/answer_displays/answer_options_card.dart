import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/helpers/classes/assignment_question.dart';
import 'package:school_erp/theme/text_styles.dart';

class AnswerOptionsCard extends StatelessWidget{
    final Answers answer;
    final int selectedOption; 

    const AnswerOptionsCard({
        super.key, 
        required this.answer, 
        required this.selectedOption,
    });

    @override
    Widget build(BuildContext context) {
        bool isSelected = selectedOption == answer.id;

        Color borderColor = answer.isCorrect
            ? Colors.green
            : (answer.isStudentAnswered ? Colors.red : Colors.grey);
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
                    answer.text,
                    style: bodyStyle().copyWith(
                        color: answer.isCorrect ? Colors.green : Colors.grey,
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
                            answer.isCorrect ? Icons.check : Icons.close,
                            color: Colors.white,
                            size: 24,
                        )
                        : (answer.isStudentAnswered && !answer.isCorrect)
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
}