import 'package:flutter/material.dart';
import 'package:school_erp/pages/leave_application/widgets/leave_application_form.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';

class LeaveApplicationPage extends StatefulWidget {
    const LeaveApplicationPage({super.key});

    @override
    createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {

    @override
    Widget build(BuildContext context) {
        return Scaffold(
            backgroundColor: AppColors.primaryColor,
            body: Column(
                children: [
                    const CustomAppBar(
                        title: 'Leave Application',
                    ),
                    AppContent(
                        content: [
                            LeaveApplicationForm()
                        ],
                    ),
                ],
            ),
        );
    }
}
