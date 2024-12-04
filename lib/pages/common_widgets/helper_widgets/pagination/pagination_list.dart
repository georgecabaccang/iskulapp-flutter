import 'package:flutter/material.dart';

class PaginationList<T> extends StatelessWidget {
  final List<T> listOfData;
  final Widget Function(BuildContext, T) itemBuilder;
  final int itemsPerPage;
  final bool isLoading;
  final int currentIndex;

  const PaginationList(
      {super.key,
      required this.listOfData,
      required this.itemBuilder,
      required this.itemsPerPage,
      required this.isLoading,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 90,
      child: ListView.builder(
        itemCount: listOfData.isEmpty && isLoading ? 1 : itemsPerPage,
        itemBuilder: (BuildContext context, int index) {
          if (listOfData.isEmpty && isLoading) {
            return Center(child: CircularProgressIndicator());
          }

          int itemIndex = currentIndex + index;
          if (itemIndex < listOfData.length) {
            return itemBuilder(context, listOfData[itemIndex]);
          } else {
            return SizedBox.shrink();
          }
        },
      ),
    );
  }
}
