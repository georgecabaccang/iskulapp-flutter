import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_answers/widgets/assignment_answers_form_buttons.dart';
import 'package:school_erp/pages/assignment/assignment_answers/widgets/assignment_answers_header.dart';
import 'package:school_erp/pages/assignment/assignment_answers/widgets/assignment_card.dart';
import 'package:school_erp/pages/assignment/helpers/classes/assignment_question.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

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
    bool _isLoading = true;

    @override
    void initState() {
        super.initState();
        _loadQuestions();
    }

    Future<void> _loadQuestions() async {
        try {
            if (!mounted) return;

            setState(() {
                    _isLoading = true;
                }
            );

            String jsonString = await rootBundle.loadString('assets/questions.json');
            List<dynamic> jsonResponse = json.decode(jsonString);
            List<AssignmentQuestion> assignmentQuestions = jsonResponse.map((item) {
                    return AssignmentQuestion.fromJson(item);
                }
            ).toList();

            if (assignmentQuestions.isNotEmpty) {
                setState(() {
                        questions = assignmentQuestions;
                    }
                );
            }

            setState(() {
                    _isLoading = false;
                }
            );
        } 
        // Handler errors better when real data is being retrieved
        catch (error) {
            if (!mounted) return;
            setState(() {
                    _isLoading = false;
                }
            );
        }
    }

    // void _handleBackPress(BuildContext context) {
    //     Navigator.pop(context);
    // }

    // void _nextQuestion() {
    //     if (currentQuestionIndex < questions.length - 1) {
    //         setState(() {
    //                 // currentQuestionIndex++;
    //                 // // Automatically select the correct answer for the next question
    //                 // if (questions[currentQuestionIndex]['type'] == 'multi') {
    //                 //   final correctOption = questions[currentQuestionIndex]['answers']
    //                 //       .firstWhere((option) => option['is_correct'] == 1);
    //                 //   selectedOption = correctOption['id'];
    //                 // } else {
    //                 //   selectedOption = null;
    //                 // }
    //             });
    //     } else {
    //         _handleSubmit(context, questions[currentQuestionIndex]);
    //     }
    // }

    // void _handleSubmit(BuildContext context, dynamic question) {
    //     // Handle submission logic
    // }

    // void _updateQuestion() {
    //     // Handle update logic
    // }

    // void _onOptionSelected(int optionId) {
    //     setState(() {
    //             selectedOption = optionId;
    //         });
    // }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Assignment Answers", 
            content: [
                AssignmentAnswersHeader(), 
                AssignmentCard(questionDetails: questions[0]),
                AssignmentAnswersFormButtons()
            ]);
    }
}
