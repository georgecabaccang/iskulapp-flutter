import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/theme/colors.dart';

class DefaultLayout extends StatefulWidget {
  final String title;
  final List<Widget> content;

  const DefaultLayout({super.key, required this.title, required this.content});

  @override
  _DefaultLayoutState createState() => _DefaultLayoutState();
}

class _DefaultLayoutState extends State<DefaultLayout> {

  late String _title;
  late List<Widget> _content;

  @override
  void initState() {
    super.initState();
    _title = widget.title;
    _content = widget.content;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(title: _title),
          AppContent(
            content: _content,
          ),
        ],
      ),
    );
  }
}

