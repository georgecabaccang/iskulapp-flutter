import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NumberInputFormField extends StatelessWidget {
  final String label;
  final Function(int?) onSaved;
  final int initialValue;
  final String? Function(String?)? validator;
  final void Function(int?)? onChanged;
  final bool readOnly;
  final String? helperText;
  final TextInputAction? textInputAction;

  const NumberInputFormField({
    super.key,
    required this.label,
    required this.initialValue,
    required this.onSaved,
    this.validator,
    this.onChanged,
    this.readOnly = false,
    this.helperText,
    this.textInputAction,
  });

  String? _defaultValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a number';
    }
    if (int.tryParse(value) == null) {
      return 'Please enter a valid integer';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(height: 8),
        TextFormField(
          decoration: InputDecoration(
            helperText: helperText,
            border: const UnderlineInputBorder(),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 8,
              vertical: 16,
            ),
          ),
          initialValue: initialValue.toString(),
          keyboardType: TextInputType.number,
          textInputAction: textInputAction ?? TextInputAction.next,
          readOnly: readOnly,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: validator ?? _defaultValidator,
          onChanged: onChanged != null
              ? (value) => onChanged!(int.tryParse(value))
              : null,
          onSaved: (value) => onSaved(int.tryParse(value ?? '')),
        ),
      ],
    );
  }
}
