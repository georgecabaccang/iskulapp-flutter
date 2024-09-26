import 'package:flutter/material.dart';
import 'package:school_erp/theme/colors.dart';

class StudentItem extends StatelessWidget {
  final Student student;
  final int index;
  final VoidCallback onToggleCheck;

  const StudentItem({
    super.key,
    required this.student,
    required this.index,
    required this.onToggleCheck,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          CircleAvatar(
            backgroundImage: student.imageUrl != null
                ? NetworkImage(student.imageUrl!)
                : null,
            backgroundColor:AppColors.purple.withOpacity(0.8),
            child: student.imageUrl == null
                ? const Text(
                    'A',
                    style: TextStyle(color: AppColors.whiteColor),
                  )
                : null,
          ),
          const SizedBox(width: 16.0),
          Expanded(
            child: Text(
              student.name,
              style: const TextStyle(fontSize: 16.0),
            ),
          ),
          Text(
            student.score,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(width: 16.0),
          IconButton(
            icon: Icon(
              student.isChecked
                  ? Icons.check_circle
                  : Icons.check_circle_outline,
              color: student.isChecked ? AppColors.successColor : Colors.grey,
            ),
            onPressed: onToggleCheck,
          ),
        ],
      ),
    );
  }
}

class Student {
  final String name;
  final String score;
  final String? imageUrl;
  bool isChecked;

  Student({
    required this.name,
    required this.score,
    this.imageUrl,
    this.isChecked = false,
  });
}
