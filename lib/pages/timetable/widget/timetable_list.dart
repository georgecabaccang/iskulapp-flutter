import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/lists/custom_list_view.dart';
import 'package:school_erp/pages/timetable/helpers/timetable.dart';
import 'package:school_erp/pages/timetable/widget/timetable_card.dart';

class TimeTableList extends StatelessWidget {
    final List<ClassDetails> classes;

    const TimeTableList({
        super.key, 
        required this.classes, 
    });

    @override
    Widget build(BuildContext context) {
        return CustomListView(
            listOfData: classes, 
            itemBuilder: (context, classDetails) => TimetableCard(classDetails: classDetails),
        );
    }
}