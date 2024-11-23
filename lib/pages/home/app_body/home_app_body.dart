import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/pages/common_widgets/views/comming_soon_widget.dart';
import 'package:school_erp/pages/home/views/home_widget.dart';
import 'package:school_erp/pages/home/widgets/feeds.dart';
import 'package:school_erp/pages/home/widgets/settings.dart';

class HomeAppBody extends StatelessWidget {
  final AuthenticatedUser user;
  final PageController pageController;
  final void Function(int) onPageChangedFn;

  const HomeAppBody(
      {super.key,
      required this.user,
      required this.pageController,
      required this.onPageChangedFn});

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: pageController,
      onPageChanged: onPageChangedFn,
      children: [
        HomeWidget(user: user),
        FeedsWidget(user: user),
        ComingSoonWidget(),
        //MessageWidget(user: widget.user),
        SettingWidget(user: user),
      ],
    );
  }
}
