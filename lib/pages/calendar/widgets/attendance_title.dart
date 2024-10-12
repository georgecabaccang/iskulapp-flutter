import 'package:flutter/material.dart';

class AttendanceTitle extends StatelessWidget {
  const AttendanceTitle({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
        'Attendance',
        style: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
        ),
    );
  }
}
