import 'package:school_erp/pages/attendance/attendance_calendar/helpers/classes/date_details.dart';

class MockStundet {
    final int id;
    final String firstName;
    final String lastName;
    final int sectionId;
    final Map<DateTime, DateDetails> attendance;

    MockStundet({required this.id, required this.firstName, required this.lastName, required this.sectionId, required this.attendance});

    factory MockStundet.fromJson(Map<String, dynamic> json) {
        return MockStundet(
            id: json['id'], 
            firstName: json['first_name'], 
            lastName: json['last_name'],
            sectionId: json['section_id'], 
            attendance: Date.fromJson(json['attendance']).date,
        );
    }



}