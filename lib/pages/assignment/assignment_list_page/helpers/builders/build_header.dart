import 'package:flutter/material.dart';
import 'package:school_erp/models/assessment.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/helpers/status_colors/status_colors.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';

class BuildHeader extends StatelessWidget {
// change type to Assignment for now
  final Assessment assessment;
  final statusColors = StatusColors();

  BuildHeader({super.key, required this.assessment});

  @override
  Widget build(Object context) {
    return Row(
      children: [
        Expanded(
          child: Text(assessment.subjectName!.title(),
              style: headingStyle().copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 18.0,
                  color: Colors.black)),
        ),
        Container(
          padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8.0),
          decoration: BoxDecoration(
            color: statusColors.getStatusColor(assessment.status),
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Center(
            child: Text(
              assessment.status.displayName,
              style: TextStyle(
                color: statusColors.getStatusTextColor(assessment.status),
                fontWeight: FontWeight.bold,
                fontSize: 12.0,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
