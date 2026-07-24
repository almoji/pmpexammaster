import 'dart:math';

import '../models/performance_metrics.dart';


enum PerformanceTrend {
  improving,
  stable,
  declining,
}

class PerformanceEngine {
  const PerformanceEngine();

  double calculateConsistency(List history) {
    if (history.length < 2) {
      return 100;
    }

    final scores = history
        .map((e) => e.percentage.toDouble())
        .toList();

    final average =
        scores.reduce((a, b) => a + b) / scores.length;

    double variance = 0;

    for (final score in scores) {
      variance += pow(score - average, 2).toDouble();
    }

    variance /= scores.length;

    final deviation = sqrt(variance);

    return (100 - deviation).clamp(0, 100).toDouble();
  }

  PerformanceTrend calculateTrend(List history) {
    if (history.length < 3) {
      return PerformanceTrend.stable;
    }

    final recentScores = history
        .skip(history.length - 3)
        .map((e) => e.percentage.toDouble())
        .toList();

    final first = recentScores.first;
    final last = recentScores.last;

    if (last - first >= 5) {
      return PerformanceTrend.improving;
    }

    if (first - last >= 5) {
      return PerformanceTrend.declining;
    }

    return PerformanceTrend.stable;
  }

  double calculateReadiness(List history) {
    if (history.isEmpty) {
      return 0;
    }

    final averageScore =
        history.map((e) => e.percentage).reduce((a, b) => a + b) /
            history.length;

    final consistency = calculateConsistency(history);

    final trend = calculateTrend(history);

    double trendScore;

    switch (trend) {
      case PerformanceTrend.improving:
        trendScore = 100;

      case PerformanceTrend.stable:
        trendScore = 75;

      case PerformanceTrend.declining:
        trendScore = 50;
    }

    final readiness =
        (averageScore * 0.50) +
            (consistency * 0.30) +
            (trendScore * 0.20);

    return readiness.clamp(0, 100).toDouble();
  }


  PerformanceMetrics calculateMetrics(List history) {
    final consistency = calculateConsistency(history);
    final trend = calculateTrend(history);
    final readiness = calculateReadiness(history);
    double readinessImprovement = 0;

    if (history.length >= 2) {
      final previousReadiness = calculateReadiness(
        history.sublist(0, history.length - 1),
      );

      readinessImprovement = readiness - previousReadiness;
    }


    final impactScore = _calculateImpactScore(
      readinessImprovement: readinessImprovement,
      consistency: consistency,
    );

    final averageScore = history.isEmpty
        ? 0.0
        : history
        .map((e) => e.percentage.toDouble())
        .reduce((a, b) => a + b) /
        history.length;

    return PerformanceMetrics(
      averageScore: averageScore,
      readiness: readiness,
      readinessImprovement: readinessImprovement,
      consistency: consistency,
      trend: trend,
      impactScore: impactScore,
    );
  }
  double _calculateImpactScore({
    required double readinessImprovement,
    required double consistency,
  }) {
    final normalizedReadinessScore =
    ((readinessImprovement + 10).clamp(0, 20) * 5);

    final impact =
        (normalizedReadinessScore * 0.8) +
            (consistency * 0.2);

    return impact.clamp(0, 100).toDouble();
  }
}
