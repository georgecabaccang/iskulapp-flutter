import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/assignment/assignment_preview/widgets/assignment_card.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'package:dotted_line/dotted_line.dart'; // Ensure this path is correct

class AssignmentPreviewPage extends StatefulWidget {
  const AssignmentPreviewPage({super.key});

  @override
  _AssignmentPreviewPageState createState() => _AssignmentPreviewPageState();
}

class _AssignmentPreviewPageState extends State<AssignmentPreviewPage> {
  List<dynamic> questions = [];
  int currentQuestionIndex = 0;
  int? selectedOption;

  @override
  void initState() {
    super.initState();
    _loadQuestions();
  }

  Future<void> _loadQuestions() async {
    String jsonString = await rootBundle.loadString('assets/questions.json');
    final List<dynamic> jsonResponse = json.decode(jsonString);
    setState(() {
      questions = jsonResponse;
      // Automatically select the correct option for the first question
      if (questions.isNotEmpty && questions[0]['type'] == 'multi') {
        final correctOption = questions[0]['answers']
            .firstWhere((option) => option['is_correct'] == 1);
        selectedOption = correctOption['id'];
      }
    });
  }

  void _handleBackPress(BuildContext context) {
    Navigator.pop(context);
  }

  void _nextQuestion() {
    if (currentQuestionIndex < questions.length - 1) {
      setState(() {
        currentQuestionIndex++;
        // Automatically select the correct answer for the next question
        if (questions[currentQuestionIndex]['type'] == 'multi') {
          final correctOption = questions[currentQuestionIndex]['answers']
              .firstWhere((option) => option['is_correct'] == 1);
          selectedOption = correctOption['id'];
        } else {
          selectedOption = null;
        }
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

  QuestionType _getQuestionType(String type) {
    switch (type) {
      case 'multi':
        return QuestionType.multipleChoice;
      case 'essay':
        return QuestionType.essay;
      case 'short':
        return QuestionType.shortAnswer;
      case 'true_false':
        return QuestionType.trueOrFalse;
      default:
        return QuestionType.multipleChoice;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text("Assignment (Preview)",
            style: bodyStyle().copyWith(color: Colors.white, fontSize: 20.0)),
        backgroundColor: AppColors.primaryColor,
        actions: [
          TextButton(
            onPressed: () {
              // Action to skip preview
              Navigator.pop(context);
            },
            child: Text(
              'Skip Preview',
              style: bodyStyle().copyWith(color: Colors.white, fontSize: 20),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(color: AppColors.primaryColor),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 12.0, bottom: 12.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Questions ${currentQuestionIndex + 1}/${questions.length}',
                    style: bodyStyle()
                        .copyWith(color: Colors.white, fontSize: 34.0),
                  ),
                ),
              ),
              Container(
                width: 380,
                child: const DottedLine(
                  dashLength: 6.0,
                  lineThickness: 1.0,
                  dashColor: Colors.white,
                ),
              ),
              const SizedBox(height: 10),
              Expanded(
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 28.0),
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                          topRight: Radius.circular(30),
                        ),
                      ),
                      child: questions.isEmpty
                          ? const Center(child: CircularProgressIndicator())
                          : AssignmentCard(
                              question: questions[currentQuestionIndex],
                              currentQuestionIndex: currentQuestionIndex,
                              totalQuestions: questions.length,
                              selectedOption: selectedOption,
                              onOptionSelected: _onOptionSelected,
                              onNextPressed: _nextQuestion,
                              onUpdatePressed: _updateQuestion,
                              questionType: _getQuestionType(
                                  questions[currentQuestionIndex]['type']),
                              isInteractionEnabled: false,
                            ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
