import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

enum IconPosition { left, right }

class PrimaryRoundElevatedButton extends StatelessWidget{
    final void Function() buttonFn;
    final bool isDisabled;
    final Icon? icon;
    final String? label;
    final IconPosition? iconPosition;

    const PrimaryRoundElevatedButton({
        super.key, 
        required this.buttonFn, 
        this.isDisabled = false,
        this.icon, 
        this.label, 
        this.iconPosition = IconPosition.left});

    @override
    Widget build(BuildContext context) {
        return  ElevatedButton(
            onPressed: buttonFn,
            style: ElevatedButton.styleFrom(
                backgroundColor: isDisabled ? AppColors.disabled : AppColors.primaryColor,
                foregroundColor: AppColors.primaryFontColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                ),
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10)
            ),
            child: Row(
                mainAxisSize: MainAxisSize.min, 
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                    if (icon != null && iconPosition == IconPosition.left) ...[
                        icon!, 
                    ],
                    if (label != null)
                    Text(
                        label!,
                        style: TextStyle(fontSize: 16), 
                    ),
                    if (icon != null && iconPosition == IconPosition.right) ...[
                        icon!, 
                    ],
                ],
            ),
        );
    }

}