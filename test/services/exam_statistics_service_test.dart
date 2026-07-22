import 'package:flutter_test/flutter_test.dart';
import 'package:pmp_exam_app/services/exam_statistics_service.dart';

void main() {
  test('averageScore is 0 when there are no exam results', () {
    final stats = ExamStatisticsService(
      results: [],
    );

    expect(stats.averageScore, 0);
  });
}