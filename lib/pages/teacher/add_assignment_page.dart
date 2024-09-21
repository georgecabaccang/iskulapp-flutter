import 'package:flutter/material.dart';

class AddAssignmentPage extends StatefulWidget {
  const AddAssignmentPage({super.key});

  @override
  _AddAssignmentPageState createState() => _AddAssignmentPageState();
}

class _AddAssignmentPageState extends State<AddAssignmentPage> {
  String dropdownValue = 'Passed'; // Initial value for the dropdown

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Assignment'),
        backgroundColor: const Color(0xFF5278C1), // Custom color for the app bar
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Add Assignment Status',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            DropdownButtonFormField<String>(
              value: dropdownValue,
              icon: const Icon(Icons.arrow_downward),
              decoration: const InputDecoration(
                labelText: 'Assignment Status',
                border: OutlineInputBorder(),
              ),
              items: <String>['Passed', 'Failed']
                  .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  dropdownValue = newValue!;
                });
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Add your save logic here
              },
              child: const Text('Save Assignment'),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF5278C1), // Matching button color
              ),
            ),
          ],
        ),
      ),
    );
  }
}
