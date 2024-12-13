import 'package:school_erp/pages/attendance/attendance_calendar/helpers/enums/attendance_status.dart';

class Date {
    final Map<DateTime, DateDetails> date;

    Date({
        required this.date
    });

    factory Date.fromJson(Map<String, dynamic> json) {
        Map<DateTime, DateDetails> dateData = {};

        json.forEach((key, value) {
                dateData[DateTime.parse(key)] = DateDetails.fromJson(value);
            }
        );
        return Date(date: dateData);
    }
}

class DateDetails {
    final AttendanceStatus attendanceStatus;
    final String? lateTime;

    DateDetails({
        required this.attendanceStatus, 
        required this.lateTime
    });

    factory DateDetails.fromJson(Map<String, dynamic> json) {
        return DateDetails(
            attendanceStatus: AttendanceStatus.fromString(json['attendanceStatus']) ?? AttendanceStatus.absent,
            lateTime: json['lateTime'] ?? '',
        );
    }
}