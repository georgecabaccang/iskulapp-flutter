import 'package:flutter/material.dart';

// Pass either symetric height/width values or individual height/width values, but not both.
class GeneralDivider extends StatelessWidget {
  final double? topDividerSpaceHeight;
  final double? bottomDividerSpaceHeight;
  final double? leftDividerSpaceWidth;
  final double? rightDividerSpaceWidth;
  final double? symmetricDividerSpaceHeight;
  final double? symmetricDividerSpaceWidth;
  final double dividerThickness;
  final Color dividerColor;

  const GeneralDivider({
    super.key,
    this.topDividerSpaceHeight,
    this.bottomDividerSpaceHeight,
    this.leftDividerSpaceWidth,
    this.rightDividerSpaceWidth,
    this.symmetricDividerSpaceHeight,
    this.symmetricDividerSpaceWidth,
    this.dividerColor = Colors.grey,
    this.dividerThickness = 1,
  });

  double _calculateSpace(
      double? specificValue, double? symmetricValue, double screenDimension) {
    if (specificValue != null) {
      return specificValue * screenDimension / 100;
    }
    if (symmetricValue != null) {
      return symmetricValue * screenDimension / 100;
    }
    return 0;
  }

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    // Heights
    double topSpace = _calculateSpace(
        topDividerSpaceHeight, symmetricDividerSpaceHeight, screenHeight);
    double bottomSpace = _calculateSpace(
        bottomDividerSpaceHeight, symmetricDividerSpaceHeight, screenHeight);

    // Widths
    double leftSpace = _calculateSpace(
        leftDividerSpaceWidth, symmetricDividerSpaceWidth, screenWidth);
    double rightSpace = _calculateSpace(
        rightDividerSpaceWidth, symmetricDividerSpaceWidth, screenWidth);

    return Padding(
      padding: EdgeInsets.only(
        top: topSpace,
        bottom: bottomSpace,
        left: leftSpace,
        right: rightSpace,
      ),
      child: Divider(
        thickness: dividerThickness,
        color: dividerColor,
      ),
    );
  }
}

