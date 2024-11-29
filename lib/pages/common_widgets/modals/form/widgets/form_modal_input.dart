import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
  final TextEditingController textController;
  final String labelText;
  final String? hintText;
  final String? errorMessage;

  const FormInput(
      {super.key,
      required this.textController,
      required this.labelText,
      this.hintText,
      this.errorMessage});

  @override
  createState() => _FormInput();
}

class _FormInput extends State<FormInput> {
  @override
  Widget build(BuildContext context) {
    return FormField<String>(builder: (state) {
      return TextFormField(
        controller: widget.textController,
        decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            errorText: state.hasError ? state.errorText : null),
        validator: (value) {
          if (value == null || value.isEmpty) {
            return widget.errorMessage;
          }
          return null;
        },
      );
    });
  }
}
