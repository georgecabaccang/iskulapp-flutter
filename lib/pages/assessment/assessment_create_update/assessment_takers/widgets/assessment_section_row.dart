import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/assessment/cubit/assessment_cubit.dart';
import 'package:school_erp/models/assessment_taker.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/pages/assessment/assessment_create_update/assessment_takers/widgets/add_remove_item_button.dart';

class AssessmentSectionRow extends StatelessWidget {
  final int index;
  final AssessmentTaker assessmentTaker;
  final List<Section> sections;

  const AssessmentSectionRow({
    required this.index,
    required this.assessmentTaker,
    required this.sections,
    super.key,
  });

  void _selectDateTime(BuildContext context, bool isStartTime) async {
    final cubit = context.read<AssessmentCubit>();

    final currentTime =
        isStartTime ? assessmentTaker.startTime : assessmentTaker.deadLine;

    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: currentTime ?? DateTime.now(),
      firstDate: isStartTime ? DateTime.now() : assessmentTaker.startTime,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (!context.mounted) return;

    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(currentTime ?? DateTime.now()),
      );

      if (!context.mounted) return;

      if (selectedTime != null) {
        final DateTime combined = DateTime(
          selectedDate.year,
          selectedDate.month,
          selectedDate.day,
          selectedTime.hour,
          selectedTime.minute,
        );

        final updatedTaker = assessmentTaker.copyWith(
          startTime: isStartTime ? combined : assessmentTaker.startTime,
          deadLine: isStartTime ? assessmentTaker.deadLine : combined,
        );

        cubit.updateAssessmentTaker(index, updatedTaker);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () => _selectDateTime(context, true),
                  child: Text(
                    "Start: ${assessmentTaker.startTime.toLocal().toString().split('.')[0]}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () => _selectDateTime(context, false),
                  child: Text(
                    "End: ${assessmentTaker.deadLine?.toLocal().toString().split('.')[0] ?? 'N/A'}",
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: DropdownButtonFormField<Section?>(
              isExpanded: true,
              value: sections
                      .where(
                          (section) => section.id == assessmentTaker.sectionId)
                      .isEmpty
                  ? null
                  : sections.firstWhere(
                      (section) => section.id == assessmentTaker.sectionId,
                    ),
              items: sections.map((section) {
                return DropdownMenuItem<Section>(
                  value: section,
                  child: Text(
                    section.name,
                    overflow: TextOverflow.ellipsis,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                if (newValue != null) {
                  final updatedTaker = assessmentTaker.copyWith(
                    sectionId: newValue.id,
                  );
                  context
                      .read<AssessmentCubit>()
                      .updateAssessmentTaker(index, updatedTaker);
                }
              },
              decoration: const InputDecoration(
                labelText: 'Select Section',
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey),
              validator: (value) {
                if (value == null) {
                  return 'Please select a section';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 8),
          AddItemButton(
            index: index,
            onAddPressed: () =>
                context.read<AssessmentCubit>().addAssessmentTaker(),
            onRemovePressed: () => context
                .read<AssessmentCubit>()
                .updateAssessmentTakersForRemoval(index),
          ),
        ],
      ),
    );
  }
}
