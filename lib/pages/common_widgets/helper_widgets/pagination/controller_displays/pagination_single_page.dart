import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class SinglePage extends StatelessWidget{
    const SinglePage({super.key});

    @override
    Widget build(BuildContext context) {
        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [ 
                SizedBox(
                    child: Center(
                        child: Text(
                            "1",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, 
                                color: AppColors.primaryColor, 
                            ),
                        ),
                    ),
                ),
            ]
        );

    }
}