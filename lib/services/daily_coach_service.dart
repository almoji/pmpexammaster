import 'dart:math';

import '../models/daily_mission.dart';
import '../models/domain_result.dart';
import 'history_service.dart';

enum MissionType {
  onboarding,
  recovery,
  weakestDomain,
  consistency,
  challenge,
  maintenance,
}

enum PerformanceTrend {
  improving,
  stable,
  declining,
}



class DailyCoachService {
  final HistoryService _historyService = HistoryService();

  DailyCoachService();

  Future<DailyMission> getTodaysMission() async {
    final history = await _historyService.getResults();

    if (history.isEmpty) {
      return const DailyMission(
        title: 'Start Your PMP Journey',
        description: '20 Practice Questions',
        reasons: [
          'No study history found',
          'Build your baseline performance',
          'Create your first readiness score',
        ],
        action: MissionAction.practice,
        domain: 'Business Environment',
        questionCount: 20,
        expectedReadinessGain: 3,
      );
    }

    final weakestDomain = _findWeakestDomain(history);

    final averageScore =
        history.map((e) => e.percentage).reduce((a, b) => a + b) /
            history.length;

    final domainAverage = _getDomainAverage(
      history,
      weakestDomain,
    );

    final readiness = _calculateReadiness(history);


    final missionType = _determineMissionType(
      history,
      averageScore,
      domainAverage,
    );

    final reasons = _buildReasons(
      history,
      weakestDomain,
      averageScore,
      domainAverage,
      readiness,
    );

    final questionCount = _recommendedQuestionCount(domainAverage);



    switch (missionType) {
      case MissionType.onboarding:
        return DailyMission(
          title: 'Build Your Foundation',
          description: '20 Practice Questions',
          reasons: reasons,
          action: MissionAction.practice,
          domain: weakestDomain,
          questionCount: 20,
          expectedReadinessGain: 5,
        );

      case MissionType.recovery:
        return DailyMission(
          title: 'Recover $weakestDomain',
          description: '$questionCount Practice Questions',
          reasons: reasons,
          action: MissionAction.practice,
          domain: weakestDomain,
          questionCount: questionCount,
          expectedReadinessGain: 4,
        );

      case MissionType.challenge:
        return DailyMission(
          title: 'Challenge Yourself',
          description: '15 Practice Questions',
          reasons: reasons,
          action: MissionAction.practice,
          domain: weakestDomain,
          questionCount: 15,
          expectedReadinessGain: 2,
        );

      case MissionType.maintenance:
        return DailyMission(
          title: 'Maintain Your Performance',
          description: '10 Practice Questions',
          reasons: reasons,
          action: MissionAction.practice,
          domain: weakestDomain,
          questionCount: 10,
          expectedReadinessGain: 1,
        );

      case MissionType.consistency:
        return DailyMission(
          title: 'Improve Your Consistency',
          description: '20 Practice Questions',
          reasons: reasons,
          action: MissionAction.practice,
          domain: weakestDomain,
          questionCount: 20,
          expectedReadinessGain: 3,
        );

      case MissionType.weakestDomain:
        return DailyMission(
          title: 'Practice $weakestDomain',
          description: '$questionCount Practice Questions',
          reasons: reasons,
          action: MissionAction.practice,
          domain: weakestDomain,
          questionCount: questionCount,
          expectedReadinessGain: 3,
        );
    }
  }

  String _findWeakestDomain(List history) {
    final Map<String, double> totalPercentage = {};
    final Map<String, int> attempts = {};
    final Map<String, DateTime> lastPractice = {};

    for (final exam in history) {
      for (final DomainResult domain in exam.domainResults) {
        totalPercentage[domain.domain] =
            (totalPercentage[domain.domain] ?? 0) + domain.percentage;

        attempts[domain.domain] =
            (attempts[domain.domain] ?? 0) + 1;

        final current = lastPractice[domain.domain];

        if (current == null || exam.date.isAfter(current)) {
          lastPractice[domain.domain] = exam.date;
        }
      }
    }

    final now = DateTime.now();

    String bestDomain = 'Business Environment';
    double bestPriority = -1;

    totalPercentage.forEach((domain, total) {
      final average = total / attempts[domain]!;

      final weaknessScore = 100 - average;

      final daysSincePractice =
      now.difference(lastPractice[domain]!).inDays.toDouble();

      final recencyScore =
          (daysSincePractice.clamp(0, 30) / 30) * 100;

      final priority =
          (weaknessScore * 0.7) +
              (recencyScore * 0.3);

      if (priority > bestPriority) {
        bestPriority = priority;
        bestDomain = domain;
      }
    });

    return bestDomain;
  }

  double _getDomainAverage(
      List history,
      String domainName,
      ) {
    double total = 0;
    int count = 0;

    for (final exam in history) {
      for (final DomainResult domain in exam.domainResults) {
        if (domain.domain == domainName) {
          total += domain.percentage;
          count++;
        }
      }
    }

    if (count == 0) {
      return 0;
    }

    return total / count;
  }

  int _recommendedQuestionCount(double domainAverage) {
    if (domainAverage >= 85) {
      return 10;
    }

    if (domainAverage >= 70) {
      return 20;
    }

    return 30;
  }

  double _calculateConsistency(List history) {
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

  PerformanceTrend _calculateTrend(List history) {
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

  double _calculateReadiness(List history) {
    if (history.isEmpty) {
      return 0;
    }

    final averageScore =
        history.map((e) => e.percentage).reduce((a, b) => a + b) /
            history.length;

    final consistency = _calculateConsistency(history);

    final trend = _calculateTrend(history);

    double trendScore;

    switch (trend) {
      case PerformanceTrend.improving:
        trendScore = 100;
        break;

      case PerformanceTrend.stable:
        trendScore = 75;
        break;

      case PerformanceTrend.declining:
        trendScore = 50;
        break;
    }

    final readiness =
        (averageScore * 0.50) +
            (consistency * 0.30) +
            (trendScore * 0.20);

    return readiness.clamp(0, 100).toDouble();
  }

  MissionType _determineMissionType(
      List history,
      double averageScore,
      double weakestDomainAverage,
      ) {
    if (history.length < 3) {
      return MissionType.onboarding;
    }

    final consistency = _calculateConsistency(history);
    final trend = _calculateTrend(history);

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

  List<String> _buildReasons(
      List history,
      String weakestDomain,
      double averageScore,
      double domainAverage,
      double readiness,
      ) {
    return [
      'Readiness Score: ${readiness.toStringAsFixed(1)}%',
      'Overall average: ${averageScore.toStringAsFixed(1)}%',
      '$weakestDomain average: ${domainAverage.toStringAsFixed(1)}%',
      'This domain currently offers the biggest improvement opportunity.',
    ];
  }
}