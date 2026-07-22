import 'package:flutter_test/flutter_test.dart';

import 'package:pmp_exam_app/models/exam_mode.dart';
import 'package:pmp_exam_app/models/question_attempt.dart';
import 'package:pmp_exam_app/services/dashboard_statistics_service.dart';

void main() {
  test('globalAccuracy is 0 when there are no attempts', () {
    final stats = DashboardStatisticsService(
      attempts: [],
    );

    expect(stats.globalAccuracy, 0);
  });

  test('globalAccuracy is 75 with 3 correct answers out of 4', () {
    final attempts = [
      QuestionAttempt(
        questionId: 1,
        timestamp: DateTime.now(),
        correct: true,
        selectedAnswers: const [],
        elapsedSeconds: 10,
        mode: ExamMode.practice,
        domain: 'People',
      ),
      QuestionAttempt(
        questionId: 2,
        timestamp: DateTime.now(),
        correct: true,
        selectedAnswers: const [],
        elapsedSeconds: 10,
        mode: ExamMode.practice,
        domain: 'People',
      ),
      QuestionAttempt(
        questionId: 3,
        timestamp: DateTime.now(),
        correct: true,
        selectedAnswers: const [],
        elapsedSeconds: 10,
        mode: ExamMode.practice,
        domain: 'People',
      ),
      QuestionAttempt(
        questionId: 4,
        timestamp: DateTime.now(),
        correct: false,
        selectedAnswers: const [],
        elapsedSeconds: 10,
        mode: ExamMode.practice,
        domain: 'People',
      ),
    ];

    final stats = DashboardStatisticsService(
      attempts: attempts,
    );

    expect(stats.globalAccuracy, 75);
  });
}