import 'package:flutter/services.dart';
import 'package:school_erp/mocks/mock_roles.dart';
import 'package:school_erp/mocks/mock_section.dart';
import 'dart:convert';

class AttendanceCalendarServices {
    Future<Map<String, dynamic>> loadSectionsAndRoles() async {
        try {
            final String responseSections = await rootBundle.loadString('assets/mocks/attendance_mocks/sections.json');
            final String responseRoles = await rootBundle.loadString('assets/mocks/attendance_mocks/roles.json');

            if (responseSections.isEmpty || responseRoles.isEmpty) {
                throw Exception("Failed to load sections or roles.");
            }

            final sections = MockSections.fromJson(json.decode(responseSections)).mockSections;
            final roles = MockRoles.fromJson(json.decode(responseRoles)).mockRoles;

            return {'sections': sections, 'roles': roles};
        } catch (error) {
            rethrow;
        }
    }

}