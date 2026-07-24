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
        title: const Text('Daily Coach'),
      ),
      body: FutureBuilder<DailyMission>(
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
    );
  }

  Widget _buildContent(BuildContext context, DailyMission mission) {
    return Padding(
      padding: const EdgeInsets.all(24),
      child: Card(
        elevation: 3,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Good morning 👋',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 8),

                const Text(
                  "Your Daily Coach has prepared today's recommendation.",
                ),

                const SizedBox(height: 24),

                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          mission.title,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(mission.description),
                        const SizedBox(height: 16),
                        Text(
                          "+${mission.expectedReadinessGain}% Readiness",
                          style: const TextStyle(
                            color: Colors.green,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                const Text(
                  "Why this mission?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 12),

                ...mission.reasons.map(
                      (reason) => ListTile(
                    leading: const Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    title: Text(reason),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),

                const SizedBox(height: 24),

                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => _startMission(context, mission),
                    child: const Padding(
                      padding: EdgeInsets.symmetric(vertical: 16),
                      child: Text("START TODAY'S MISSION"),
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