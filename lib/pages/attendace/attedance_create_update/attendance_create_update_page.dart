import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/features/attendance/attendance_service.dart';
import 'package:school_erp/features/attendance/cubit/attendance_check_cubit.dart';
import 'package:school_erp/pages/attendace/attedance_create_update/attendance_create_update_view.dart';
import 'package:school_erp/repositories/attendance_repository.dart';
import 'package:school_erp/repositories/student_repository.dart';

class AttendanceCreateUpdatePage extends StatelessWidget {
  const AttendanceCreateUpdatePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<AttendanceRepository>(
          create: (context) => AttendanceRepository(),
        ),
        RepositoryProvider<StudentRepository>(
          create: (context) => StudentRepository(),
        ),
      ],
      child: Builder(
        builder: (context) {
          final attendanceRepo = context.read<AttendanceRepository>();
          final studentRepo = context.read<StudentRepository>();

          final attendanceService = AttendanceService(
            attendanceRepository: attendanceRepo,
          );

          return MultiBlocProvider(
            providers: [
              BlocProvider<AttendanceCheckCubit>(
                create: (context) => AttendanceCheckCubit(
                  attendanceService: attendanceService,
                  attendanceRepository: attendanceRepo,
                  studentRepository: studentRepo,
                ),
              ),
            ],
            child: const AttendanceCreateUpdateView(),
          );
        },
      ),
    );
  }
}
