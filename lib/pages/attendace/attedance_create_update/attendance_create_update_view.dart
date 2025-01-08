import 'package:flutter/material.dart';
import 'package:school_erp/pages/attendace/attedance_create_update/attendance_create_update_form.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class AttendanceCreateUpdateView extends StatelessWidget {
  const AttendanceCreateUpdateView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(title: 'Check Attendance', content: [
      AttendanceCreateUpdateForm(),
    ]);
  }
}
