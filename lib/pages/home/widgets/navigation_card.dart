import 'package:flutter/material.dart';

class NavigationCard extends StatelessWidget {
  const NavigationCard(this.title, this.icon, this.callback, {super.key});

  final String title;
  final IconData icon;
  final Function callback;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => callback(),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF5F6FC),
          borderRadius: BorderRadius.circular(20.0),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 30.0,
              backgroundColor: const Color(0xFF5278C1),
              child: Icon(
                icon,
                size: 40.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 8.0),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16.0,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
