import 'package:flutter/material.dart';
import 'package:school_erp/enums/button_type.dart';
import 'package:school_erp/pages/common_widgets/forms/general_form/custom_form.dart';
import 'package:school_erp/pages/common_widgets/forms/inputs/form_long_input.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';
import 'package:school_erp/pages/common_widgets/forms/inputs/form_input.dart';

class LeaveApplicationForm extends StatelessWidget{
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

    LeaveApplicationForm({super.key});

    @override
    Widget build(BuildContext context) {
        final TextEditingController classTeacher = TextEditingController();
        final TextEditingController applicationTitle = TextEditingController();
        final TextEditingController description = TextEditingController();

        void handleSubmit() {
            if (_formKey.currentState!.validate() == false) {
                return;
            }

            print(classTeacher.text);
            print(applicationTitle.text);
            print(description.text);
        }

        final List<FormInput> textFields = [
            FormInput(
                textController: classTeacher, 
                labelText: "Class Teacher", 
                verticalMargin: 10, 
                errorMessage: "Class Teacher cannot be empty.",
            ),
            FormInput(
                textController: applicationTitle, 
                labelText: "Application Title", 
                verticalMargin: 10, 
                errorMessage: "Application Title cannot be empty."
            ),
            FormLongInput(
                textController: description, 
                labelText: "Description", 
                verticalMargin: 10, 
                errorMessage: "Description cannot be empty.", 
                maxLines: 5,
            ),
        ];

        final List<FormButton> formButtons = [
            FormButton(buttonLabel: "Send Request", buttonType: ButtonType.submit, buttonFn: handleSubmit,),
        ];

        return CustomForm(
            formKey: _formKey, 
            textFields: textFields, 
            formButtons: formButtons,
            horizontalPadding: 10,
            verticalPadding: 10,
        );
    }

}