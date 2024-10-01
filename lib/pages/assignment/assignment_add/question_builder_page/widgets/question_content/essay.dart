import 'package:flutter/material.dart';
import 'action_button.dart';

class EssayContent extends StatefulWidget {
  final TextEditingController questionController;
  const EssayContent({super.key, required this.questionController});

  @override
  _EssayContentState createState() => _EssayContentState();
}

class _EssayContentState extends State<EssayContent> {
  final TextEditingController _scoreController = TextEditingController();

  @override
  void dispose() {
    _scoreController.dispose();
    super.dispose();
  }

  void _onNextPressed() {
    final score = _scoreController.text;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // TextFormField for score input
        TextFormField(
          controller: _scoreController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Score',
            floatingLabelBehavior: FloatingLabelBehavior.always,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
          ),
        ),
        const SizedBox(height: 20),
        // Note under the TextFormField
        RichText(
          text: const TextSpan(
            children: [
              TextSpan(
                text: "* ",
                style: TextStyle(
                  color: Colors.red,
                  fontSize: 12,
                ),
              ),
              TextSpan(
                text:
                    "Essays are to be checked manually by the examiner.", // Rest of the text
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ],
          ),
        ),
        const Spacer(),
        // Submit button at the bottom
        Center(
          child: ActionButton(
            onPressed: _onNextPressed,
            text: "Next",
          ),
        ),
      ],
    );
  }
}
