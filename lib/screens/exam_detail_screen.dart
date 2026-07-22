import 'package:flutter/material.dart';

import '../models/exam_result.dart';

class ExamDetailScreen extends StatelessWidget {
  final ExamResult result;

  const ExamDetailScreen({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Exam Details"),
      ),
      body: Center(
        child: Text(
          "${result.percentage}%",
          style: const TextStyle(
            fontSize: 40,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}