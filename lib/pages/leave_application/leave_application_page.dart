import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/assignment/widgets/assignment_animation_manager.dart';
import 'package:school_erp/pages/leave_application/widgets/leave_application_card.dart';
import 'package:school_erp/pages/EnterExitRoute.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';

class LeaveApplicationPage extends StatefulWidget {
  const LeaveApplicationPage({super.key});

  @override
  _LeaveApplicationPageState createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage>
    with SingleTickerProviderStateMixin {

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Leave Application',
          ),
          AppContent(
            content: [
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                   LeaveApplicationCard(),
                ],
              )
            
            ],
          ),
        ],
      ),
    );
  }


}
