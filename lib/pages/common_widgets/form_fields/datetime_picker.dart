import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePickerFormField extends FormField<DateTime> {
  final String label;
  @override
  final DateTime? initialValue;

  DateTimePickerFormField({
    super.key,
    required this.label,
    DateTime? initialValue,
    required FormFieldSetter<DateTime> super.onSaved,
    super.validator,
  })  : initialValue = initialValue ?? DateTime.now(),
        super(
          initialValue: initialValue ?? DateTime.now(),
          builder: (FormFieldState<DateTime> state) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: const TextStyle(color: Colors.grey)),
                InkWell(
                  onTap: () async {
                    final pickedDateTime = await showDateTimePicker(
                      context: state.context, // Pass context here
                      initialDate: state.value,
                    );
                    if (pickedDateTime != null) {
                      state.didChange(pickedDateTime);
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.grey)),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(DateFormat('MMM dd, yyyy h:mm a')
                            .format(state.value!)),
                        const Icon(Icons.keyboard_arrow_down_sharp,
                            color: Colors.grey),
                      ],
                    ),
                  ),
                ),
                if (state.hasError)
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      state.errorText!,
                      style:
                          TextStyle(color: Theme.of(state.context).colorScheme.error),
                    ),
                  ),
              ],
            );
          },
        );

  static Future<DateTime?> showDateTimePicker({
    required BuildContext context, // context is required
    DateTime? initialDate,
    DateTime? firstDate,
    DateTime? lastDate,
  }) async {
    initialDate ??= DateTime.now();
    firstDate ??= initialDate.subtract(const Duration(days: 365 * 100));
    lastDate ??= firstDate.add(const Duration(days: 365 * 200));

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );

    if (selectedDate == null) return null;

    if (!context.mounted) return selectedDate;

    final TimeOfDay? selectedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.fromDateTime(initialDate),
    );

    return selectedTime == null
        ? selectedDate
        : DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );
  }
}
