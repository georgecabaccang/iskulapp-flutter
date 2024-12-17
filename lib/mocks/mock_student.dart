class MockStundet {
    final String id;
    final String firstName;
    final String lastName;
    final int sectionId;

    MockStundet({required this.id, required this.firstName, required this.lastName, required this.sectionId});

    factory MockStundet.fromJson(Map<String, dynamic> json) {
        return MockStundet(
            id: json['id'], 
            firstName: json['first_name'], 
            lastName: json['last_name'],
            sectionId: json['section_id'], 
        );
    }
}