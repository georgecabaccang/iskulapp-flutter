import 'package:flutter/material.dart';
import 'package:school_erp/enums/button_type.dart';
import 'package:school_erp/pages/common_widgets/forms/modal_form/modal_form.dart';
import 'package:school_erp/pages/common_widgets/forms/buttons/form_button.dart';
import 'package:school_erp/pages/common_widgets/forms/inputs/form_input.dart';

class FeedsModalForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  FeedsModalForm({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController firstInput = TextEditingController();

    void handleSubmit() {
      // Replace with proper logic in the hinaharap, testing lang muna
      if (_formKey.currentState!.validate() == false) {
        return;
      }

      print(firstInput.text);
      Navigator.of(context).pop();
    }

    final List<FormInput> textFields = [
      FormInput(
        labelText: "First Input",
        textController: firstInput,
        errorMessage: "Cannot post an empty post.",
      ),
    ];

    final List<FormButton> formButtons = [
      FormButton(buttonLabel: "Cancel", buttonType: ButtonType.cancel),
      FormButton(
          buttonLabel: "Post",
          buttonType: ButtonType.submit,
          buttonFn: handleSubmit)
    ];

    return FormModal(
        formKey: _formKey,
        title: 'Add New Post',
        textFields: textFields,
        formButtons: formButtons);
  }
}
