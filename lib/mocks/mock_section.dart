class MockSections {
    final List<MockSection> mockSections;

    MockSections({required this.mockSections});

    factory MockSections.fromJson(List<dynamic> json) {
        List<MockSection> sections = json.map((sectionJson) {
                return MockSection.fromJson(sectionJson);
            }).toList();

        return MockSections(mockSections: sections);
    }
}

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