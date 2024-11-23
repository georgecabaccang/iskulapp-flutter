import 'package:flutter/material.dart';
import 'package:school_erp/features/auth/auth_repository/schemas/user.dart';
import 'package:school_erp/pages/home/app_body/views/settings/widgets/helpers/settings_list.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart%20';
import 'package:url_launcher/url_launcher.dart';

class SettingWidget extends StatelessWidget {
  const SettingWidget({super.key, required this.user});

  Future<dynamic> _launchURL(String urlPost) async {
    final Uri url = Uri.parse(urlPost);

    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    } else {
      throw 'Could not launch $url';
    }
  }

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
                Text(
                  'Settings',
                  style: headingStyle().copyWith(color: AppColors.primaryColor),
                ),
                Divider(),
                // Personal Settings
                PersonalSettings().getList(context),
                Divider(),
                // App Settings
                AppSettings(launchUrlFn: _launchURL).getList(context),
                Divider(),
                Center(
                  child: ListTile(
                    leading: Image.asset('assets/images/logo-text.png'),
                    title: Text('App Version'),
                    subtitle: Text('1.0.0'),
                  ),
                )
              ],
            ),
          ),
        ),
      ],
    ));
  }
}
