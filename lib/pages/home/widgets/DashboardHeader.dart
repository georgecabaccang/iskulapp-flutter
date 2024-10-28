import 'package:flutter/material.dart';
import '../../../constants/text_constants.dart';
import '../../../features/auth/auth_repository/schemas/user.dart';
import '../../../theme/text_styles.dart';
import '../../EnterExitRoute.dart';
import '../../profile/profile_page.dart';

// User info widget displaying name and grade
class DashboardHeader extends StatelessWidget {
  final AuthenticatedUser user;

  const DashboardHeader({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
        builder: (context, constraints) {
          double screenWidth = MediaQuery.of(context).size.width;
          bool isSmallScreen = screenWidth < 400;

          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    EnterExitRoute(
                      exitPage: context.widget,
                      enterPage: const ProfilePage(),
                    ),
                  );
                },
                child: CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.grey[300],
                  child: Icon(
                    Icons.person,
                    size: 50, // Adjust icon size
                    color: Colors.white,
                  ),
                ),
              ),
              Expanded(
                child: _userInfo(context, user),
              ),
              // const Spacer(),
            ],
          );
        },
    );
  }

  Widget _userInfo(BuildContext context, AuthenticatedUser user) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child:
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    TextConstants.studentName(user.firstName, user.lastName),
                    style: headingStyle().copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                const SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Text(
                    'Grade 8 | Sampaguita',
                    style: TextStyle(
                      fontSize: 14.0,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              EnterExitRoute(
                exitPage: context.widget,
                enterPage: const ProfilePage(),
              ),
            );
          },
          child: const Icon(
            Icons.notifications,
            size: 24,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}
