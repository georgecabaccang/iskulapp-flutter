import 'package:school_erp/pages/attendance/attendance_calendar/helpers/enums/attendance_status.dart';

class AttendanceDetails {
    final String id;
    final String studentId;
    final String sectionId;
    final DateTime attendanceDate;
    final AttendanceStatus status;
    final String? timeIn;

    AttendanceDetails({
        required this.id, 
        required this.studentId, 
        required this.sectionId,
        required this.attendanceDate, 
        required this.status, 
        required this.timeIn
    });

    factory AttendanceDetails.fromJson(Map<String, dynamic> json) {
        return AttendanceDetails(
            id: json['id'], 
            studentId: json['student_id'], 
            sectionId: json['section_id'], 
            attendanceDate: DateTime.parse(json['attendance_date']), 
            status: AttendanceStatus.fromString(json['status']) ?? AttendanceStatus.absent, 
            timeIn: json['time_in'],
        );
    }
}

class ConvertedAttendanceDetails {
    final Map<DateTime, AttendanceDetails> dateDetails;

    ConvertedAttendanceDetails({required this.dateDetails});

    factory ConvertedAttendanceDetails.fromAttendanceList(List<AttendanceDetails>json) {
        Map<DateTime, AttendanceDetails> dateData = {};

        for (var attendanceDetails in json) {
            dateData[attendanceDetails.attendanceDate] = attendanceDetails;
        }

        return ConvertedAttendanceDetails(dateDetails: dateData);
    }
}