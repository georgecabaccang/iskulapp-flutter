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
  // Custom camera_alt_outlined icon with lowerCamelCase name
  static const IconData cameraAltOutlined =
      IconData(0xef1e, fontFamily: 'MaterialIcons');
}

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color(0xFF5278C1),
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(
              kToolbarHeight + 16.0), // Adjust height for padding
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: 16.0, vertical: 8.0), // Padding values
            child: AppBar(
              backgroundColor: const Color(0xFF5278C1),
              title: const Text(
                "My Profile",
                style: TextStyle(
                  color: Colors.white, // Text color
                ),
              ),
              titleSpacing: 0.0,
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white, // Icon color
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              actions: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: TextButton.icon(
                    onPressed: () {
                      print('Done button pressed');
                    },
                    icon: const Icon(
                      Icons.check,
                      color: Colors.blue, // Icon color
                    ),
                    label: const Text(
                      'Done',
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold, // Text color
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.white, // Button background color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20.0), // Rounded corners
                      ),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0), // Button padding
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(30.0),
                topRight: Radius.circular(30.0),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                profileCard(),
                profileForm(),
              ],
            ),
          ),
        ));
  }

  Widget profileCard() {
    return Row(
      children: [
        Expanded(
            child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Container(
              height: 100.0,
              decoration: BoxDecoration(
                  borderRadius: const BorderRadius.all(Radius.circular(15)),
                  border: Border.all(color: Colors.blue, width: 2.0)),
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
                                          fontSize: 20),
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
                            )
                          ],
                        )),
                  ),
                ],
              ),
            ),
          ),
        ))
      ],
    );
  }

Widget profileForm() {
  return SizedBox(
    width: double.infinity,
    child: Column(
      children: [
        buildFormRow([
          FormTextData('Adhar No.', '1234 4325 4567 1234'),
          FormTextData('Academic Year', '2020 - 2021'),
        ]),
        buildFormRow([
          FormTextData('Admission Class', 'VI', CupertinoIcons.lock_fill),
          FormTextData('Old Admission No.', 'T00221', CupertinoIcons.lock_fill),
        ]),
        buildFormRow([
          FormTextData('Date of Admission', '01 Apr 2018', CupertinoIcons.lock_fill),
          FormTextData('Date of Birth', '22 July 1996', CupertinoIcons.lock_fill),
        ]),
        buildFormRow([
          FormTextData('Parent Mail ID', 'parentboth84@gmail.com', CupertinoIcons.lock_fill, 370),
        ]),
          buildFormRow([
          FormTextData('Mother Name', 'Monica Larson', CupertinoIcons.lock_fill, 370),
        ]),
          buildFormRow([
          FormTextData('Father Name', 'Bernard Taylor', CupertinoIcons.lock_fill, 370),
        ]),
          buildFormRow([
          FormTextData('Permanent Add', 'Karol Bagh, Delhi', CupertinoIcons.lock_fill, 370),
        ]),
      ],
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
