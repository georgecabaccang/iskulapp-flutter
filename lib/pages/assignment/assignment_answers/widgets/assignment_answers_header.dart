import 'package:flutter/material.dart';

class AssignmentAnswersHeader extends StatelessWidget {
    final int currentPageIndex;
    final int totalPages;
    final double fontSize;

    const AssignmentAnswersHeader({
        super.key,
        required this.currentPageIndex,
        required this.totalPages, 
        this.fontSize = 18,
    });

    @override
    Widget build(BuildContext context) {

        Widget buildText(String text) {
            return Text(text, 
                style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold ),
            );
        }

        return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround, 
                children: [
                    buildText("Question"), 
                    buildText("${currentPageIndex + 1} of $totalPages")
                ],
            ),
        );
    }
}