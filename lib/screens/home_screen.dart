import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'mock_exam_setup_screen.dart';
import 'practice_setup_screen.dart';
import 'question_attempt_debug_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "PMP Exam Preparation",
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              "Welcome to PMP Exam",
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 40),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PracticeSetupScreen(),
                  ),
                );
              },
              child: const Text(
                "Practice Questions",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                );
              },
              child: const Text(
                "Dashboard",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MockExamSetupScreen(),
                  ),
                );
              },
              child: const Text(
                "Mock Exam",
              ),
            ),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                    const QuestionAttemptDebugScreen(),
                  ),
                );
              },
              child: const Text(
                "Question Attempts (Debug)",
              ),
            ),
          ],
        ),
      ),
    );
  }
}