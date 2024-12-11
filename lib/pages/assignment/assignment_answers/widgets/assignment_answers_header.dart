import 'package:flutter/material.dart';

class AssignmentAnswersHeader extends StatelessWidget {
    final int currentPageIndex;
    final int totalPages;

    const AssignmentAnswersHeader({
        super.key,
        required this.currentPageIndex,
        required this.totalPages,
    });

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
                children: [
                    Text("Testing"),
                    Text("${currentPageIndex + 1}/$totalPages"),  
                ],
            ),
        );
    }
}