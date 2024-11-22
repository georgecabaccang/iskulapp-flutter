import 'dart:async';
import 'package:flutter/material.dart';
import 'package:school_erp/enums/assessment_type.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_setup/assessment_setup_page.dart';
import 'package:school_erp/pages/common_widgets/app_bar_widgets/add_button.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/repositories/repositories.dart';
import 'widgets/assignment_card.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:intl/intl.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  _AssignmentListPageState createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  List<Assessment> _data = [];
  late StreamSubscription<List<Assessment>> _subscription;

  @override
  void initState() {
    super.initState();
    _subscription = assessmentRepository
        .watchAssessmentList(AssessmentType.assignment)
        .listen((data) {
      if (!mounted) return;
      setState(() => _data = data);
    });
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  String formatDate(DateTime date) => DateFormat('dd MMM yy').format(date);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Assignment List',
            trailingWidget: AppBarAddButton(
              exitPage: widget,
              enterPage: const AssessmentSetupPage(
                  assessmentTypeOnCreate: AssessmentType.assignment),
            ),
          ),
          AppContent(
            content: [
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.all(16.0),
                  itemCount: _data.length,
                  itemBuilder: (context, index) {
                    final assessment = _data[index];
                    return AssignmentCard(
                      assessment: assessment,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
