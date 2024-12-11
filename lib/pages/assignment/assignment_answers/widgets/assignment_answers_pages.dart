import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/helpers/classes/assignment_question.dart';
import 'package:school_erp/pages/assignment/assignment_answers/widgets/assignment_card.dart';

class AssignmentAnswersPages extends StatelessWidget {
    final List<AssignmentQuestion> questions;
    final PageController pageController;
    final void Function(int) onPageChanged;

    const AssignmentAnswersPages({
        super.key, 
        required this.questions,
        required this.pageController, 
        required this.onPageChanged, 
    });

    @override
    Widget build(BuildContext context) {
        return Expanded(
            child: PageView.builder(
                controller: pageController,
                itemCount: questions.length,  
                itemBuilder: (context, index) {
                    return AssignmentCard(questionDetails: questions[index]);
                },
                onPageChanged: (index) {
                    onPageChanged(index); 
                },
            ),
        );
    }
}