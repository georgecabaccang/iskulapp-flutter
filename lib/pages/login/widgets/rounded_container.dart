import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
class RoundedContainer extends StatelessWidget {
  final Widget child;
  final double height;
  final double borderRadius;

  const RoundedContainer({
    super.key,
    required this.child,
    this.height = 400,
    this.borderRadius = 20.0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius),
        ),
        border: const Border(
          top: BorderSide(color: Colors.transparent, width: 2.0),
          left: BorderSide(color: Colors.transparent, width: 2.0),
          right: BorderSide(color: Colors.transparent, width: 2.0),
          bottom: BorderSide.none,
        ),
      ),
      child: Center(child: child),
    );
  }
}
