import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'mock_exam_setup_screen.dart';
import 'practice_setup_screen.dart';
import '../widgets/home_card.dart';
import 'daily_coach_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(24),
          children: [
            Center(
              child: Column(
                children: [
                  const Icon(
                    Icons.workspace_premium,
                    size: 72,
                    color: Colors.blue,
                  ),

                  const SizedBox(height: 12),

                  const Text(
                    "PMP Exam Preparation",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 8),

                  const Text(
                    "Become PMP Certified",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 24),
                ],
              ),
            ),

            const Divider(
              thickness: 1,
            ),



        const Divider(
          thickness: 1,
        ),

        const SizedBox(height: 24),

        HomeCard(
              icon: Icons.menu_book_rounded,
              color: Colors.blue,
              title: "Practice Questions",
              subtitle: "Practice by domain or randomly",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const PracticeSetupScreen(),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),

            HomeCard(
              icon: Icons.analytics_rounded,
              color: Colors.orange,
              title: "Dashboard",
              subtitle: "Track your performance",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DashboardScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            HomeCard(
              icon: Icons.psychology_rounded,
              color: Colors.deepPurple,
              title: "Daily Coach",
              subtitle: "Your personalized AI study plan",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DailyCoachScreen(),
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            const SizedBox(height: 20),

            HomeCard(
              icon: Icons.fact_check_rounded,
              color: Colors.green,
              title: "Mock Exam",
              subtitle: "180 Questions • 230 Minutes",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const MockExamSetupScreen(),
                  ),
                );
              },
            ),


          ],
        ),
      ),
    );
  }
}