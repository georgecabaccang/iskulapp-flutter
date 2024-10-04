import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';
import 'package:school_erp/theme/text_styles.dart';
import 'dart:convert';
import 'package:flutter/services.dart';



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
  List<dynamic> events = [];

  @override
  void initState() {
    super.initState();
    loadJsonData(); 
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

  Future<void> loadJsonData() async {
    final String jsonString = await rootBundle.loadString('assets/events.json');
    final List<dynamic> jsonData = json.decode(jsonString);
    setState(() {
      events = jsonData;
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
                      child: Column(
                        children: [
                          ...events.map((event) => eventsCard(event)).toList(),
                        ],
                      )
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
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: AppColors.whiteColor),
                  onPressed: () {
                    setState(() {
                      animationState.isBackNavigation = true;
                    });
                    Future.delayed(const Duration(milliseconds: 800), () {
                      Navigator.pop(context);
                    });
                  },
                ),
                const SizedBox(width: 10), 
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
