import 'package:flutter/material.dart';

class CustomListView<T> extends StatelessWidget{
    final List<T> listOfData;
    final Widget Function(BuildContext, T) itemBuilder;

    const CustomListView({
        super.key, 
        required this.listOfData, 
        required this.itemBuilder
    });

    @override
    Widget build(BuildContext context) {
        return ListView.builder(
            itemCount: listOfData.length,
            itemBuilder:(BuildContext context, int index) {
                return  itemBuilder(context, listOfData[index]);
            },
        );
    }
}