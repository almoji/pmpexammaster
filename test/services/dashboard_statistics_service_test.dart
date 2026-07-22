import 'package:flutter_test/flutter_test.dart';

import 'package:pmp_exam_app/services/dashboard_statistics_service.dart';

void main() {
  test('globalAccuracy is 0 when there are no attempts', () {
    final stats = DashboardStatisticsService(
      attempts: [],
    );

    expect(stats.globalAccuracy, 0);
  });
}