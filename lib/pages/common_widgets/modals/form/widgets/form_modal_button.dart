import 'package:flutter/material.dart';
import 'package:school_erp/enums/button_type.dart';

class FormButton extends StatelessWidget {
  final String buttonLabel;
  final ButtonType buttonType;
  final void Function()? buttonFn;

  const FormButton(
      {super.key,
      required this.buttonLabel,
      required this.buttonType,
      this.buttonFn});

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        if (buttonType == ButtonType.submit && buttonFn != null) {
          buttonFn!();
        } else {
          Navigator.of(context).pop();
        }
      },
      child: Text(buttonLabel),
    );
  }
}
