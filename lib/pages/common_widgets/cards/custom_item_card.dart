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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
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
                margin: const EdgeInsets.only(bottom: 20.0),
                elevation: 1,
                color: AppColors.whiteColor,
                shape: RoundedRectangleBorder(
                  side: const BorderSide(color: Colors.grey, width: 0.5),
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: itemContents,
                  ),
                ),
              ),
            )));
  }
}
