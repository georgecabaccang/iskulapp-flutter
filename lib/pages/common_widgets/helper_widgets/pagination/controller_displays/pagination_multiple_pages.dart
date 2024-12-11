import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class MultiplePages extends StatelessWidget{
    final int currentPage;
    final int totalPages;

    const MultiplePages({super.key, required this.currentPage, required this.totalPages});

    @override
    Widget build(BuildContext context) {
        double numberContainerWidth = 40;

        return Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [

                // If curentPage == totalPages, display the page number of the one two levels lower
                if (currentPage == totalPages && totalPages > 2) 
                SizedBox(
                    width: numberContainerWidth,
                    child: Center(
                        child: Text("${currentPage - 2}", 
                            textAlign: TextAlign.center,),
                    ),
                ),

                // If currentPage > 1, display page number prior to currentPage.
                if (currentPage > 1) 
                SizedBox(
                    width: numberContainerWidth,
                    child: Center(
                        child: Text("${currentPage - 1}", 
                            textAlign: TextAlign.center,),
                    ),
                ),

                // Displays currentPage
                SizedBox(
                    width: numberContainerWidth,
                    child: Center(
                        child: Text(
                            "$currentPage",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 22, 
                                color: AppColors.primaryColor, 
                            ),
                        ),
                    ),
                ),

                // If currentPage + 1 <= totalPages, display next page
                // Displays nothing if currentPage + 1 is greater than totalPages
                if (currentPage + 1 <= totalPages) 
                SizedBox(
                    width: numberContainerWidth,
                    child: Center(
                        child: Text("${currentPage + 1}", 
                            textAlign: TextAlign.center,),
                    ),
                ),

                // If currentPage == 1 and totalPages > 2, display the page number of the one two levels higher
                if (currentPage == 1 && totalPages > 2) 
                SizedBox(
                    width: numberContainerWidth,
                    child: Center(
                        child: Text("${currentPage + 2}", 
                            textAlign: TextAlign.center,),
                    ),
                ),
            ],
        );
    }
}