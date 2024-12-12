import 'package:school_erp/interfaces/display_values.dart';

enum DaysOfTheWeek implements DisplayValues{
    monday("Monday", "MON"),
    tuesday("Tuesday", "TUE"),
    wednesday("Wednesday", "WED"),
    thursday("Thursday", "THU"),
    friday("Friday", "FRI"),
    saturday("Saturday", "SAT");

    @override
    final String value;
    @override
    final String displayName;

    const DaysOfTheWeek(this.value, this.displayName);

    static DaysOfTheWeek? getDayFromString(String day) {
        // Opted for a try-catch block here instead of throwing an exception.
        // Just to ignore the (if ever) invalid day from database.
        try {
            return DaysOfTheWeek.values.firstWhere(
                (d) => d.value.toLowerCase() == day.toLowerCase(),
            );
        } catch (error) {
            return null;
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
                final day = DaysOfTheWeek.getDayFromString(key);
                if (day != null && value is List) {
                    timetableData[day] = List<ClassDetails>.from(
                        value.map((classJson) => ClassDetails.fromJson(classJson))
                    );
                }
            }
        );
        return Timetable(data: timetableData);
    }


}