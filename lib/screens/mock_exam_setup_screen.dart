import 'package:flutter/material.dart';
import 'question_screen.dart';
import '../services/mock_exam_service.dart';
import '../services/premium_service.dart';
import '../widgets/premium/premium_upgrade_dialog.dart';
import '../services/ads_service.dart';

class MockExamSetupScreen extends StatelessWidget {
  const MockExamSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FE),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Mock Exam Setup",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFFEAF4FF),
              Color(0xFFF6F9FE),
              Colors.white,
            ],
            stops: [
              0,
              .22,
              .45,
            ],
          ),
        ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(22),
            child: Column(
              children: [

                const SizedBox(height: 10),

                Container(
                  width: 130,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 25,
                        spreadRadius: -6,
                        offset: const Offset(0, 12),
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.fact_check_rounded,
                    size: 70,
                    color: Color(0xFF2D86FF),
                  ),
                ),

                const SizedBox(height: 30),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(26),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 30,
                        spreadRadius: -8,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      const Center(
                        child: Text(
                          "PMP Mock Exam",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF173B7A),
                          ),
                        ),
                      ),

                      const SizedBox(height: 8),

                      const Center(
                        child: Text(
                          "Take a full-length mock exam designed to\nsimulate the real PMP certification\nexperience.",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 15,
                            color: Color(0xFF74829C),
                            height: 1.6,
                          ),
                        ),
                      ),

                      const SizedBox(height: 32),

                      Row(
                        children: [

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7FAFF),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE4ECF8),
                                ),
                              ),
                              child: const Column(
                                children: [

                                  Icon(
                                    Icons.quiz_outlined,
                                    color: Color(0xFF2D86FF),
                                  ),

                                  SizedBox(height: 10),

                                  Text(
                                    "180",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF173B7A),
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    "Questions",
                                    style: TextStyle(
                                      color: Color(0xFF74829C),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 18,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF7FAFF),
                                borderRadius: BorderRadius.circular(20),
                                border: Border.all(
                                  color: const Color(0xFFE4ECF8),
                                ),
                              ),
                              child: const Column(
                                children: [

                                  Icon(
                                    Icons.schedule_rounded,
                                    color: Color(0xFF2D86FF),
                                  ),

                                  SizedBox(height: 10),

                                  Text(
                                    "230",
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF173B7A),
                                    ),
                                  ),

                                  SizedBox(height: 4),

                                  Text(
                                    "Minutes",
                                    style: TextStyle(
                                      color: Color(0xFF74829C),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 30),

                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            elevation: 0,
                            backgroundColor: const Color(0xFF2D86FF),
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                          onPressed: () async {

                            if (!PremiumService.isPremium) {

                              final canStart =
                              await MockExamService.canStartMockExam();

                              if (!canStart) {

                                if (!context.mounted) return;

                                final upgraded = await showDialog<bool>(
                                  context: context,
                                  builder: (_) => const PremiumUpgradeDialog(
                                    title: "Mock Exam Limit Reached",
                                    message:
                                    "Free users can take one Mock Exam every 15 days.\n\nUpgrade to Premium to unlock:",
                                  ),
                                );

                                if (upgraded == true && context.mounted) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const QuestionScreen(
                                        numberOfQuestions: 5,
                                        examSeconds: 600,
                                        isMockExam: true,
                                      ),
                                    ),
                                  );
                                }

                                return;
                              }

                              await MockExamService.registerMockExam();

                            }

                            if (!context.mounted) return;

                            AdsService.resetSession();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const QuestionScreen(
                                  numberOfQuestions: 5,
                                  examSeconds: 600,
                                  isMockExam: true,
                                ),
                              ),
                            );

                          },
                          child: const Text(
                            "START MOCK EXAM",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 24),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(22),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(26),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.05),
                        blurRadius: 30,
                        spreadRadius: -8,
                        offset: const Offset(0, 14),
                      ),
                    ],
                  ),
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Icon(
                        Icons.lightbulb_rounded,
                        color: Color(0xFFF39A1E),
                      ),

                      SizedBox(width: 14),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            Text(
                              "Tips for Success",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 17,
                                color: Color(0xFF173B7A),
                              ),
                            ),

                            SizedBox(height: 8),

                            Text(
                              "This mock exam is designed to help you assess your readiness. Take your time and do your best!",
                              style: TextStyle(
                                color: Color(0xFF74829C),
                                height: 1.5,
                              ),
                            ),

                          ],
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 30),

              ],
            ),
          ),
        ),
      ),
    );
  }
}