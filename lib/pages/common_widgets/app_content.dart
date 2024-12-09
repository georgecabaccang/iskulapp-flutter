import 'package:flutter/material.dart';

class AppContent extends StatelessWidget {
    final List<Widget> content;
    final bool isScrollable;

    const AppContent({
        super.key,
        required this.content,
        this.isScrollable = false,
    });

    @override
    Widget build(BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double horizontalPadding = screenWidth * 0.03; 

        return Expanded(
            child: ClipRRect(
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20.0),
                    topRight: Radius.circular(20.0),
                ),
                child: Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                    ),
                    child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
                        child: isScrollable
                            ? SingleChildScrollView(
                                child: Column(
                                    children: content,
                                ),
                            )
                            : Column(
                                children: content,
                            ),
                    )
                ),
            ),
        );
    }
}