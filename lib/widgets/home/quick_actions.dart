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

        GridView.count(
          padding: EdgeInsets.zero,
          crossAxisCount: 2,
          crossAxisSpacing: 18,
          mainAxisSpacing: 18,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),

          // Más alto para evitar overflow
          childAspectRatio: 0.83,

          children: [
            _ActionCard(
              icon: Icons.menu_book_rounded,
              title: "Practice",
              subtitle: "Practice by domain\nor randomly",
              color1: const Color(0xFF63B4FF),
              color2: const Color(0xFF2D86FF),
              badge: "WORKBOOK",
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
              title: "Mock Exam",
              subtitle: "180 Questions\n230 Minutes",
              color1: const Color(0xFF5FD18D),
              color2: const Color(0xFF26A65B),
              badge: "EXAM",
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
              title: "Dashboard",
              subtitle: "Statistics\nPerformance",
              color1: const Color(0xFFFFC14D),
              color2: const Color(0xFFF39A1E),
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
              icon: Icons.psychology_alt_rounded,
              title: "Daily Coach",
              subtitle: "Personalized\nStudy Plan",
              color1: const Color(0xFFA46DFF),
              color2: const Color(0xFF7B46E3),
              badge: "AI",
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
  final String title;
  final String subtitle;
  final Color color1;
  final Color color2;
  final String? badge;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.color1,
    required this.color2,
    required this.onTap,
    this.badge,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(28),
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            color: Color.alphaBlend(
              color2.withValues(alpha: 0.20),
              Colors.white,
            ),
            borderRadius: BorderRadius.circular(28),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.05),
                blurRadius: 26,
                spreadRadius: -6,
                offset: const Offset(0, 12),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(18),
            child: Stack(
              children: [
                if (badge != null)
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 5,
                      ),
                      decoration: BoxDecoration(
                        color: color2,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        badge!,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          letterSpacing: .5,
                        ),
                      ),
                    ),
                  ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        gradient: LinearGradient(
                          colors: [
                            color1,
                            color2,
                          ],
                        ),
                      ),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 28,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Text(
                      title,
                      style: const TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B7A),
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      subtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 13,
                        color: Color(0xFF74829C),
                        height: 1.4,
                      ),
                    ),

                    const Spacer(),

                    Align(
                      alignment: Alignment.centerRight,
                      child: Container(
                        width: 36,
                        height: 36,
                        decoration: BoxDecoration(
                          color: color2.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          Icons.arrow_forward_rounded,
                          color: color2,
                          size: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}