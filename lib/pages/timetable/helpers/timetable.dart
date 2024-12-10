import 'package:school_erp/interfaces/string_values.dart';

enum DaysOfTheWeek implements StringValues {
    monday,
    tuesday,
    wednesday,
    thursday,
    friday,
    saturday;

    @override
      String get toStringValue {
        switch (this) {
            case DaysOfTheWeek.monday:
                return 'Monday';
            case DaysOfTheWeek.tuesday:
                return 'Tuesday';
            case DaysOfTheWeek.wednesday:
                return 'Wednesday';
            case DaysOfTheWeek.thursday:
                return 'Thursday';
            case DaysOfTheWeek.friday:
                return 'Friday';
            case DaysOfTheWeek.saturday:
                return 'Saturday';
        }
    }

    @override
      String get shortened {
        switch (this) {
            case DaysOfTheWeek.monday:
                return 'MON';
            case DaysOfTheWeek.tuesday:
                return 'TUE';
            case DaysOfTheWeek.wednesday:
                return 'WED';
            case DaysOfTheWeek.thursday:
                return 'THU';
            case DaysOfTheWeek.friday:
                return 'FRI';
            case DaysOfTheWeek.saturday:
                return 'SAT';
        }
    }
}

class ClassDetails {
    final String subject;
    final String time;
    final String teacher;
    final String period;

    ClassDetails({
        required this.subject,
        required this.time,
        required this.teacher,
        required this.period,
    });

    // Create a proper Map (or object for the JS pips) of class details
    //  from the json response.
    factory ClassDetails.fromJson(Map<String, dynamic> json) {
        return ClassDetails(
            subject: json['subject'] ?? '',
            time: json['time'] ?? '',
            teacher: json['teacher'] ?? '',
            period: json['period'] ?? '',
        );
    }
}

class Timetable {
    final Map<DaysOfTheWeek, List<ClassDetails>> data;

    Timetable({required this.data});

    // Create a proper Map (or object for the JS pips) of days and classes 
    // from the json response.

    /* OUTPUT
        {
          Monday: [
             {sub, teacher, time, etc}, 
             ...
          ],
          ...
        } 
    */
    factory Timetable.fromJson(Map<String, dynamic> json) {
        Map<DaysOfTheWeek, List<ClassDetails>> timetableData = {};

        json.forEach((key, value) {
                final day = _getDayFromString(key);
                if (day != null && value is List) {
                    timetableData[day] = List<ClassDetails>.from(
                        value.map((classJson) => ClassDetails.fromJson(classJson))
                    );
                }
            }
        );
        return Timetable(data: timetableData);
    }

    static DaysOfTheWeek? _getDayFromString(String day) {
        switch (day.toLowerCase()) {
            case 'monday':
                return DaysOfTheWeek.monday;
            case 'tuesday':
                return DaysOfTheWeek.tuesday;
            case 'wednesday':
                return DaysOfTheWeek.wednesday;
            case 'thursday':
                return DaysOfTheWeek.thursday;
            case 'friday':
                return DaysOfTheWeek.friday;
            case 'saturday':
                return DaysOfTheWeek.saturday;
            default:
            return null;
        }
    }
}