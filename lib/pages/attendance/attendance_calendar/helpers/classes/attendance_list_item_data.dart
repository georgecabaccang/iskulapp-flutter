import 'package:school_erp/enums/attendance_status.dart';
import 'package:school_erp/models/student.dart';
import 'package:school_erp/models/attendance.dart';

class AttendanceListItemData {
    final Student student;
    final int totalPresent;
    final int totalLate;
    final int totalAbsent;
    final int totalLeave;

    AttendanceListItemData({
        required this.student,
        required this.totalPresent,
        required this.totalLate,
        required this.totalAbsent,
        required this.totalLeave
    });

    factory AttendanceListItemData.generateData(Student student, List<Attendance> attendanceList, int range) {
        int present = 0;
        int late = 0;
        int absent = 0;
        int leave = 0;

        bool isRangeReached() {
            return present + late + absent + leave == range;
        }

        (() {
            for (var attendance in attendanceList) {
                if (isRangeReached()) break;
                if (attendance.studentId == student.id) {
                    if (attendance.status == AttendanceStatus.present) present++;
                    if (attendance.status == AttendanceStatus.late) late++; 
                    if (attendance.status == AttendanceStatus.absent) absent++; 
                    if (attendance.status == AttendanceStatus.authorizedAbsence) leave++; 
                }
            }
        })();

        return AttendanceListItemData(
            student: student,
            totalPresent: present,
            totalLate: late,
            totalAbsent: absent,
            totalLeave: leave,
        );

    }
}