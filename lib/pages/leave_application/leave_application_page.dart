import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/leave_application/widgets/leave_application_form.dart';

class LeaveApplicationPage extends StatefulWidget {
    const LeaveApplicationPage({super.key});

    @override
    createState() => _LeaveApplicationPageState();
}

class _LeaveApplicationPageState extends State<LeaveApplicationPage> {

    @override
    Widget build(BuildContext context) {
        return DefaultLayout(
            title: "Leave Application", 
            content: [
                LeaveApplicationForm()
            ]
        );
    }
}
