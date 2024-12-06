import 'package:flutter/material.dart';
import 'package:school_erp/pages/common_widgets/animation_widgets/loading_overlay.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/pagination_controller.dart';
import 'package:school_erp/pages/common_widgets/helper_widgets/pagination/pagination_list.dart';

class Pagination<T> extends StatefulWidget {
    final List<T> listOfData;
    final Widget Function(BuildContext, T) itemBuilder;
    final int itemsPerPage;
    final bool isLoading;

    const Pagination({
        super.key,
        required this.listOfData,
        required this.itemBuilder,
        required this.itemsPerPage,
        required this.isLoading,
    });

    @override
    createState() => _PaginationState<T>();
}

class _PaginationState<T> extends State<Pagination<T>> {
    final PageController _pageController = PageController();
    int currentPage = 1;

    @override
    void dispose() {
        _pageController.dispose();
        super.dispose();
    }

    @override
    Widget build(BuildContext context) {
        int totalPages = (widget.listOfData.length / widget.itemsPerPage).ceil();

        if (widget.listOfData.isEmpty && widget.isLoading) {
            return Expanded(child: Center(child: LoadingOverlay()));
        }

        if (widget.listOfData.isEmpty) {
            return Expanded(child: Center(child: Text("Empty List")));
        }

        return Expanded(
            child: Column(
                children: [
                    PaginationList(
                        pageController: _pageController,
                        onPageChanged: (page) {
                            setState(() {
                                    currentPage = page + 1;
                                });
                        },
                        listOfData: widget.listOfData,
                        itemBuilder: widget.itemBuilder,
                        itemsPerPage: widget.itemsPerPage,
                        isLoading: widget.isLoading,
                    ),
                    PaginationController(
                        currentPage: currentPage,
                        totalPages: totalPages,
                        prevPageFn: () {
                            setState(() {
                                    currentPage -= 1;
                                    _pageController.previousPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                    );
                                });
                        },
                        nextPageFn: () {
                            setState(() {
                                    currentPage += 1;
                                    _pageController.nextPage(
                                        duration: Duration(milliseconds: 300),
                                        curve: Curves.easeInOut,
                                    );
                                });
                        },
                    ),

                ],
            ),
        );
    }
}
