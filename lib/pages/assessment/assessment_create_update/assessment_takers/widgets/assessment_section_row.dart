import 'package:flutter/material.dart';
import 'package:school_erp/dtos/assessment_taker_dto.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/pages/assignment/assignment_add/question_builder_page/widgets/question_content/add_item_button.dart';

class AssessmentSectionRow extends StatefulWidget {
  final int index;
  final List<Section> activeSections;
  final AssessmentTakerUpdateDTO assessmentTakerUpdateDTO;
  final Function(AssessmentTakerUpdateDTO) onAssessmentTakerChanged;
  final VoidCallback onAddPressed;
  final VoidCallback onRemovePressed;
  final VoidCallback onClearPressed;

  const AssessmentSectionRow({
    required this.index,
    required this.activeSections,
    required this.assessmentTakerUpdateDTO,
    required this.onAssessmentTakerChanged,
    required this.onAddPressed,
    required this.onRemovePressed,
    required this.onClearPressed,
    super.key,
  });

  @override
  State<AssessmentSectionRow> createState() => _AssessmentSectionRowState();
}

class _AssessmentSectionRowState extends State<AssessmentSectionRow> {
  late DateTime startTime;
  late DateTime deadLine;

  @override
  void initState() {
    super.initState();
    startTime = widget.assessmentTakerUpdateDTO.startTime!;
    deadLine = widget.assessmentTakerUpdateDTO.deadLine ??
        widget.assessmentTakerUpdateDTO.startTime!.add(const Duration(days: 1));
  }

  void _loadData() async {}

  void _updateAssessmentTaker({
    String? sectionId,
    DateTime? newStartTime,
    DateTime? newDeadLine,
  }) {
    final updatedTaker = AssessmentTakerUpdateDTO(
      widget.assessmentTakerUpdateDTO.id,
      assessmentId: widget.assessmentTakerUpdateDTO.assessmentId,
      sectionId: widget.assessmentTakerUpdateDTO.sectionId,
      startTime: newStartTime ?? startTime,
      deadLine: newDeadLine ?? deadLine,
    );
    widget.onAssessmentTakerChanged(updatedTaker);
  }

  Future<void> _selectDateTime(bool isStartTime) async {
    final DateTime? selectedDate = await showDatePicker(
      context: context,
      initialDate: isStartTime ? startTime : deadLine,
      firstDate: isStartTime ? DateTime.now() : startTime,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );

    if (selectedDate != null) {
      final TimeOfDay? selectedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(isStartTime ? startTime : deadLine),
      );

      if (selectedTime != null) {
        setState(() {
          final DateTime combined = DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
            selectedTime.hour,
            selectedTime.minute,
          );

          if (isStartTime) {
            startTime = combined;
            _updateAssessmentTaker(newStartTime: combined);
          } else {
            deadLine = combined;
            _updateAssessmentTaker(newDeadLine: combined);
          }
        });
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
                  onTap: () => _selectDateTime(true),
                  child: Text(
                    "Start: ${startTime.toLocal()}".split('.')[0],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
                const SizedBox(height: 5),
                InkWell(
                  onTap: () => _selectDateTime(false),
                  child: Text(
                    "End: ${deadLine.toLocal()}".split('.')[0],
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ),
              ],
            ),
          ),
          // Section Input
          Expanded(
            child: DropdownButtonFormField<Section?>(
              isExpanded: true,
              value: widget.activeSections.firstWhere(
                (section) =>
                    section.id == widget.assessmentTakerUpdateDTO.sectionId,
                orElse: () => widget.activeSections.first,
              ),
              items: widget.activeSections.map((Section? section) {
                return DropdownMenuItem<Section?>(
                  value: section,
                  child: Text(
                    section?.name ?? '',
                    overflow: TextOverflow.ellipsis, // Handle long text
                  ),
                );
              }).toList(),
              onChanged: (Section? newValue) {
                if (newValue != null) {
                  _updateAssessmentTaker(sectionId: newValue.id);
                }
              },
              decoration: InputDecoration(
                labelText: 'Select Section',
                border: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.grey),
                ),
              ),
              icon: const Icon(Icons.keyboard_arrow_down_sharp,
                  color: Colors.grey),
              validator: (value) {
                if (value == null) {
                  return 'Please select a subject';
                }
                return null;
              },
            ),
          ),
          const SizedBox(width: 8),
          AddItemButton(
            index: widget.index,
            onAddPressed: widget.onAddPressed,
            onRemovePressed: widget.onRemovePressed,
          ),
        ],
      ),
    );
  }
}
