import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_answers/widgets/answer_displays/answer_options_card.dart';
import 'package:school_erp/pages/assignment/helpers/classes/assignment_question.dart';
import 'package:school_erp/pages/common_widgets/lists/custom_list_view.dart';

class MultipleAnswersDisplay extends StatelessWidget{
    final List<Answers> answers;

    const MultipleAnswersDisplay({super.key, required this.answers});

    @override
    Widget build(BuildContext context) {
        return Expanded(
            child: 
            CustomListView(
                listOfData: answers,
                itemBuilder: (context, answer) => AnswerOptionsCard(answer: answer, selectedOption: answer.id)
            )
        );
    }
}