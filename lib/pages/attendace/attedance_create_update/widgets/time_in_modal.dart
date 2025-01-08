import 'package:flutter/material.dart';
import 'package:school_erp/enums/attendance_status.dart';
import 'package:school_erp/features/attendance/cubit/attendance_check_cubit.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/models/attendance.dart';
import 'package:school_erp/pages/common_widgets/common_modal.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TimeInModal extends StatelessModal {
  final Attendance attendance;
  final int index;

  TimeInModal({
    required super.context,
    required this.index,
    required this.attendance,
  }) : super(
          title: 'Input Late Time',
          content: const SizedBox.shrink(),
        );

  @override
  void show() {
    _showTimePicker();
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: attendance.timeIn ?? TimeOfDay.now(),
    );

    if (pickedTime != null) {
      context.read<AttendanceCheckCubit>().createUpdateAttendance(
            index: index,
            attendance: attendance.copyWith(
              status: AttendanceStatus.late,
              timeIn: pickedTime,
              checkedBy: getTeacherId(context),
            ),
          );
    }
  }
}
