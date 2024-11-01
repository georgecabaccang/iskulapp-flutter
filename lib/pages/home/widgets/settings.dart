import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key, required this.user});

  final AuthenticatedUser user;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Settings',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Divider(),
                  // Personal Settings
                  ListTile(
                    leading: Icon(Icons.person_outlined),
                    title: Text('My Profile'),
                    onTap: () {
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.domain_outlined),
                    title: Text('School Profile'),
                    onTap: () {
                    },
                  ),
                  Divider(),
                  ListTile(
                    leading: Icon(Icons.light_mode_outlined),
                    title: Text('Light Mode'),
                    trailing: Switch(value: false, onChanged: (value) {
                      // Handle light mode toggle
                    }),
                  ),
                  ListTile(
                    leading: Icon(Icons.privacy_tip_outlined),
                    title: Text('Privacy Policy'),
                    onTap: () {
                      // Navigate to Privacy Policy page
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.headphones_outlined),
                    title: Text('Help and Support'),
                    onTap: () {
                      // Navigate to Help and Support page
                    },
                  ),
                  ListTile(
                    leading: Icon(Icons.logout_outlined),
                    title: Text('Logout'),
                    onTap: () {
                      // Handle logout
                    },
                  ),
                  Divider(),
                  Center(
                    child: ListTile(
                      leading: Image.asset('assets/images/logo-text.png'),
                      title: Text('App Version'),
                      subtitle: Text('1.0.0'), // Replace with your app version
                    ),
                  )

                ],
              ),
            ),
          ),
        ],
      )
    );
  }
}