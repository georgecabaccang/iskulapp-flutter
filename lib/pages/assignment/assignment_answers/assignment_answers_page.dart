import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/helpers/classes/assignment_question.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/assignment/assignment_check_page/widgets/student_item.dart';
import 'widgets/assignment_card.dart';

class AssignmentAnswersPage extends StatefulWidget {
    // final Student student;

    const AssignmentAnswersPage({super.key, 
        // required this.student
    });

    @override
    createState() => _AssignmentAnswersPageState();
}

class _AssignmentAnswersPageState extends State<AssignmentAnswersPage> {
    List<AssignmentQuestion> questions = [];
    int currentQuestionIndex = 0;
    int? selectedOption;

    @override
    void initState() {
        super.initState();
        _loadQuestions();
    }

    Future<void> _loadQuestions() async {
        String jsonString = await rootBundle.loadString('assets/questions.json');
        List<dynamic> jsonResponse = json.decode(jsonString);
        List<AssignmentQuestion> assignmentQuestions = jsonResponse.map((item) {
                return AssignmentQuestion.fromJson(item);
            }).toList();

        setState(() {
                questions = assignmentQuestions;
            });
    }

    void _handleBackPress(BuildContext context) {
        Navigator.pop(context);
    }

    void _nextQuestion() {
        if (currentQuestionIndex < questions.length - 1) {
            setState(() {
                    // currentQuestionIndex++;
                    // // Automatically select the correct answer for the next question
                    // if (questions[currentQuestionIndex]['type'] == 'multi') {
                    //   final correctOption = questions[currentQuestionIndex]['answers']
                    //       .firstWhere((option) => option['is_correct'] == 1);
                    //   selectedOption = correctOption['id'];
                    // } else {
                    //   selectedOption = null;
                    // }
                });
        } else {
            _handleSubmit(context, questions[currentQuestionIndex]);
        }
    }

    void _handleSubmit(BuildContext context, dynamic question) {
        // Handle submission logic
    }

    void _updateQuestion() {
        // Handle update logic
    }

    void _onOptionSelected(int optionId) {
        setState(() {
                selectedOption = optionId;
            });
    }

    // QuestionType _getQuestionType(String type) {
    //   switch (type) {
    //     case 'multi':
    //       return QuestionType.multipleChoice;
    //     case 'essay':
    //       return QuestionType.essay;
    //     case 'short':
    //       return QuestionType.shortAnswer;
    //     case 'true_false':
    //       return QuestionType.trueOrFalse;
    //     default:
    //       return QuestionType.multipleChoice;
    //   }
    // }

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            // appBar: CustomAppBar(
            //   title: "${widget.student.name} Assignment Answers",
            //   onBackPressed: () => _handleBackPress(context),
            //   titleStyle: const TextStyle(color: Colors.white, fontSize: 18.0),
            //   trailingWidget: Text(
            //     'Section 1',
            //     style: bodyStyle().copyWith(color: Colors.white, fontSize: 16),
            //   ),
            // ),
            body: Stack(
                children: [
                    Container(color: AppColors.primaryColor),
                    Container(
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.0),
                                topRight: Radius.circular(30.0),
                            ),
                        ),
                        child: questions.isEmpty
                            ? const Center(child: CircularProgressIndicator())
                            : Column(
                            // children: [
                            //   Expanded(
                            //     // Make sure the AssignmentCard takes the full space
                            //     child: AssignmentCard(
                            //       question: questions[currentQuestionIndex],
                            //       currentQuestionIndex: currentQuestionIndex,
                            //       totalQuestions: questions.length,
                            //       selectedOption: selectedOption,
                            //       onOptionSelected: _onOptionSelected,
                            //       onNextPressed: _nextQuestion,
                            //       onUpdatePressed: _updateQuestion,
                            //       questionType: _getQuestionType(
                            //           questions[currentQuestionIndex]['type']),
                            //       isInteractionEnabled: false,
                            //     ),
                            //   ),
                            // ],
                            ),
                    ),
                ],
            ),
        );
    }
}
