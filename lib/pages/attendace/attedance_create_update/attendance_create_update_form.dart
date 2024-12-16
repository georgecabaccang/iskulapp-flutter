import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/attendance/cubit/attendance_check_cubit.dart';
import 'package:school_erp/features/auth/utils.dart';
import 'package:school_erp/models/section.dart';
import 'package:school_erp/pages/attendace/attedance_create_update/widgets/attendance_filter.dart';
import 'package:school_erp/pages/attendace/attedance_create_update/widgets/attendance_check_list.dart';
import 'package:school_erp/repositories/repositories.dart';

class AttendanceCreateUpdateForm extends StatefulWidget {
  const AttendanceCreateUpdateForm({super.key});

  @override
  _AttendanceCreateUpdateFormState createState() =>
      _AttendanceCreateUpdateFormState();
}

class _AttendanceCreateUpdateFormState
    extends State<AttendanceCreateUpdateForm> {
  var isLoading = true;
  var sectionList = <Section>[];
  Section? selectedSection;
  DateTime selectedDate = DateTime.now();

  @override
  initState() {
    super.initState();
    _loadSections();
  }

  Future<void> _loadSections() async {
    final authUser = getAuthUser(context);
    final teacherId = getTeacherId(context);
    final fetchedSections = await sectionRepository.getTeacherSectionsAll(
      teacherId: teacherId,
      academicYearId: authUser.academicYearId,
    );
    sectionList.addAll(fetchedSections);

    setState(() => isLoading = false);
  }

  void _getAttendanceList(BuildContext context) {
    if (selectedSection != null) {
      context.read<AttendanceCheckCubit>().getAttendanceList(
          date: DateTime(
            selectedDate.year,
            selectedDate.month,
            selectedDate.day,
          ),
          sectionId: selectedSection!.id);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const CircularProgressIndicator()
        : Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              AttendanceFilter(
                selectedSection: selectedSection,
                sectionList: sectionList,
                selectedDate: selectedDate,
                onSectionSelected: (section) {
                  setState(() {
                    selectedSection = section;
                    _getAttendanceList(context);
                  });
                },
                onDateSelected: (pickedDate) {
                  setState(() {
                    selectedDate = pickedDate!;
                    _getAttendanceList(context);
                  });
                },
              ),
              const SizedBox(height: 8),
              AttendanceCheckList(
                section: selectedSection,
                date: selectedDate,
              ),
            ],
          );
  }
}
