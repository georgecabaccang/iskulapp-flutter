import 'package:school_erp/interfaces/display_values.dart';

class MockRoles {
    final List<MockRole> mockRoles;

    MockRoles({required this.mockRoles});

    factory MockRoles.fromJson(List<dynamic> json) {
        List<MockRole> roles = json.map((roleJson) {
                return MockRole.fromJson(roleJson);
            }).toList();

        return MockRoles(mockRoles: roles);
    }
}

class MockRole implements DisplayValues{
    final String id;
    final String role;

    MockRole({required this.id, required this.role});

    factory MockRole.fromJson(Map<String, dynamic> json) {
        return MockRole(
            id: json['id'] ?? '', 
            role: json['role'] ?? ''
        );
    }

    @override
    String get value => throw UnimplementedError();

    @override
    String get displayName => role;
}