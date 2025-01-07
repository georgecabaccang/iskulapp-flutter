import 'package:school_erp/interfaces/display_values.dart';

class MockStudent implements EntityDisplayData {
    final String id;
    final String firstName;
    final String? secondName;
    final String? middleName;
    final String lastName;
    final String sectionId;

    MockStudent({
        required this.id, 
        required this.firstName,
        this.secondName,
        this.middleName, 
        required this.lastName, 
        required this.sectionId
    });

    factory MockStudent.fromJson(Map<String, dynamic> json) {
        return MockStudent(
            id: json['id'], 
            firstName: json['first_name'], 
            secondName: json['second_name'], 
            middleName: json['middle_name'], 
            lastName: json['last_name'],
            sectionId: json['section_id'], 
        );
    }

    @override
    String get value => id;

    @override
    String get displayName => "${lastName.toUpperCase()}, $firstName ${secondName ?? ''} ${middleName != null ? '${middleName![0].toUpperCase() }.' : ''}";


}