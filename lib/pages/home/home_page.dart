import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/pages/home/app_bar/home_app_bar.dart';
import 'package:school_erp/pages/home/app_body/home_app_body.dart';
import 'package:school_erp/pages/home/bottom_nav/bottom_nav_destinations.dart';
import 'package:school_erp/pages/home/bottom_nav/bottom_navigation.dart';
import 'package:school_erp/theme/colors.dart';

class HomePage extends StatefulWidget {
  const HomePage(this.user, {super.key});

  final AuthenticatedUser user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPageIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  void _navOnTap(int index) {
    setState(() {
      currentPageIndex = index;
    });
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 300),
      curve: Curves.ease,
    );
  }

  void _onPageChangedFn(index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HomeAppBar(user: widget.user),
      body: HomeAppBody(
          user: widget.user,
          pageController: _pageController,
          onPageChangedFn: _onPageChangedFn),
      bottomNavigationBar: BottomNavigation(
          tapFn: _navOnTap,
          currentPageIndex: currentPageIndex,
          destinations: BottomNavDestinations()),
      backgroundColor: AppColors.primaryColor,
    );
  }
}
