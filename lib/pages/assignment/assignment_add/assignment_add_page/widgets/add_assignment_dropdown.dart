import 'package:flutter/material.dart';

class AddAssignmentDropdown extends StatelessWidget {
  final String? value;
  final List<String> items;
  final String hint;
  final ValueChanged<String?> onChanged;

  const AddAssignmentDropdown({
    super.key,
    required this.value,
    required this.items,
    required this.hint,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      value: value,
      decoration: InputDecoration(
        hintText: hint,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
      ),
      items: items.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(
            value,
            style: TextStyle(
              fontWeight:
                  value == this.value ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        );
      }).toList(),
      onChanged: onChanged,
      isExpanded: true, // Makes the dropdown take the full width
      icon: const Icon(Icons.keyboard_arrow_down_sharp, color: Colors.grey),
    );
  }
}
