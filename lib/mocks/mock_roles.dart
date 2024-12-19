import 'package:school_erp/interfaces/display_values.dart';

class MockRoles implements DisplayValues{
    final String id;
    final String role;

    MockRoles({required this.id, required this.role});

    factory MockRoles.fromJson(Map<String, dynamic> json) {
        return MockRoles(
            id: json['id'] ?? '', 
            role: json['role'] ?? ''
        );
    }

    @override
    String get value => throw UnimplementedError();

    @override
    String get displayName => role;
}