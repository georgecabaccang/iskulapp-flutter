import 'package:flutter/material.dart';
import 'package:school_erp/theme/text_styles.dart';

class BuildDates extends StatelessWidget {
  // WAITING FOR DATA TO BE PASSED TO REPLACE HARD-CODED TEXTS

  @override
  Widget build(BuildContext context) {
    //TODO: if student / parent(?) show starTimedeadLine, if teacher dont
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Assign Date: ',
              style: bodyStyle().copyWith(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            Text(
              'startDate', //temporary
              style: headingStyle().copyWith(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
        const SizedBox(height: 9.8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Last Submission Date: ',
              style: bodyStyle().copyWith(
                color: Colors.grey,
                fontSize: 14.0,
              ),
            ),
            Text(
              'submissionDate', //temporary
              style: headingStyle().copyWith(
                color: Colors.black,
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
