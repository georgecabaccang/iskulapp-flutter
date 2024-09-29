import 'package:flutter/material.dart';
import 'action_button.dart';
import 'add_item_button.dart';

class ShortAnswerContent extends StatefulWidget {
  final TextEditingController questionController;
  const ShortAnswerContent({super.key, required this.questionController});

  @override
  _ShortAnswerContentState createState() => _ShortAnswerContentState();
}

class _ShortAnswerContentState extends State<ShortAnswerContent> {
  void _showAnswerDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => AnswerDialog(
        questionController: widget.questionController,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        ActionButton(onPressed: _showAnswerDialog, text: "Provide Answer"),
      ],
    );
  }
}

class AnswerDialog extends StatefulWidget {
  final TextEditingController questionController;

  const AnswerDialog({
    super.key,
    required this.questionController,
  });

  @override
  _AnswerDialogState createState() => _AnswerDialogState();
}

class _AnswerDialogState extends State<AnswerDialog> {
  late List<TextEditingController> _answerControllers;

  @override
  void initState() {
    super.initState();
    _answerControllers = [TextEditingController()];
  }

  @override
  void dispose() {
    for (var controller in _answerControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addAnswerField() {
    setState(() {
      _answerControllers.add(TextEditingController());
    });
  }

  void _removeAnswerField(int index) {
    if (_answerControllers.length > 1) {
      setState(() {
        _answerControllers[index].dispose();
        _answerControllers.removeAt(index);
      });
    }
  }

  void _clearAnswerField(int index) {
    setState(() {
      _answerControllers[index].clear();
    });
  }

  void _handleNextButtonPress(BuildContext context) {
    print(widget.questionController.text);
    for (int i = 0; i < _answerControllers.length; i++) {
      print('Answer ${i + 1}: ${_answerControllers[i].text}');
    }
    Navigator.of(context).pop();
    // TODO: add save logic + navigation
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Acceptable Answers"),
      content: SizedBox(
        width: double.maxFinite,
        child: ListView.builder(
          shrinkWrap: true,
          itemCount: _answerControllers.length,
          itemBuilder: (context, index) => AnswerField(
            controller: _answerControllers[index],
            index: index,
            onAddPressed: _addAnswerField,
            onRemovePressed: () => _removeAnswerField(index),
            onClearPressed: () => _clearAnswerField(index),
          ),
        ),
      ),
      actions: <Widget>[
        Center(
          child: ActionButton(
            onPressed: () => _handleNextButtonPress(context),
            text: "Next",
          ),
        ),
      ],
    );
  }
}

class AnswerField extends StatelessWidget {
  final TextEditingController controller;
  final int index;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;
  final VoidCallback onClearPressed;

  const AnswerField({
    super.key,
    required this.controller,
    required this.index,
    required this.onAddPressed,
    required this.onRemovePressed,
    required this.onClearPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: "Answer ${index + 1}",
                border: const OutlineInputBorder(),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: onClearPressed,
                ),
              ),
            ),
          ),
          const SizedBox(width: 8),
          AddItemButton(
            index: index,
            onAddPressed: onAddPressed,
            onRemovePressed: onRemovePressed,
          ),
        ],
      ),
    );
  }
}
