import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:school_erp/widgets/formText.dart';

class FormTextData {
  final String label;
  final String value;
  final IconData? icon;
  final double width;

  FormTextData(this.label, this.value, [this.icon, this.width = 175]);
}

class MyIcons {
  static const IconData cameraAltOutlined =
      IconData(0xef1e, fontFamily: 'MaterialIcons');
}

class AnimationState {
  bool animate = false;
  bool isBackNavigation = false;

  AnimationState({
    this.animate = false,
    this.isBackNavigation = false,
  });
}

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
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
      backgroundColor: const Color(0xFF5278C1),
      body: Stack(
        children: [
          // Blue background color
          Container(
            color: const Color(0xFF5278C1),
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
                color: Colors.white,
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
                      child: profileCard(),
                    ),
                    AnimatedOpacity(
                      opacity: animationState.isBackNavigation
                          ? 0.0
                          : (animationState.animate ? 1.0 : 0.0),
                      duration: const Duration(milliseconds: 500),
                      child: profileForm(),
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
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
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
                    "My Profile",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(flex: 2),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: TextButton.icon(
                      onPressed: () {
                        print('Done button pressed');
                      },
                      icon: const Icon(
                        Icons.check,
                        color: Colors.blue,
                      ),
                      label: const Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: TextButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20.0),
                        ),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 8.0),
                      ),
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

  Widget profileCard() {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                border: Border.all(color: Colors.blue, width: 2.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Container(
                      width: 75,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: const Color.fromARGB(96, 47, 47, 47),
                      ),
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: 240,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: EdgeInsets.only(top: 8.0),
                                child: SizedBox(
                                  width: 150,
                                  child: Text(
                                    'Akshay Syal',
                                    style: TextStyle(
                                      color: Colors.black87,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                              Icon(
                                MyIcons.cameraAltOutlined,
                                size: 23,
                                color: Colors.grey,
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 5.0),
                            child: SizedBox(
                              child: Text(
                                'Class XI-B | Roll no: 04',
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 14,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget profileForm() {
    final List<List<FormTextData>> formTextDataList = [
      [
        FormTextData('Adhar No.', '1234 4325 4567 1234'),
        FormTextData('Academic Year', '2020 - 2021'),
      ],
      [
        FormTextData('Admission Class', 'VI', CupertinoIcons.lock_fill),
        FormTextData('Old Admission No.', 'T00221', CupertinoIcons.lock_fill),
      ],
      [
        FormTextData(
            'Date of Admission', '01 Apr 2018', CupertinoIcons.lock_fill),
        FormTextData('Date of Birth', '22 July 1996', CupertinoIcons.lock_fill),
      ],
      [
        FormTextData('Parent Mail ID', 'parentboth84@gmail.com',
            CupertinoIcons.lock_fill, 370),
      ],
      [
        FormTextData(
            'Mother Name', 'Monica Larson', CupertinoIcons.lock_fill, 370),
      ],
      [
        FormTextData(
            'Father Nme', 'Bernard Taylor', CupertinoIcons.lock_fill, 370),
      ],
      [
        FormTextData('Permanent Add', 'Karol Bagh, Delhi',
            CupertinoIcons.lock_fill, 370),
      ],
    ];

    return SizedBox(
      width: double.infinity,
      height: 650,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: formTextDataList.length,
        itemBuilder: (context, index) {
          return buildFormRow(formTextDataList[index]);
        },
      ),
    );
  }

  Widget buildFormRow(List<FormTextData> data) {
    return Padding(
      padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: data.map((item) {
          return FormText(
            width: item.width,
            height: 75,
            label: item.label,
            value: item.value,
            icon: item.icon != null
                ? Icon(item.icon, size: 22.0, color: Colors.grey)
                : null,
          );
        }).toList(),
      ),
    );
  }
}
