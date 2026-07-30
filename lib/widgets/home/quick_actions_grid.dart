import 'package:flutter/material.dart';

import '../../screens/dashboard_screen.dart';
import '../../screens/daily_coach_screen.dart';
import '../../screens/mock_exam_setup_screen.dart';
import '../../screens/practice_setup_screen.dart';

class QuickActions extends StatelessWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        const Text(
          "Quick Actions",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Color(0xFF162D6A),
          ),
        ),

        const SizedBox(height: 16),

        GridView.count(
          crossAxisCount: 2,
          crossAxisSpacing: 14,
          mainAxisSpacing: 14,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          childAspectRatio: 1.22,
          children: [

            _ActionCard(
              icon: Icons.menu_book_rounded,
              iconColor: const Color(0xff5B8DFF),
              background: const Color(0xffF5F8FF),
              title: "Practice\nQuestions",
              subtitle: "Practice by domain\nor randomly",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const PracticeSetupScreen(),
                  ),
                );
              },
            ),

            _ActionCard(
              icon: Icons.fact_check_rounded,
              iconColor: const Color(0xff55C776),
              background: const Color(0xffF3FBF4),
              title: "Mock Exam",
              subtitle: "180 Questions\n• 230 Minutes",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const MockExamSetupScreen(),
                  ),
                );
              },
            ),

            _ActionCard(
              icon: Icons.bar_chart_rounded,
              iconColor: const Color(0xffF6A31E),
              background: const Color(0xffFFF8EE),
              title: "Dashboard",
              subtitle: "Track your\nperformance",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const DashboardScreen(),
                  ),
                );
              },
            ),

            _ActionCard(
              icon: Icons.psychology_rounded,
              iconColor: const Color(0xff8D5DE8),
              background: const Color(0xffF8F2FF),
              title: "Daily Coach",
              subtitle: "Your personalized\nAI study plan",
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => DailyCoachScreen(),
                  ),
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final Color iconColor;
  final Color background;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.iconColor,
    required this.background,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(22),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: background,
          borderRadius: BorderRadius.circular(22),
          border: Border.all(
            color: Colors.grey.shade200,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 14,
              offset: const Offset(0, 5),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              width: 54,
              height: 54,
              decoration: BoxDecoration(
                color: iconColor,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: Colors.white,
                size: 28,
              ),
            ),

            const SizedBox(width: 10),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff162D6A),
                      height: 1.1,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xff6B7793),
                      height: 1.25,
                    ),
                  ),

                  const Spacer(),

                  Align(
                    alignment: Alignment.bottomRight,
                    child: Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: iconColor,
                      size: 20,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}