import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback onBackPressed;
  final Widget? trailingWidget;
  final Animation<double>? fadeAnimation;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.onBackPressed,
    this.trailingWidget,
    this.fadeAnimation,
  });

  @override
  Size get preferredSize => const Size.fromHeight(100);

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height * 0.15;

    return SizedBox(
      height: height,
      child: AppBar(
        leading: FadeTransition(
          opacity: fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
            onPressed: onBackPressed,
          ),
        ),
        title: FadeTransition(
          opacity: fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
          child: Text(
            title,
            style: const TextStyle(color: Colors.white),
          ),
        ),
        actions: [
          if (trailingWidget != null)
            FadeTransition(
              opacity: fadeAnimation ?? const AlwaysStoppedAnimation(1.0),
              child: Padding(
                padding: const EdgeInsets.only(right: 32.0),
                child: trailingWidget!,
              ),
            ),
        ],
        backgroundColor: const Color(0xFF5278C1),
      ),
    );
  }
}
