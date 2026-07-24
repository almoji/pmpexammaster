import '../services/performance_engine.dart';

class PerformanceMetrics {
  final double averageScore;
  final double readiness;
  final double readinessImprovement;
  final double consistency;
  final PerformanceTrend trend;
  final double impactScore;

  const PerformanceMetrics({
    required this.averageScore,
    required this.readiness,
    required this.readinessImprovement,
    required this.consistency,
    required this.trend,
    required this.impactScore,
  });
}