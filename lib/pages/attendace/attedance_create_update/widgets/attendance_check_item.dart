import 'package:school_erp/enums/attendance_status.dart';
import 'package:flutter/material.dart';
import 'package:school_erp/features/attendance/cubit/attendance_check_cubit.dart';
import 'package:school_erp/features/attendance/cubit/attendance_check_state.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/pages/attendace/attedance_create_update/widgets/time_in_modal.dart';
import 'package:school_erp/utils/time_utils/formatter.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AttendanceCheckItem extends StatelessWidget {
  final int index;
  const AttendanceCheckItem({
    required this.index,
    super.key,
  });

  void _showTimeInModal(BuildContext context) {
    var sa = context.read<AttendanceCheckCubit>().state.attendanceList[index];
    final modal = TimeInModal(
      context: context,
      index: index,
      attendance: sa.attendance,
    );
    modal.show();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AttendanceCheckCubit, AttendanceCheckState>(
      buildWhen: (previous, current) {
        return current.attendanceList[index] != previous.attendanceList[index];
      },
      builder: (context, state) {
        final sa = state.attendanceList[index];

        return Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                "${sa.student.lastName}, ${sa.student.firstName}",
                style: const TextStyle(fontSize: 14),
              ),
            ),
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Radio<AttendanceStatus>(
                    value: AttendanceStatus.late,
                    activeColor: Colors.orange,
                    groupValue: sa.attendance.status,
                    onChanged: (AttendanceStatus? value) {
                      _showTimeInModal(context);
                    },
                  ),
                  SizedBox(
                    width: 40,
                    child: Text(
                      sa.attendance.status == AttendanceStatus.late &&
                              sa.attendance.timeIn != null
                          ? formatTimeOfDay(sa.attendance.timeIn!)
                          : "",
                      style: const TextStyle(fontSize: 12),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Radio<AttendanceStatus>(
                  value: AttendanceStatus.absent,
                  activeColor: Colors.red,
                  groupValue: sa.attendance.status,
                  onChanged: (AttendanceStatus? value) {
                    context.read<AttendanceCheckCubit>().createUpdateAttendance(
                          index: index,
                          attendance: sa.attendance.copyWith(
                            status: value,
                            checkedBy: getTeacherId(context),
                          ),
                        );
                  },
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Radio<AttendanceStatus>(
                  value: AttendanceStatus.present,
                  activeColor: Colors.green,
                  groupValue: sa.attendance.status,
                  onChanged: (AttendanceStatus? value) {
                    context.read<AttendanceCheckCubit>().createUpdateAttendance(
                          index: index,
                          attendance: sa.attendance.copyWith(
                            status: value,
                            checkedBy: getTeacherId(context),
                          ),
                        );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
