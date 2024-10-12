import 'package:flutter/material.dart';

class AppContent extends StatelessWidget {

  final List<Widget> content;

  const AppContent({
    super.key,
    required this.content,
  });

  @override
  Widget build(BuildContext context) {
    return  Expanded(
      child: Container(
        decoration: const BoxDecoration(
          color: Colors.white, // Set the background of the expanded area to white
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.0), // Rounded top left corner
            topRight: Radius.circular(20.0), // Rounded top right corner
          ),
        ),
        child: Column(
          children: content,
        ),
      ),
    );
  }
}
