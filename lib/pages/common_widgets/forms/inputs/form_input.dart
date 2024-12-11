import 'package:flutter/material.dart';

class FormInput extends StatefulWidget {
    final TextEditingController textController;
    final String labelText;
    final int? maxLines;
    final bool isLongInput;
    final String? hintText;
    final String? errorMessage;
    final double? verticalMargin;
    final double? horizontalMargin;

    const FormInput(
    {super.key,
        required this.textController,
        required this.labelText,
        this.hintText,
        this.errorMessage, 
        this.verticalMargin, 
        this.horizontalMargin, 
        this.maxLines,
        this.isLongInput = false});

    @override
    createState() => _FormInput();
}

class _FormInput extends State<FormInput> {
    @override
    Widget build(BuildContext context) {
        return Container(
            margin: EdgeInsets.symmetric(
                horizontal: widget.horizontalMargin ?? 0, 
                vertical: widget.verticalMargin ?? 0
            ),
            child: FormField<String>(builder: (state) {
                    return TextFormField(
                        minLines: 1,
                        maxLines: widget.isLongInput ? widget.maxLines ?? 5 : 1,
                        controller: widget.textController,keyboardType: TextInputType.multiline,
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
                }
            )
        );
    }
}
