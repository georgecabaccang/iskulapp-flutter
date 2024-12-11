import 'package:flutter/material.dart';
import 'package:school_erp/enums/button_type.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/button_group/button_group.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';

class AssignmentAnswersFormButtons extends StatelessWidget{

    AssignmentAnswersFormButtons({super.key});

    final List<FormButton> buttons = [
        FormButton(buttonLabel: "Prev", buttonType: ButtonType.button),
        FormButton(buttonLabel: "Submit", buttonType: ButtonType.submit),
        FormButton(buttonLabel: "Next", buttonType: ButtonType.button),
    ];

    @override
    Widget build(BuildContext context) {
        return ButtonGroup(
            buttons: buttons, 
            alignment: ButtonGroupAlignment.center
        );
    }

}