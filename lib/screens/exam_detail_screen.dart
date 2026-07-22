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
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const Text(
              "Date",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            Text(
              "${result.date.day}/${result.date.month}/${result.date.year}",
            ),

            const SizedBox(height: 24),


            const Text(
              "Score",
              style: TextStyle(
                fontSize: 18,
                color: Colors.grey,
              ),
            ),

            Text(
              "${result.percentage}%",
              style: const TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Chip(
              avatar: Icon(
                result.passed ? Icons.check_circle : Icons.cancel,
                color: Colors.white,
                size: 18,
              ),
              label: Text(
                result.passed ? "PASSED" : "FAILED",
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
              backgroundColor:
              result.passed ? Colors.green : Colors.red,
            ),

            const SizedBox(height: 24),

            Text("Questions: ${result.totalQuestions}"),
            Text("Correct: ${result.correctAnswers}"),
            Text("Incorrect: ${result.incorrectAnswers}"),

            const SizedBox(height: 32),

            const Text(
              "Performance by Domain",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 16),

            ...result.domainResults.map(
                  (domain) => Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(domain.domain),
                        Text("${domain.percentage.toStringAsFixed(0)}%"),
                      ],
                    ),

                    const SizedBox(height: 6),

                    LinearProgressIndicator(
                      value: domain.percentage / 100,
                    ),
                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}