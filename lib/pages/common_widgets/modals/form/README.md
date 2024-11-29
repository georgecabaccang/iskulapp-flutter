## Main Widget

        - FormModal

## Children Widgets

        - FormInput
        - FormButton

## Purpose

        For easier and faster creation of modal forms with validations.

## Features

        - Utilizes Flutter's built-in Form and FormField widgets.
        - Automatically handles validation of form and inputs.

## Usage

### FormModal

        1. Import FormModal into whatever file you're going to use it.
        2. In the file you're importing FormModal, supply the values with the following types:
                - GlobalKey<FormState> for formKey
                - String for title
                - List<FormInput> for textFields
                - List<FormButton> for formButtons
        NOTES:
                - Providing multiple FormInput(s) is possible.
                - Providing multiple FormButton(s) is possible.

### FormInput

        1. Supply the values with the following types:
                - String for labelText
                - TextEditingController for textController
                - String for errorMessage
        NOTES:
                - TextEditingController should only have a one-to-one relationship for each FormInput.

        EXAMPLE:
                final TextEditingController firstInput = TextEditingController();
                final TextEditingController secondInput = TextEditingController();

                final List<FormInput> textFields = [
                        FormInput(
                                labelText: "First Input",
                                textController: firstInput,
                                errorMessage: "This is the error message",

                        ),
                        FormInput(
                                labelText: "Second Input",
                                textController: secondInput,
                                errorMessage: "This is the error message",
                        ),
                ];

### FormButton

        1. Supply the values with the following types:
                - String for buttonLabel
                - ButtonType for textController
                - void Function() for buttonFn (optional, usually your submit function)
        NOTES:
                - ButtonType is an enum
                - Default onPressed function of button is to close the modal

### Parent Widget

        1. To validate form and inputs in your submit function:

                if (_formKey.currentState!.validate() == false) {

                 // Do what you want here if the form is not valid.

                }
