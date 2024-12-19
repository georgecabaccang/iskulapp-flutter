import 'package:flutter/material.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/utils/extensions/string_extension.dart';
import 'package:school_erp/constants/attendance/form_labels.dart' as form;

class SectionFilter extends StatelessWidget {
  final Section? selectedSection;
  final List<Section> sectionList;
  final ValueChanged<Section?> onSectionSelected;

  const SectionFilter(
      {required this.selectedSection,
      required this.sectionList,
      required this.onSectionSelected,
      super.key});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<Section?>(
      value: selectedSection,
      items: sectionList.map((Section? section) {
        return DropdownMenuItem<Section?>(
          value: section,
          child: Text(
            section!.name.title(),
          ),
        );
      }).toList(),
      onChanged: onSectionSelected,
      decoration: const InputDecoration(
        labelText: form.sectionLabel,
        border: UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.greyColor),
        ),
      ),
      isExpanded: true,
      icon: const Icon(Icons.keyboard_arrow_down_sharp,
          color: AppColors.greyColor),
    );
  }
}
