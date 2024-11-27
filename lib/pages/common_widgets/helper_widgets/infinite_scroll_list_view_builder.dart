import 'package:flutter/material.dart';

class InfiniteScrollListView<T> extends StatefulWidget {
  final List<T> listOfData;
  final Widget Function(BuildContext, T) itemBuilder;
  final int currentOffset;
  final bool isLoading;
  final Function() loadMoreData;

  const InfiniteScrollListView({
    super.key,
    required this.listOfData,
    required this.itemBuilder,
    required this.currentOffset,
    required this.isLoading,
    required this.loadMoreData,
  });

  @override
  createState() => _InfiniteScrollListViewState<T>();
}

class _InfiniteScrollListViewState<T> extends State<InfiniteScrollListView<T>> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_scrollListener);
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels ==
        _scrollController.position.maxScrollExtent) {
      if (!widget.isLoading) {
        widget.loadMoreData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: _scrollController,
        itemCount: widget.listOfData.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == widget.listOfData.length) {
            return widget.isLoading
                ? Center(child: CircularProgressIndicator())
                : SizedBox.shrink();
          }

          return widget.itemBuilder(context, widget.listOfData[index]);
        },
      ),
    );
  }
}
