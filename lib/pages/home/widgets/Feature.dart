import 'package:flutter/material.dart';
import 'package:school_erp/pages/assignment/assignment_list_page/assignment_list_page.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/home/widgets/FeatureIcon.dart';
import '../../../theme/text_styles.dart';
import '../../../features/auth/auth_repository/schemas/user.dart';
import '../../EnterExitRoute.dart';
import '../../profile/profile_page.dart';

// User info widget displaying name and grade
class Feature extends StatelessWidget {
  final AuthenticatedUser user;

  const Feature({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final List<FeatureIcon> coreFeatures = [
      const FeatureIcon(
          icon: Icons.edit_note_outlined, target: null, text: 'Edit Note'),
      const FeatureIcon(
          icon: Icons.assignment,
          target: AssignmentListPage(),
          text: 'Profile'),
      const FeatureIcon(
          icon: Icons.settings, target: AssignmentListPage(), text: 'Settings'),
      // Add more features as needed
    ];

    var button = Padding(padding: EdgeInsets.only(right: 24), child: GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          EnterExitRoute(
            exitPage: context.widget,
            enterPage: const ProfilePage(),
          ),
        );
      },
      child: Column(
        children: [
          CircleAvatar(
            radius: 40,
            backgroundColor: AppColors.whiteColor,
            child: Icon(
              Icons.edit_note_outlined,
              size: 50, // Adjust icon size
              color: AppColors.primaryColor,
            ),
          ),
          Text('Quiz')
        ],
      ),
      ),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        return ListView(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0, horizontal: (24)),
                  child: Text(
                    'Core',
                    style: headingStyle().copyWith(
                      fontSize: 20,
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 6, horizontal: (24)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        button,
                        button,
                        button,
                        button,
                        button,
                        button,
                        button,
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

}
