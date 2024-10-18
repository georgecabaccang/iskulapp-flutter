import 'package:flutter/material.dart';
import 'package:school_erp/theme/text_styles.dart';

class AskDoubtCard extends StatefulWidget {
  const AskDoubtCard({Key? key}) : super(key: key);

  @override
  _AskDoubtCardState createState() => _AskDoubtCardState();
}

class _AskDoubtCardState extends State<AskDoubtCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 10.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Teacher Name',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            style: bodyStyle().copyWith(fontSize: 18),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Subject',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            style: bodyStyle().copyWith(fontSize: 18),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Title',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            style: bodyStyle().copyWith(fontSize: 18),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Doubt Description',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            maxLines: 1,
            style: bodyStyle().copyWith(fontSize: 18),
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 25),
          Center(
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5278C1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                minimumSize: const Size(double.infinity, 50),
              ),
              onPressed: () {
                print("Doubt submitted");
              },
              child: Text(
                'SEND',
                style: buttonTextStyle().copyWith(color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
