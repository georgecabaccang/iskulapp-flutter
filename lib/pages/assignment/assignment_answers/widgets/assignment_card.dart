import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_answers/widgets/answer_displays/multiple_answers_display.dart';
import 'package:school_erp/pages/assignment/helpers/classes/assignment_question.dart';
import 'package:school_erp/pages/common_widgets/cards/custom_item_card.dart';

class AssignmentCard extends StatelessWidget{
    final AssignmentQuestion questionDetails;

    const AssignmentCard({
        super.key, 
        required this.questionDetails
    });

    @override
    Widget build(BuildContext context) {
        return CustomItemCard(
            itemContents: [
                Text(questionDetails.question),
                MultipleAnswersDisplay(answers: questionDetails.answers)

            ]
        );
    }

}