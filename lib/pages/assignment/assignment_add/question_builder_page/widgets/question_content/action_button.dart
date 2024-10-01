import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/default_button.dart';

class ActionButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;

  const ActionButton({
    super.key,
    required this.onPressed,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(5.0),
          child: DefaultButton(
            onPressed: onPressed,
            text: text,
          ),
        ),
      ],
    );
  }
}
