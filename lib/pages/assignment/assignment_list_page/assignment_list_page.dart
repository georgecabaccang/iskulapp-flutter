import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_add/assignment_add_page/assignment_add_page.dart';
import 'widgets/assignment_card.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';

class AssignmentListPage extends StatefulWidget {
  const AssignmentListPage({super.key});

  @override
  _AssignmentListPageState createState() => _AssignmentListPageState();
}

class _AssignmentListPageState extends State<AssignmentListPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Assignment List',
            trailingWidget: IconButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AssignmentAddPage()),
                );
              },
              icon: const Icon(
                IconData(0xe74a, fontFamily: 'MaterialIcons'),
                color: AppColors.successColor,
                size: 28.0,
              ),
              iconSize: 28.0,
            ),
          ),
          AppContent(
            content: [
              Expanded(
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: const [
                    AssignmentCard(
                      subject: 'Mathematics',
                      title: 'Algebra 1',
                      assignDate: 'Dec 19, 2024 9:00pm',
                      lastSubmissionDate: 'Dec 19, 2024 11:59pm',
                      status: 'TO BE COMPLETED',
                      statusColor: AppColors.primaryColor,
                    ),
                    AssignmentCard(
                      subject: 'Science',
                      title: 'Structure of Atoms',
                      assignDate: '10 Oct 20',
                      lastSubmissionDate: '30 Oct 20',
                      status: 'TO BE SUBMITTED',
                      statusColor: AppColors.primaryColor,
                    ),
                    AssignmentCard(
                      subject: 'English',
                      title: 'My Bestfriend Essay',
                      assignDate: '10 Sep 20',
                      lastSubmissionDate: '30 Sep 20',
                      status: 'TO BE SUBMITTED',
                      statusColor: AppColors.primaryColor,
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
