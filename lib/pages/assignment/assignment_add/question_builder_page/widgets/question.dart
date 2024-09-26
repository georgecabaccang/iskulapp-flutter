import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final TextEditingController questionController;

  // Constructor
  const Question({
    super.key,
    required this.questionController,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: TextFormField(
        controller: questionController,
        decoration: const InputDecoration(
          labelText: 'Question',
          floatingLabelBehavior: FloatingLabelBehavior.always,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.grey),
          ),
        ),
      ),
    );
  }
}
