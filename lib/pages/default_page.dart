import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';
import 'package:school_erp/pages/common_widgets/views/coming_soon_widget.dart';
import 'package:school_erp/theme/colors.dart';

class DefaultPage extends StatelessWidget {
  final String title;
  final Color? fontColor;

  const DefaultPage(
      {required this.title, this.fontColor = AppColors.whiteColor, super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultLayout(title: title, content: [
      ComingSoonWidget(title: title, fontColor: fontColor),
    ]);
  }
}
