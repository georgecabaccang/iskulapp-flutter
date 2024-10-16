import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/pages/ask_doubt/widgets/ask_doubt_card.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/common_widgets/app_content.dart';

class AskDoubtPage extends StatefulWidget {
  const AskDoubtPage({super.key});

  @override
  _AskDoubtPageState createState() => _AskDoubtPageState();
}

class _AskDoubtPageState extends State<AskDoubtPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          CustomAppBar(
            title: 'Ask Doubt',
          ),
          AppContent(
            content: [AskDoubtCard()],
          ),
        ],
      ),
    );
  }
}
