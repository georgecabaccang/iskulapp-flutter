import 'package:flutter/material.dart';
import 'package:school_erp/enums/button_type.dart';
import 'package:school_erp/theme/colors.dart';

class FormButton extends StatelessWidget {
    final String buttonLabel;
    final ButtonType buttonType;
    final void Function()? buttonFn;

    const FormButton({
        super.key,
        required this.buttonLabel,
        required this.buttonType,
        this.buttonFn,
    });

    @override
    Widget build(BuildContext context) {
        return TextButton(
            style: TextButton.styleFrom(
                backgroundColor: buttonType == ButtonType.submit
                    ? AppColors.primaryColor
                    : null,
                foregroundColor: buttonType == ButtonType.submit ? AppColors.primaryFontColor :
                    AppColors.primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8), 
                ),
            ),
            onPressed: () {
                if ((buttonType == ButtonType.submit || buttonType == ButtonType.button) && buttonFn != null) {
                    buttonFn!();
                } else {
                    Navigator.of(context).pop();
                }
            },
            child: Text(buttonLabel),
        );
    }
}