class CoachReasonEngine {
  const CoachReasonEngine();

  List<String> buildReasons({
    required String weakestDomain,
    required double averageScore,
    required double domainAverage,
    required double readiness,
    required double impactScore,
  }) {
    return [
      'Readiness Score: ${readiness.toStringAsFixed(1)}%',
      'Impact Score: ${impactScore.toStringAsFixed(1)}%',
      'Overall average: ${averageScore.toStringAsFixed(1)}%',
      '$weakestDomain average: ${domainAverage.toStringAsFixed(1)}%',
      'This domain currently offers the biggest improvement opportunity.',
    ];
  }
}