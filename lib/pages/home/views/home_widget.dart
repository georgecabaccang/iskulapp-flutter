import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/pages/home/widgets/dashboard_header.dart';
import 'package:school_erp/pages/home/widgets/features.dart';
import 'package:school_erp/pages/home/widgets/time_record_card.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key, required this.user});

  final AuthenticatedUser user;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                DashboardHeader(user: user),
                const SizedBox(height: 16),
                const TimeRecordWidget(),
              ],
            ),
          ),
          Expanded(child: Features(user: user)),
        ],
      ),
    );
  }
}
