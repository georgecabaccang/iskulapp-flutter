import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';




class AnimationState {
  bool animate = false;
  bool isBackNavigation = false;

  AnimationState({
    this.animate = false,
    this.isBackNavigation = false,
  });
}

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  late AnimationState animationState;

  @override
  void initState() {
    super.initState();
    animationState = AnimationState();
    _startAnimation();
  }

  void _startAnimation() {
    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() {
        animationState.animate = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Stack(
        children: [
          // Blue background color
          Container(
            color: AppColors.primaryColor,
          ),
          // Animated white box
          AnimatedPositioned(
            duration: const Duration(milliseconds: 1000),
            curve: Curves.easeInOut,
            top: animationState.isBackNavigation
                ? 420.5
                : (animationState.animate ? 100.0 : 380.0),
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              decoration: const BoxDecoration(
                color: AppColors.whiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0),
                ),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AnimatedOpacity(
                      opacity: animationState.isBackNavigation
                          ? 0.0
                          : (animationState.animate ? 1.0 : 0.0),
                      duration: const Duration(milliseconds: 500),
                      child: eventsCard(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Fading AppBar
          _buildFadingAppBar(context),
        ],
      ),
    );
  }

  Widget _buildFadingAppBar(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16.0, 14.0, 16.0, 0.0),
        child: Column(
          children: [
            AnimatedOpacity(
              duration: const Duration(milliseconds: 500),
              opacity: animationState.isBackNavigation
                  ? 0.0
                  : (animationState.animate ? 1.0 : 0.0),
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: AppColors.whiteColor),
                    onPressed: () {
                      setState(() {
                        animationState.isBackNavigation = true;
                      });
                      Future.delayed(const Duration(milliseconds: 800), () {
                        Navigator.pop(context);
                      });
                    },
                  ),
                  const Spacer(),
                  const Text(
                    "Events & Programs",
                    style: TextStyle(
                      color: AppColors.whiteColor,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }


Widget eventsCard(){
  return const Column(
    children: [
      Text("sample events card"),
      Text("sample events card"),
    ],
  );
}
 




}
