import 'package:flutter/material.dart';
import 'package:school_erp/features/transition/clean_slide_transition.dart';
import 'package:school_erp/theme/colors.dart';

class CustomItemCard extends StatelessWidget {
    final Widget slideRoute;
    final List<Widget> itemContents;

    const CustomItemCard(
    {super.key, required this.slideRoute, required this.itemContents});

    @override
    Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        double horizontalPadding = screenWidth * 0.05; 
        double verticalPadding = screenHeight * 0.02; 

        return Padding(
            padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
            child: FractionallySizedBox(
                widthFactor: 1,
                child: InkWell(
                    onTap: () {
                        Navigator.push(
                            context,
                            createSlideRoute(
                                slideRoute,
                            ),
                        );
                    },
                    child: Card(
                        margin: EdgeInsets.only(bottom: verticalPadding),
                        elevation: 1,
                        color: AppColors.whiteColor,
                        shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Colors.grey, width: 0.5),
                            borderRadius: BorderRadius.circular(20.0),
                        ),
                        child: Padding(
                            padding: EdgeInsets.all(verticalPadding),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: itemContents,
                            ),
                        ),
                    ),
                ),
            ),
        );
    }
}