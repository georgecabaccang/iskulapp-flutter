import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/button_group/button_group.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';
import 'package:school_erp/pages/common_widgets/forms/inputs/form_input.dart';

// NOTE: If both formButtons and buttonGroup is passed, 
// formButtons will be proritized
class CustomForm  extends StatefulWidget{
    final GlobalKey<FormState> formKey;
    final List<FormInput> textFields;
    final List<FormButton>? formButtons;
    final List<FormButton>? buttonGroup;
    final double? horizontalPadding;
    final double? verticalPadding;
    final ButtonGroupAlignment? buttonGroupAlignment;

    const CustomForm({
        super.key, 
        required this.formKey, 
        required this.textFields,  
        this.horizontalPadding, 
        this.verticalPadding, 
        this.formButtons,
        this.buttonGroup,
        this.buttonGroupAlignment,

    });

    @override
    createState() => _CustomForm();
}

class _CustomForm extends State<CustomForm>{

    @override
    Widget build(BuildContext context) {

        Widget displayButtons;
        if (widget.formButtons != null) {
            displayButtons = Column(
                children: widget.formButtons!,
            );
        } else if (widget.buttonGroup != null) {
            displayButtons = ButtonGroup(
                buttons: widget.buttonGroup!, 
                alignment: widget.buttonGroupAlignment ?? ButtonGroupAlignment.center 
            );
        } else {
            displayButtons = SizedBox.shrink();
        }

        return Expanded(child: Form(key: widget.formKey, child: 
                Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: widget.horizontalPadding ?? 30, 
                        vertical: widget.verticalPadding ?? 10),
                    child:  Column(
                        children:[ 
                            ...widget.textFields, 
                            displayButtons
                        ]
                    )
                ),
            )
        );

    }
}
