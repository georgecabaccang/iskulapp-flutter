import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/assessment_setup_page.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/helpers/mock_assignments.dart';
import 'package:school_erp/pages/common_widgets/app_bar_widgets/add_button.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/infinite_scroll_list_view_builder.dart';
import 'widgets/assignment_card.dart';
import 'package:intl/intl.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  // Adjust number of rows to retreive on request
  final int _countPerLoad = 10;
  bool _isLoading = false;
  int _currentOffset = 0;

  // Assessment or assignment?
  // NOTE: use mock Assignment for now
  List<Assignment> assessments = [];
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
    List<Assignment> fetchedAssignments =
        await DummyAssignmentDatabase().getFeeds(_currentOffset, _countPerLoad);

    setState(() {
      _isLoading = false;
      assessments.addAll(fetchedAssignments);

      if (fetchedAssignments.length < _countPerLoad) {
        _currentOffset += fetchedAssignments.length;
      } else {
        _currentOffset += _countPerLoad;
      }
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
        InfiniteScrollListView<Assignment>(
          currentOffset: _currentOffset,
          listOfData: assessments,
          isLoading: _isLoading,
          loadMoreData: _loadAssignments,
          itemBuilder: (BuildContext context, Assignment assessment) {
            return AssignmentCard(assessment: assessment);
          },
        ),
      ],
    );
  }
}
