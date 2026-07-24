import '../services/performance_engine.dart';

class PerformanceMetrics {
  final double readiness;
  final double consistency;
  final PerformanceTrend trend;
  final double impactScore;

  const PerformanceMetrics({
    required this.readiness,
    required this.consistency,
    required this.trend,
    required this.impactScore,
  });
}