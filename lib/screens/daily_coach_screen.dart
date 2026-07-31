import 'package:flutter/material.dart';

import '../models/daily_mission.dart';
import '../models/practice_filter.dart';
import '../services/daily_coach_service.dart';
import 'question_screen.dart';

class DailyCoachScreen extends StatelessWidget {
  DailyCoachScreen({super.key});

  final DailyCoachService _dailyCoachService = DailyCoachService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: const Text(
          "Daily Coach",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF173B7A),
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
              child: FutureBuilder<DailyMission>(
        future: _dailyCoachService.getTodaysMission(),
        builder: (context, snapshot) {
          if (snapshot.connectionState != ConnectionState.done) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (snapshot.hasError) {
            return Center(
              child: Text(
                'Unable to load today\'s mission.\n${snapshot.error}',
                textAlign: TextAlign.center,
              ),
            );
          }

          final mission = snapshot.data!;

          return _buildContent(context, mission);
        },
              ),
            ),
        ),
    );
  }

  Widget _buildContent(BuildContext context, DailyMission mission) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 14, 18, 18),

        child: Container(

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

          child: Padding(

            padding: const EdgeInsets.all(15),

            child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [


                const Text(
                  "Your Daily Coach has prepared today's recommendation based on your recent performance.",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF74829C),
                    height: 1.5,
                  ),
                ),

                const SizedBox(height: 18),

                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF1EAFF),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFD5BFFF),
                      width: 1.2,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.deepPurple.withValues(alpha: 0.08),
                        blurRadius: 18,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Row(
                        children: [

                          Container(
                            width: 60,
                            height: 60,
                            decoration: const BoxDecoration(
                              color: Color(0xFFE7D9FF),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.auto_awesome_rounded,
                              color: Color(0xFF7A4DFF),
                              size: 28,
                            ),
                          ),

                          const SizedBox(width: 16),

                          Expanded(
                            child: Text(
                              mission.title,
                              style: const TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF173B7A),
                              ),
                            ),
                          ),

                        ],
                      ),

                      const SizedBox(height: 12),

                      Text(
                        mission.description,
                        style: const TextStyle(
                          fontSize: 15,
                          color: Color(0xFF5F6C80),
                          height: 1.5,
                        ),
                      ),

                      const SizedBox(height: 10),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 8,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFE7D9FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          "+${mission.expectedReadinessGain}% Readiness",
                          style: const TextStyle(
                            color: Color(0xFF7A4DFF),
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                    ],
                  ),
                ),

                const SizedBox(height: 18),

                const Text(
                  "Why this mission?",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF173B7A),
                  ),
                ),

                const SizedBox(height: 6),

                Container(
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FBFF),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color(0xFFE6EEF8),
                    ),
                  ),
                  child: Column(
                    children: List.generate(
                      mission.reasons.length,
                          (index) {

                        final reason = mission.reasons[index];

                        return Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 18,
                            vertical: 16,
                          ),
                          decoration: BoxDecoration(
                            border: index == mission.reasons.length - 1
                                ? null
                                : const Border(
                              bottom: BorderSide(
                                color: Color(0xFFE9EEF7),
                              ),
                            ),
                          ),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              Container(
                                width: 28,
                                height: 28,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFE7D9FF),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.check,
                                  size: 16,
                                  color: Color(0xFF7A4DFF),
                                ),
                              ),

                              const SizedBox(width: 14),

                              Expanded(
                                child: Text(
                                  reason,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Color(0xFF4B5565),
                                    height: 1.5,
                                  ),
                                ),
                              ),

                            ],
                          ),
                        );
                      },
                    ),
                  ),
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 56,

                  child: ElevatedButton(

                    onPressed: () => _startMission(context, mission),

                    style: ElevatedButton.styleFrom(

                      elevation: 0,

                      backgroundColor: const Color(0xFF2D86FF),

                      foregroundColor: Colors.white,

                      shape: RoundedRectangleBorder(

                        borderRadius: BorderRadius.circular(18),

                      ),

                    ),

                    child: const Row(

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Icon(
                          Icons.play_arrow_rounded,
                          size: 22,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "START TODAY'S MISSION",
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            letterSpacing: .3,
                          ),
                        ),

                      ],

                    ),

                  ),

                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _startMission(BuildContext context, DailyMission mission) {
    switch (mission.action) {
      case MissionAction.practice:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => QuestionScreen(
              numberOfQuestions: mission.questionCount,
              examSeconds: 0,
              isMockExam: false,
              practiceFilter: PracticeFilter(
                mode: 'Practice',
                domain: mission.domain ?? 'Business Environment',
                difficulty: 'All Difficulties',
                questionType: 'All Types',
              ),
            ),
          ),
        );
        break;

      case MissionAction.mockExam:
        break;

      case MissionAction.reviewWrongAnswers:
        break;

      case MissionAction.reviewDomain:
        break;
    }
  }
}