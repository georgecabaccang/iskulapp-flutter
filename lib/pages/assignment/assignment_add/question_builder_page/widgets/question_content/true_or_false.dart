import 'package:flutter/material.dart';
import 'action_button.dart';

class TrueFalseContent extends StatefulWidget {
  final TextEditingController questionController;
  const TrueFalseContent({super.key, required this.questionController});

  @override
  _TrueFalseContentState createState() => _TrueFalseContentState();
}

class _TrueFalseContentState extends State<TrueFalseContent> {
  String? _selectedAnswer;

  void _showAnswerDialog() {
    // The fixed true/false options
    List<String> trueFalseChoices = ['True', 'False'];

    _selectedAnswer = trueFalseChoices.first;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              content: DropdownButtonFormField<String>(
                decoration: const InputDecoration(
                  labelText: "Answer",
                  enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.grey),
                  ),
                ),
                value: _selectedAnswer,
                icon: const Icon(Icons.arrow_drop_down),
                isExpanded: true,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      _selectedAnswer = newValue;
                    });
                  }
                },
                items: trueFalseChoices
                    .map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
              actions: <Widget>[
                Center(
                  child: ActionButton(
                    onPressed: () {
                      // TODO: Implement saving logic and navigation
                    },
                    text: "Next",
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        ActionButton(onPressed: _showAnswerDialog, text: "Next"),
      ],
    );
  }
}
