import 'package:school_erp/pages/attendance/attendance_calendar/helpers/enums/attendance_status.dart';

class AttendanceDetails {
    final String id;
    final String? studentId;
    final String? teacherId;
    final String sectionId;
    final DateTime attendanceDate;
    final AttendanceStatus status;
    final String? timeIn;

    AttendanceDetails({
        required this.id, 
        required this.studentId, 
        required this.teacherId, 
        required this.sectionId,
        required this.attendanceDate, 
        required this.status, 
        required this.timeIn
    });

    factory AttendanceDetails.fromJson(Map<String, dynamic> json) {
        return AttendanceDetails(
            id: json['id'], 
            studentId: json.containsKey('student_id') ? json['student_id'] : null, 
            teacherId: json.containsKey('teacher_id') ? json['teacher_id'] : null, 
            sectionId: json['section_id'], 
            // This is the way it is because of yyyy-mm-dd.
            // To have the same format as the Calendar pacakge does.
            attendanceDate: DateTime.utc(
                int.parse(json['attendance_date'].substring(0, 4)),
                int.parse(json['attendance_date'].substring(5, 7)),
                int.parse(json['attendance_date'].substring(8, 10)),
                0, 0, 0, 0, 0,
            ),
            status: AttendanceStatus.fromString(json['status']) ?? AttendanceStatus.absent, 
            timeIn: json['time_in'],
        );
    }
}

class ConvertedAttendanceDetails {
    final Map<DateTime, AttendanceDetails> dateDetails;

    ConvertedAttendanceDetails({required this.dateDetails});

    factory ConvertedAttendanceDetails.fromAttendanceList(List<AttendanceDetails> attendanceDetails) {
        Map<DateTime, AttendanceDetails> dateData = {};

        for (var detail in attendanceDetails) {
            dateData[detail.attendanceDate] = detail;
        }

        return ConvertedAttendanceDetails(dateDetails: dateData);
    }
}