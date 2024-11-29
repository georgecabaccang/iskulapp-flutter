import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';

enum ButtonGroupAlignment { start, center, end;  
    String get value {
        switch (this) {
            case ButtonGroupAlignment.start:
                return 'start';
            case ButtonGroupAlignment.center:
                return 'center';
            case ButtonGroupAlignment.end:
                return 'end';
        }
    }
}


class ButtonGroup extends StatelessWidget{
    final List<FormButton> buttons;
    final ButtonGroupAlignment alignment;

    const ButtonGroup({super.key, required this.buttons, required this.alignment});

    @override
    Widget build(BuildContext context) {
        MainAxisAlignment buttonAlignment = MainAxisAlignment.start;
        switch (alignment) {
            case ButtonGroupAlignment.start:
                buttonAlignment = MainAxisAlignment.start;
                break;
            case ButtonGroupAlignment.center:
                buttonAlignment = MainAxisAlignment.center;
                break;
            case ButtonGroupAlignment.end:
                buttonAlignment = MainAxisAlignment.end;
                break;
        }

        return  Row(
            mainAxisAlignment: buttonAlignment,
            children: buttons.map((button) {
                    return Padding(
                        padding: const EdgeInsets.only(top: 4, bottom: 4, left: 4),
                        child: button,
                    );
                }).toList());

    }

}