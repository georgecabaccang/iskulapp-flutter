import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:school_erp/pages/common_widgets/custom_app_bar.dart';
import 'package:school_erp/pages/assignment/widgets/assignment_animation_manager.dart';


class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  _EventsPageState createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> with SingleTickerProviderStateMixin  {
  late AssignmentAnimationManager animationManager;
  List<dynamic> events = [];

  @override
  void initState() {
    super.initState();
    loadJsonData(); 
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
  
  Future<void> loadJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/events.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      events = jsonData;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(   appBar: CustomAppBar(
        title: "Events & Programs",
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
                          ...events.map((event) => eventsCard(event)),
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


Widget eventsCard(Map<String, dynamic> event) {
  return Padding(
    padding: const EdgeInsets.only(left: 10.0, right: 10.0),
    child: FractionallySizedBox(
      widthFactor: 1, 
      child: Card(
        margin: const EdgeInsets.symmetric(vertical: 10),
        elevation: 1,
        color: AppColors.whiteColor,
        shape: RoundedRectangleBorder(
          side: const BorderSide(color: Colors.grey, width: 0.5), 
          borderRadius: BorderRadius.circular(20.0), 
        ),  
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event['title'],
                style: headingStyle().copyWith(color: Colors.black, fontSize: 18),
              ),    
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    height: 75,
                    width: 75,
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300, 
                      borderRadius: BorderRadius.circular(8.0), 
                    ),
                  ),
                  const SizedBox(height: 10, width: 10), 
                  Expanded( 
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start, 
                      mainAxisSize: MainAxisSize.min, 
                      children: [
                        Row( 
                          children: [
                            const Icon(
                              Icons.access_time, 
                              color: AppColors.primaryColor, 
                              size: 16, 
                            ),
                            const SizedBox(width: 5), 
                            Text(
                              '${event['date']}, ${event['time']}',
                              style: bodyStyle().copyWith(color: AppColors.primaryColor),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
                        Text(
                          event['description'],
                          softWrap: true, 
                          maxLines: 3, 
                          overflow: TextOverflow.ellipsis, 
                          style: bodyStyle().copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    ),
  );
}





}
