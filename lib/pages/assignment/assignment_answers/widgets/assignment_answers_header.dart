import 'package:flutter/material.dart';

class AssignmentAnswersHeader extends StatelessWidget {
    const AssignmentAnswersHeader({super.key});

    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(vertical: 20),
            child: Row(
                children: [
                    Text("Testing"),
                    Text("1/10"), 
                ],
            ),
        );
    }
}