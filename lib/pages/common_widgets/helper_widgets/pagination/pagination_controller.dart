import 'package:flutter/material.dart';

class PaginationController extends StatelessWidget {
  final int currentPage;
  final int currentIndex;
  final int itemsPerPage;
  final int totalPages;
  final void Function() prevPageFn;
  final void Function() nextPageFn;

  const PaginationController({
    super.key,
    required this.currentPage,
    required this.currentIndex,
    required this.itemsPerPage,
    required this.totalPages,
    required this.prevPageFn,
    required this.nextPageFn,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 10,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  if (currentPage > 1) {
                    prevPageFn();
                  }
                },
                child: Text('Prev'),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text("$currentPage / $totalPages"),
              ),
              ElevatedButton(
                onPressed: () {
                  if (currentPage < totalPages) {
                    nextPageFn();
                  }
                },
                child: Text('Next'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
