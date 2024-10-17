import 'package:flutter/material.dart';
import 'package:school_erp/pages/ask_doubt/widgets/ask_doubt_card.dart';
import 'package:school_erp/pages/common_widgets/default_layout.dart';

class AskDoubtPage extends StatefulWidget {
  const AskDoubtPage({super.key});

  @override
  _AskDoubtPageState createState() => _AskDoubtPageState();
}

class _AskDoubtPageState extends State<AskDoubtPage> {
  @override
  Widget build(BuildContext context) {
    return const DefaultLayout(title: "Ask Doubt", content: [AskDoubtCard()]);
  }
}
