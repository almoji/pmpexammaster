import '../models/daily_mission.dart';
import '../models/domain_result.dart';

  import 'history_service.dart';
  import 'performance_engine.dart';
import '../models/mission_type.dart';
import 'coach_decision_engine.dart';
import 'coach_reason_engine.dart';



  class DailyCoachService {
    final HistoryService _historyService = HistoryService();
    final PerformanceEngine _performanceEngine = const PerformanceEngine();
    final CoachDecisionEngine _coachDecisionEngine =
    const CoachDecisionEngine();
    final CoachReasonEngine _coachReasonEngine =
    const CoachReasonEngine();

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

    final metrics = _performanceEngine.calculateMetrics(history);

    final readiness = metrics.readiness;
    final impactScore = metrics.impactScore;

    final missionType = _coachDecisionEngine.determineMissionType(
      history: history,
      averageScore: averageScore,
      weakestDomainAverage: domainAverage,
      metrics: metrics,
    );

    final reasons = _coachReasonEngine.buildReasons(
      weakestDomain: weakestDomain,
      averageScore: averageScore,
      domainAverage: domainAverage,
      readiness: readiness,
      impactScore: impactScore,
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


}