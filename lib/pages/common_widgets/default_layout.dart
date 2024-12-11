import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/theme/colors.dart';

class DefaultLayout extends StatelessWidget {
  final String title;
  final List<Widget> content;
  final Widget? trailingWidget;

  const DefaultLayout(
      {super.key,
      required this.title,
      required this.content,
      this.trailingWidget});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(
            title: title,
            trailingWidget: trailingWidget,
          ),
          AppContent(
            content: content,
          ),
        ],
      ),
    );
  }
}
