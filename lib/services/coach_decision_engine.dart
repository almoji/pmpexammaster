import '../models/mission_type.dart';
import '../models/performance_metrics.dart';
import 'performance_engine.dart';

class CoachDecisionEngine {
  const CoachDecisionEngine();

  MissionType determineMissionType({
    required List history,
    required double averageScore,
    required double weakestDomainAverage,
    required PerformanceMetrics metrics,
  }) {
    if (history.length < 3) {
      return MissionType.onboarding;
    }

    final consistency = metrics.consistency;
    final trend = metrics.trend;

    if (weakestDomainAverage < 60) {
      return MissionType.recovery;
    }

    if (consistency < 85) {
      return MissionType.consistency;
    }

    if (trend == PerformanceTrend.declining) {
      return MissionType.recovery;
    }

    if (averageScore >= 85 &&
        trend == PerformanceTrend.stable) {
      return MissionType.maintenance;
    }

    if (trend == PerformanceTrend.improving) {
      return MissionType.challenge;
    }

    return MissionType.weakestDomain;
  }
}