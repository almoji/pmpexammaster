import 'package:flutter_test/flutter_test.dart';
import 'package:pmp_exam_app/services/exam_statistics_service.dart';
import 'package:pmp_exam_app/models/exam_result.dart';

void main() {
  test('averageScore is 0 when there are no exam results', () {
    final stats = ExamStatisticsService(
      results: [],
    );

    expect(stats.averageScore, 0);
  });

  test('averageScore returns the average percentage', () {
    final stats = ExamStatisticsService(
      results: [
        ExamResult(
          date: DateTime.now(),
          score: 70,
          totalQuestions: 180,
          correctAnswers: 126,
          incorrectAnswers: 54,
          percentage: 70,
          passed: true,
          domainResults: const [],
        ),
        ExamResult(
          date: DateTime.now(),
          score: 90,
          totalQuestions: 180,
          correctAnswers: 162,
          incorrectAnswers: 18,
          percentage: 90,
          passed: true,
          domainResults: const [],
        ),
      ],
    );

    expect(stats.averageScore, 80);
  });

  test('bestScore returns the highest percentage', () {
    final stats = ExamStatisticsService(
      results: [
        ExamResult(
          date: DateTime.now(),
          score: 70,
          totalQuestions: 180,
          correctAnswers: 126,
          incorrectAnswers: 54,
          percentage: 70,
          passed: true,
          domainResults: const [],
        ),
        ExamResult(
          date: DateTime.now(),
          score: 85,
          totalQuestions: 180,
          correctAnswers: 153,
          incorrectAnswers: 27,
          percentage: 85,
          passed: true,
          domainResults: const [],
        ),
        ExamResult(
          date: DateTime.now(),
          score: 92,
          totalQuestions: 180,
          correctAnswers: 166,
          incorrectAnswers: 14,
          percentage: 92,
          passed: true,
          domainResults: const [],
        ),
      ],
    );

    expect(stats.bestScore, 92);
  });

}