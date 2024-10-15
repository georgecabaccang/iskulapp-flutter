import 'package:flutter/material.dart';
import 'package:school_erp/pages/change_password/widgets/change_password_card.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class ChangePasswordPage extends StatefulWidget {
  const ChangePasswordPage({super.key});

  @override
  _ChangePasswordPageState createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {


 
  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(
        title: "Change Password", content: [ChangePasswordCard()]);
  }
}

