import 'package:flutter/material.dart';

import 'dashboard_screen.dart';
import 'mock_exam_setup_screen.dart';
import 'practice_setup_screen.dart';
import '../widgets/home_card.dart';
import 'daily_coach_screen.dart';
import '../theme/app_colors.dart';
import '../theme/app_spacing.dart';
import '../theme/app_text_styles.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});


  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            horizontal: 22,
            vertical: 26,
          ),
          children: [
            Center(
              child: Column(
                children: [

                  const Icon(
                    Icons.menu_book_rounded,
                    size: 60,
                    color: AppColors.primary,
                  ),

                  const SizedBox(height: 14),

                  const Text(
                    "PMP Exam Master",
                    style: AppTextStyles.pageTitle,
                  ),

                  AppSpacing.vSpaceSm,

                  const Text(
                    "Prepare • Practice • Pass",
                    style: AppTextStyles.bodySecondary,
                  ),
                  AppSpacing.vSpaceLg,
                ],
              ),
            ),



        const SizedBox(height: 12),

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
            const SizedBox(height: 10),

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

            const SizedBox(height: 10),

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

            const SizedBox(height: 10),


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