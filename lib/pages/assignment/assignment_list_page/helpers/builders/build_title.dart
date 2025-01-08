import 'package:flutter/material.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/theme/text_styles.dart';

class BuildTitle extends StatelessWidget {
// change type to Assignment for now
  final Assessment assessment;

  const BuildTitle({super.key, required this.assessment});

  @override
  Widget build(BuildContext context) {
    return Text(assessment.title,
        style: headingStyle().copyWith(
            fontSize: 16.0, fontWeight: FontWeight.bold, color: Colors.black));
  }
}
