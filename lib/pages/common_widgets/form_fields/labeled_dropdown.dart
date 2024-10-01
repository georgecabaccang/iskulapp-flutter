import 'package:flutter/material.dart';

class LabeledDropdownFormField<T> extends FormField<T> {
  LabeledDropdownFormField({
    super.key,
    required String label,
    required Map<String, T> dropdownItems,
    bool isExpanded = true,
    T? initialValue,
    super.onSaved,
    super.validator,
    ValueChanged<T?>? onChanged,
  }) : super(
          initialValue: initialValue ?? dropdownItems.values.first,
          builder: (FormFieldState<T> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(color: Colors.grey),
                ),
                DropdownButtonFormField<T>(
                  value: state.value,
                  isExpanded: isExpanded,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey),
                    ),
                  ),
                  icon: const Icon(Icons.keyboard_arrow_down_sharp,
                      color: Colors.grey),
                  onChanged: (T? newValue) {
                    state.didChange(newValue);
                    if (onChanged != null) {
                      onChanged(newValue);
                    }
                  },
                  items: dropdownItems.entries.map((entry) {
                    return DropdownMenuItem<T>(
                      value: entry.value,
                      child: Text(
                        entry.key,
                        style: TextStyle(
                          fontWeight: entry.value == state.value
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    );
                  }).toList(),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      state.errorText!,
                      style: TextStyle(
                          color: Theme.of(state.context).colorScheme.error),
                    ),
                  ),
              ],
            );
          },
        );
}
