import '../modified_attendance.dart' as modified;
import '../modified_attendance.dart';
import 'package:flutter/material.dart';
import 'calendar_widget.dart';

class FadingAppBar extends StatelessWidget {
  final AnimationState animationState;
  final VoidCallback onBackPressed;
  final String selectedFilter;
  final ValueChanged<String?> onFilterChanged;

  const FadingAppBar({
    super.key,
    required this.animationState,
    required this.onBackPressed,
    required this.selectedFilter,
    required this.onFilterChanged,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0),
        child: Column(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: animationState.isBackNavigation
                  ? 0.0
                  : (animationState.animate ? 1.0 : 0.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: onBackPressed,
                  ),
                  const Spacer(),
                  AnimatedOpacity(
                    duration: const Duration(milliseconds: 500),
                    opacity: animationState.isBackNavigation
                        ? 0.0
                        : (animationState.animate ? 1.0 : 0.0),
                    child: const modified.AttendanceButton(),
                  ),
                  const Spacer(flex: 2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
