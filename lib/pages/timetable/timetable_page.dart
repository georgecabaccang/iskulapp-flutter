import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/assignment/widgets/assignment_animation_manager.dart';


class TimeTablePage extends StatefulWidget {
  const TimeTablePage({super.key});

  @override
  _TimeTablePageState createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> with SingleTickerProviderStateMixin  {
  late AssignmentAnimationManager animationManager;
  List<dynamic> events = [];

  @override
  void initState() {
    super.initState();
    // loadJsonData(); 
    animationManager = AssignmentAnimationManager(vsync:this);
    _startAnimation();
  }

  void _startAnimation() {
    animationManager.startAnimation();
  }


  void _handleBackPress() {
    animationManager.reverseAnimation();
    Future.delayed(animationManager.duration, () {
      if (mounted) {
        Navigator.pop(context);
      }
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(   appBar: CustomAppBar(
        title: "Assignment List",
        fadeAnimation: animationManager.fadeAnimation,
        onBackPressed: _handleBackPress,
      ),
      body: Stack(
        children: [
          Container(color: AppColors.primaryColor),
          AnimatedBuilder(
            animation: animationManager.controller,
            builder: (context, child) {
              return Positioned(
                top: animationManager.topPosition,
                left: 0,
                right: 0,
                bottom: 0,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30.0),
                      topRight: Radius.circular(30.0),
                    ),
                  ),
                  child: FadeTransition(
                    opacity: animationManager.fadeAnimation,
                    child: child ?? Container(),
                  ),
                ),
              );
            },
            child: Column(
              children: [
                const SizedBox(height: 25),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16.0),
                    children: [
                          //put content here
                        ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }



 



}
