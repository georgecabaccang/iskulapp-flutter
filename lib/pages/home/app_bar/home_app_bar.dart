import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth.dart';
import 'package:school_erp/theme/colors.dart';

import 'package:school_erp/theme/text_styles.dart';

class HomeAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AuthenticatedUser user;

  const HomeAppBar({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return AppBar(
        title: Text(
          user.schoolName,
          style: headingStyle().copyWith(color: AppColors.primaryColor),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Text(
              'Year ${user.academicYear}',
              style: bodyStyle()
                  .copyWith(color: AppColors.primaryColor, fontSize: 12),
            ),
          )
        ]);
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
