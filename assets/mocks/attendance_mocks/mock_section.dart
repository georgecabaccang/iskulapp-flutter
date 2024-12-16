class MockSection {
    final int id;
    final String name;
    final List<int> studentIds;

    MockSection({required this.id, required this.name, required this.studentIds});

    factory MockSection.fromJson(Map<String, dynamic> json) {
        return MockSection(
            id: json['id'], 
            name: json['name'], 
            studentIds: json['students']
        );
    }
}