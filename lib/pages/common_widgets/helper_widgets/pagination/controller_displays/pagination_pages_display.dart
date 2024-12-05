import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/controller_displays/pagination_multiple_pages.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/controller_displays/pagination_single_page.dart';

class PagesDisplay extends StatelessWidget {
    final int currentPage;
    final int totalPages;

    const PagesDisplay({super.key, required this.currentPage, required this.totalPages});

    @override
    Widget build(BuildContext context) {

        return Expanded(
            child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 22), 
                child: totalPages == 1 
                    ? SinglePage() 
                    : MultiplePages(currentPage: currentPage, totalPages: totalPages)
            ),

        );
    }
}