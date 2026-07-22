import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:pmp_exam_app/services/exam_statistics_service.dart';
import 'package:pmp_exam_app/models/exam_result.dart';

ExamResult makeResult({
  required int percentage,
  bool passed = true,
}) {
  return ExamResult(
    date: DateTime.now(),
    score: percentage,
    totalQuestions: 180,
    correctAnswers: (percentage * 180 ~/ 100),
    incorrectAnswers: 180 - (percentage * 180 ~/ 100),
    percentage: percentage,
    passed: passed,
    domainResults: const [],
  );
}

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
        makeResult(percentage: 70),
        makeResult(percentage: 90),
      ],
    );

    expect(stats.averageScore, 80);
  });

  test('bestScore returns the highest percentage', () {
    final stats = ExamStatisticsService(
      results: [
        makeResult(percentage: 70),
        makeResult(percentage: 85),
        makeResult(percentage: 92),
      ],
    );

    expect(stats.bestScore, 92);
  });

  test('status is PMP Ready when average score is at least 85', () {
    final stats = ExamStatisticsService(
      results: [
        makeResult(percentage: 90),
        makeResult(percentage: 86),
      ],
    );

    expect(stats.status, 'PMP Ready 🚀');
  });

  test('status is Good Progress when average score is between 70 and 84', () {
    final stats = ExamStatisticsService(
      results: [
        makeResult(percentage: 75),
        makeResult(percentage: 80),
      ],
    );

    expect(stats.status, 'Good Progress');
  });

  test('status is Improving when average score is between 50 and 69', () {
    final stats = ExamStatisticsService(
      results: [
        makeResult(percentage: 55),
        makeResult(percentage: 65),
      ],
    );

    expect(stats.status, 'Improving');
  });

  test('status is Needs Improvement when average score is below 50', () {
    final stats = ExamStatisticsService(
      results: [
        makeResult(percentage: 40),
        makeResult(percentage: 45),
      ],
    );

    expect(stats.status, 'Needs Improvement');
  });

  test('statusColor matches the current status', () {
    expect(
      ExamStatisticsService(
        results: [makeResult(percentage: 90)],
      ).statusColor,
      Colors.green,
    );

    expect(
      ExamStatisticsService(
        results: [makeResult(percentage: 75)],
      ).statusColor,
      Colors.lightGreen,
    );

    expect(
      ExamStatisticsService(
        results: [makeResult(percentage: 55)],
      ).statusColor,
      Colors.orange,
    );

    expect(
      ExamStatisticsService(
        results: [makeResult(percentage: 40)],
      ).statusColor,
      Colors.red,
    );
  });

}