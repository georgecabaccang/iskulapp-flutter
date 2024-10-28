import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/bloc/auth_bloc_barrel.dart';
import 'package:school_erp/features/auth/auth_repository/auth_repository.dart';
import 'package:school_erp/pages/EnterExitRoute.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/assignment_list_page.dart';
import 'package:school_erp/pages/calendar/calendar_attendance_page.dart';
import 'package:school_erp/pages/change_password/change_password_page.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/loading_overlay.dart';
import 'package:school_erp/pages/events/events_page.dart';
import 'package:school_erp/pages/home/widgets/DashboardHeader.dart';
import 'package:school_erp/pages/home/widgets/Feature.dart';
import 'package:school_erp/pages/home/widgets/TimeRecordTable.dart';
import 'package:school_erp/pages/leave_application/leave_application_page.dart';
import 'package:school_erp/pages/timetable/timetable_page.dart';
import 'package:school_erp/pages/ask_doubt/ask_doubt_page.dart';
import 'package:school_erp/pages/school_gallery/school_gallery_page.dart';
import 'widgets/navigation_card.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:school_erp/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.user, {super.key});

  final AuthenticatedUser user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: BlocConsumer<AuthBloc, AuthState>(
        listener: (context, state) {
          if (state is AuthFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          if (state is AuthLoading) return const LoadingOverlay();
          return SafeArea(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 16,top: 16,right: 16),
                  child: Column(
                    children: [
                      DashboardHeader(user: widget.user),
                      const SizedBox(height: 16), // give it width
                      TimeRecordWidget(),
                      const SizedBox(height: 16), // give it width
                    ],
                  ),
                ),
                Expanded(child: Feature(user: widget.user))
              ],
            ),
          );
        },
      ),
    );
  }
}
