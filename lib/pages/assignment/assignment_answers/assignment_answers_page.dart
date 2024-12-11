import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_answers/widgets/assignment_answers_form_buttons.dart';
import 'package:school_erp/pages/assignment/assignment_answers/widgets/assignment_answers_header.dart';
import 'package:school_erp/pages/assignment/assignment_answers/widgets/assignment_answers_pages.dart';
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
    final PageController _pageController = PageController();
    List<AssignmentQuestion> questions = [];
    int currentPage = 0;
    bool _isLoading = true;
    bool _isAnimating = false;
    int animationDuration = 300;

    @override
    void initState() {
        super.initState();
        _loadQuestions();
    }

    @override
    void dispose() {
        _pageController.dispose();
        super.dispose();
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

    void handlePageChange(PageDirection direction) {
        if (_isAnimating) return; 

        setState(() {
                _isAnimating = true;
            }
        );

        setState(() {
                if (direction == PageDirection.prev && currentPage > 0) {
                    currentPage -= 1;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                            _pageController.previousPage(
                                duration: Duration(milliseconds: animationDuration),
                                curve: Curves.easeInOut,
                            );
                        }
                    );
                } else if (direction == PageDirection.next && currentPage < questions.length - 1) {
                    currentPage += 1;
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                            _pageController.nextPage(
                                duration: Duration(milliseconds: animationDuration),
                                curve: Curves.easeInOut,
                            );
                        }
                    );
                }
            }
        );

        // To avoid changing state while animation is happening
        Future.delayed(Duration(milliseconds: animationDuration), () {
                setState(() {
                        _isAnimating = false;
                    }
                );
            }
        );
    }

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Assignment Answers",
            content: [
                AssignmentAnswersHeader(
                    currentPageIndex: currentPage,
                    totalPages: questions.length,
                ),
                AssignmentAnswersPages(
                    pageController: _pageController,
                    questions: questions,
                    onPageChanged: (page) {
                        setState(() {
                                currentPage = page;
                            }
                        );
                    },
                ),
                AssignmentAnswersFormButtons(
                    prevPageFn: () => handlePageChange(PageDirection.prev),
                    nextPageFn: () => handlePageChange(PageDirection.next),
                ),
            ],
        );
    }
}