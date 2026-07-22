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

}