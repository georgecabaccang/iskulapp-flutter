import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputFormField extends StatelessWidget {
  final String label;
  final FormFieldSetter<int> onSaved;
  final int initialValue;

  const NumberInputFormField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onSaved,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: label,
        border: const UnderlineInputBorder(),
      ),
      initialValue: initialValue.toString(),
      keyboardType: TextInputType.number,
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter a number';
        }
        if (int.tryParse(value) == null) {
          return 'Please enter a valid integer';
        }
        return null;
      },
      onSaved: (value) {
        if (value != null) {
          final intValue = int.tryParse(value);
          if (intValue != null) {
            onSaved(intValue);
          }
        }
      },
    );
  }
}
