import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'widgets/close_button_widget.dart';
import 'widgets/student_list.dart';
import 'package:school_erp/theme/colors.dart';

class AssignmentCheckPage extends StatefulWidget {
  const AssignmentCheckPage({super.key});

  @override
  _AssignmentCheckPageState createState() => _AssignmentCheckPageState();
}

class _AssignmentCheckPageState extends State<AssignmentCheckPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: "Check Assignment",
        onBackPressed: () => Navigator.pop(context),
      ),
      body: Stack(
        children: [
          Container(
            color: AppColors.primaryColor, // Background remains the same
          ),
          Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              children: [
                Expanded(
                  child: StudentList(),
                ),
                const CloseButtonWidget(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
