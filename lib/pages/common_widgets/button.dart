import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';


class AttendanceButton extends StatelessWidget {
  const AttendanceButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30.0),
      ),
      child: const Text(
        "ATTENDANCE",
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
