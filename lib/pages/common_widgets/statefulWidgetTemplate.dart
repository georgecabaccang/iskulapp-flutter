import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/theme/colors.dart';


class StatefulWidgetTemplate extends StatefulWidget {
  const StatefulWidgetTemplate({super.key});

  @override
  _StatefulWidgetTemplateState createState() => _StatefulWidgetTemplateState();
}

class _StatefulWidgetTemplateState extends State<StatefulWidgetTemplate> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          const CustomAppBar(title: 'POGI SI EARL'),
          AppContent(
            content: [  const Center(child: Text('Mas pogi si Fred')), // Placeholder for content/ Placeholder for content
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(const MaterialApp(
    home: StatefulWidgetTemplate(),
  ));
}
