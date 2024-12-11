import 'package:flutter/material.dart';
import 'package:school_erp/enums/button_type.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/button_group/button_group.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';

enum PageDirection {next, prev}

class AssignmentAnswersFormButtons extends StatelessWidget{
    final  Function() prevPageFn;
    final  Function() nextPageFn;

    const AssignmentAnswersFormButtons({
        super.key, 
        required this.prevPageFn, 
        required this.nextPageFn
    });

    @override
    Widget build(BuildContext context) {
        final List<FormButton> buttons = [
            FormButton(buttonLabel: "Prev", buttonType: ButtonType.button, buttonFn: () {prevPageFn();}),
            FormButton(buttonLabel: "Submit", buttonType: ButtonType.submit),
            FormButton(buttonLabel: "Next", buttonType: ButtonType.button, buttonFn: () {nextPageFn();}),
        ];

        return ButtonGroup(
            buttons: buttons, 
            alignment: ButtonGroupAlignment.center
        );
    }

}