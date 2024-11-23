import 'package:flutter/material.dart';
import 'package:school_erp/constants/urls.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/pages/ask_doubt/ask_doubt_page.dart';
import 'package:school_erp/pages/change_password/change_password_page.dart';
import 'package:school_erp/pages/home/app_body/views/settings/widgets/logout_modal.dart';
import 'package:school_erp/pages/profile/profile_page.dart';

class PersonalSettings {
  ListView getList(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.person_outlined),
          title: Text('My Profile'),
          onTap: () {
            Navigator.push(
              context,
              createSlideRoute(ProfilePage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.domain_outlined),
          title: Text('School Profile'),
          onTap: () {},
        ),
        ListTile(
          leading: Icon(Icons.lock),
          title: Text('Change Password'),
          onTap: () {
            Navigator.push(
              context,
              createSlideRoute(ChangePasswordPage()),
            );
          },
        ),
      ],
    );
  }
}

class AppSettings {
  final void Function(String) launchUrlFn;

  AppSettings({required this.launchUrlFn});

  ListView getList(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          leading: Icon(Icons.light_mode_outlined),
          title: Text('Light Mode'),
          trailing: Switch(
              value: false,
              onChanged: (value) {
                // Handle light mode toggle
              }),
        ),
        ListTile(
          leading: Icon(Icons.privacy_tip_outlined),
          title: Text('Privacy Policy'),
          onTap: () => launchUrlFn(UrlConstants.privacyPolicy),
        ),
        ListTile(
          leading: Icon(Icons.headphones_outlined),
          title: Text('Help and Support'),
          onTap: () {
            Navigator.push(
              context,
              createSlideRoute(AskDoubtPage()),
            );
          },
        ),
        ListTile(
          leading: Icon(Icons.logout_outlined),
          title: Text('Logout'),
          onTap: () => LogoutModal(context).show(),
        ),
      ],
    );
  }
}
