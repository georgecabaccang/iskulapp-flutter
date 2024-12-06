import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/assessment_setup_page.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/helpers/mock_assignments_pagination.dart';
import 'package:school_erp/pages/common_widgets/app_bar_widgets/add_button.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/pagination.dart';
import 'widgets/assignment_card.dart';
import 'package:intl/intl.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  // Adjust number of rows to retreive on request
  final int _itemsPerPage = 10;
  bool _isLoading = false;

  // Assessment or assignment?
  // NOTE: use mock Assignment for now
  List<AssignmentPagination> assessments = [];
  // late StreamSubscription<List<Assessment>> _subscription;

  @override
  void initState() {
    super.initState();
    _loadAssignments();

    // _subscription = assessmentRepository
    //     .watchAssessmentList(AssessmentType.assignment)
    //     .listen((data) {
    //   if (!mounted) return;
    //   setState(() {
    //     _isLoading = false;
    //     _data = data;
    //   });
    // });
  }

  Future<void> _loadAssignments() async {
    setState(() {
      _isLoading = true;
    });

    // NOTE: Replace with actual request or implementation of data fetching
    List<AssignmentPagination> fetchedAssignments =
        await DummyAssignmentDatabasePagination().getFeeds();

    setState(() {
      _isLoading = false;
      assessments.addAll(fetchedAssignments);
    });
  }

  String formatDate(DateTime date) => DateFormat('dd MMM yy').format(date);

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(
      title: "Assignments Page",
      trailingWidget: AppBarAddButton(
        exitPage: widget,
        enterPage: const AssessmentSetupPage(
            assessmentTypeOnCreate: AssessmentType.assignment),
      ),
      content: [
        Pagination<AssignmentPagination>(
          listOfData: assessments,
          itemsPerPage: _itemsPerPage,
          isLoading: _isLoading,
          itemBuilder: (BuildContext context, AssignmentPagination assessment) {
            return AssignmentCard(assessment: assessment);
          },
        )
      ],
    );
  }
}
