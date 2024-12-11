import 'package:flutter/material.dart';

class PaginationList<T> extends StatelessWidget {
    final List<T> listOfData;
    final Widget Function(BuildContext, T) itemBuilder;
    final int itemsPerPage;
    final bool isLoading;
    final PageController pageController;
    final void Function(int) onPageChanged;

    const PaginationList({
        super.key,
        required this.listOfData,
        required this.itemBuilder,
        required this.itemsPerPage,
        required this.isLoading,
        required this.pageController, 
        required this.onPageChanged,
    });

    @override
    Widget build(BuildContext context) {
        return Expanded(
            flex: 90,
            child: PageView.builder(
                controller: pageController,
                onPageChanged: (page) {
                    onPageChanged(page);
                },
                itemCount: (listOfData.isEmpty && isLoading) ? 1 : (listOfData.length / itemsPerPage).ceil(),
                itemBuilder: (BuildContext context, int pageIndex) {
                    int startIndex = pageIndex * itemsPerPage;
                    int endIndex = (startIndex + itemsPerPage) > listOfData.length
                        ? listOfData.length
                        : startIndex + itemsPerPage;

                    return AnimatedBuilder(
                        animation: pageController,
                        builder: (context, child) {
                            double scale = 1.0;
                            if (pageController.position.haveDimensions) {
                                scale = pageController.page == pageIndex
                                    ? 1.0  
                                    : 0.96; 
                            }

                            return Transform.scale(
                                scale: scale,
                                child: ListView.builder(
                                    key: ValueKey<int>(pageIndex),
                                    itemCount: endIndex - startIndex,
                                    itemBuilder: (BuildContext context, int index) {
                                        int itemIndex = startIndex + index;
                                        return itemBuilder(context, listOfData[itemIndex]);
                                    },
                                ),
                            );
                        },
                    );
                },
            ),
        );
    }
}