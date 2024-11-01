import 'package:flutter/material.dart';
import 'package:school_erp/pages/profile/profile_page.dart';
import '../../../constants/text_constants.dart';
import '../../../features/auth/auth_repository/schemas/user.dart';
import '../../../theme/text_styles.dart';
import '../../EnterExitRoute.dart';

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
              onTap: () {},
              child: CircleAvatar(
                radius: 30,
                backgroundColor: Colors.grey[300],
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.white,
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: _userInfo(context, user),
              ),
            ),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Text(
                  TextConstants.studentName(user.firstName, user.lastName),
                  style: headingStyle().copyWith(fontSize: 20),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: const Text(
                  'Grade 8 | Sampaguita',
                  style: TextStyle(
                    fontSize: 16.0,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              _createSlideRoute(NotificationWidget(user: user)),
            );
          },
          child: const Icon(
            Icons.notifications,
            size: 32,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}

Route _createSlideRoute(Widget page) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) => page,
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(1.0, 0.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      var offsetAnimation = animation.drive(tween);

      return SlideTransition(
        position: offsetAnimation,
        child: child,
      );
    },
  );
}

class NotificationWidget extends StatelessWidget {
  final AuthenticatedUser user;

  const NotificationWidget({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Notifications"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications_sharp),
                title: const Text('Notification 1'),
                subtitle: const Text('This is a notification'),
              ),
            ),
            Card(
              child: ListTile(
                leading: const Icon(Icons.notifications_sharp),
                title: const Text('Notification 2'),
                subtitle: const Text('This is a notification'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
