import 'package:flutter/material.dart';

class GeneralDivider extends StatelessWidget {
    final double? topDividerSpaceHeight;
    final double? bottomDividerSpaceHeight;
    final double? leftDividerSpaceWidth;
    final double? rightDividerSpaceWidth;
    final double? symmetricDividerSpaceHeight;
    final double? symmetricDividerSpaceWidth;
    final double? dividerThickness;

    const GeneralDivider({
        super.key,
        this.topDividerSpaceHeight,
        this.bottomDividerSpaceHeight,
        this.leftDividerSpaceWidth,
        this.rightDividerSpaceWidth,
        this.symmetricDividerSpaceHeight,
        this.symmetricDividerSpaceWidth,
        this.dividerThickness = 1,
    });

    @override
    Widget build(BuildContext context) {
        double screenHeight = MediaQuery.of(context).size.height;
        double screenWidth = MediaQuery.of(context).size.width;

        // Height calcualtions
        double topSpace = topDividerSpaceHeight != null
            ? topDividerSpaceHeight! * screenHeight / 100 
            : (symmetricDividerSpaceHeight != null
                ? symmetricDividerSpaceHeight! * screenHeight / 100
                : 0);
        double bottomSpace = bottomDividerSpaceHeight != null
            ? bottomDividerSpaceHeight! * screenHeight / 100 
            : (symmetricDividerSpaceHeight != null
                ? symmetricDividerSpaceHeight! * screenHeight / 100
                : 0);

        // Width calcualtions
        double leftSpace = leftDividerSpaceWidth != null
            ? leftDividerSpaceWidth!
            : (symmetricDividerSpaceWidth != null
                ? symmetricDividerSpaceWidth! * screenWidth / 100
                : 0);
        double rightSpace = rightDividerSpaceWidth != null
            ? rightDividerSpaceWidth!
            : (symmetricDividerSpaceWidth != null
                ? symmetricDividerSpaceWidth! * screenWidth / 100
                : 0);

        return Padding(
            padding: EdgeInsets.only(
                top: topSpace,
                bottom: bottomSpace,
                left: leftSpace,
                right: rightSpace,
            ),
            child: Divider(
                thickness: dividerThickness,
                color: Colors.grey,
            ),
        );
    }
}