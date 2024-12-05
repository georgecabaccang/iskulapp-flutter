import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/buttons/primary_round_elevated_button.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/controller_displays/pagination_pages_display.dart';

class PaginationController extends StatelessWidget {
    final int currentPage;
    final int totalPages;
    final void Function() prevPageFn;
    final void Function() nextPageFn;

    const PaginationController({
        super.key,
        required this.currentPage,
        required this.totalPages,
        required this.prevPageFn,
        required this.nextPageFn,
    });

    @override
    Widget build(BuildContext context) {
        return Expanded(
            flex: 10,
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 10), 
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                        PrimaryRoundElevatedButton(
                            buttonFn: () {
                                if (currentPage > 1) {
                                    prevPageFn();
                                }
                            },
                            icon: Icon(
                                Icons.chevron_left,
                                size: 30,
                            ),
                            iconPosition: IconPosition.left,
                            isDisabled: currentPage == 1 ? true : false,
                        ),
                        PagesDisplay(currentPage: currentPage, totalPages: totalPages,),
                        PrimaryRoundElevatedButton(
                            buttonFn: () {
                                if (currentPage < totalPages) {
                                    nextPageFn();
                                }
                            },
                            icon: Icon(
                                Icons.chevron_right,
                                size: 30,
                            ),
                            iconPosition: IconPosition.left,
                            isDisabled: currentPage == totalPages ? true : false,
                        ),
                    ],
                ),
            )
        );
    }
}


