import 'package:school_erp/pages/common_widgets/forms/inputs/form_input.dart';

class FormLongInput extends FormInput {

    const FormLongInput({
        super.key,
        required super.textController,
        required super.labelText,
        super.hintText,
        super.errorMessage,
        super.verticalMargin,
        super.horizontalMargin,
        required int super.maxLines,
    }) : super(
            isLongInput: true,
        );
}
