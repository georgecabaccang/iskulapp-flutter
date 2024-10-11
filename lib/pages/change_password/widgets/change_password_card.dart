import 'package:flutter/material.dart';
import 'package:school_erp/theme/text_styles.dart';

class ChangePasswordCard extends StatelessWidget {
  const ChangePasswordCard({Key? key}) : super(key: key);

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
              labelText: 'Current Password',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            style: bodyStyle().copyWith(fontSize: 18),
            obscureText: true, // Hide password input
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'New Password',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            style: bodyStyle().copyWith(fontSize: 18),
            obscureText: true, // Hide password input
          ),
          const Divider(color: Color(0xFFA5A5A5)),
          const SizedBox(height: 16.0),
          TextField(
            decoration: InputDecoration(
              labelText: 'Confirm New Password',
              labelStyle:
                  bodyStyle().copyWith(color: Colors.grey, fontSize: 18),
              hintText: '--',
              floatingLabelBehavior: FloatingLabelBehavior.always,
              border: InputBorder.none,
            ),
            maxLines: 1,
            style: bodyStyle().copyWith(fontSize: 18),
            obscureText: true, // Hide password input
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
                // Submit change password logic here
              },
              child: Text(
                'CHANGE PASSWORD',
                style: buttonTextStyle().copyWith(color: Colors.white),
              ),
            ),
          )
        ],
      ),
    );
  }
}
