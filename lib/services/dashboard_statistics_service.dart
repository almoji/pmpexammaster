
import '../models/question_attempt.dart';
import '../models/domain_result.dart';

class DashboardStatisticsService {


  final List<QuestionAttempt> attempts;

  DashboardStatisticsService({
    required this.attempts,
  });

  int get attemptsCorrect {
    return attempts.where((a) => a.correct).length;
  }

  int get attemptsIncorrect {

    return attempts.where((a) => !a.correct).length;

  }
  double get globalAccuracy {

    if (attempts.isEmpty) {
      return 0;
    }

    return (attemptsCorrect / attempts.length) * 100;

  }
  int get questionsPracticed {

    return attempts.length;

  }
  Map<String, DomainResult> get domainStatistics {

    final Map<String, DomainResult> domains = {};

    for (final attempt in attempts) {

      if (attempt.domain.isEmpty) continue;

      if (!domains.containsKey(attempt.domain)) {

        domains[attempt.domain] = DomainResult(
          domain: attempt.domain,
          totalQuestions: 1,
          correctAnswers: attempt.correct ? 1 : 0,
        );

      } else {

        final current = domains[attempt.domain]!;

        domains[attempt.domain] = DomainResult(
          domain: current.domain,
          totalQuestions: current.totalQuestions + 1,
          correctAnswers: current.correctAnswers + (attempt.correct ? 1 : 0),
        );

      }

    }



    return domains;

  }
  //==========================================================
  // TODAY STATISTICS
  //==========================================================

  bool _isToday(DateTime date) {
    final now = DateTime.now();

    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }

  List<QuestionAttempt> get todayAttempts {
    return attempts.where((a) => _isToday(a.timestamp)).toList();
  }

  int get questionsToday {
    return todayAttempts.length;
  }

  int get correctToday {
    return todayAttempts.where((a) => a.correct).length;
  }

  double get todayAccuracy {
    if (todayAttempts.isEmpty) {
      return 0;
    }

    return (correctToday / todayAttempts.length) * 100;
  }

  int get studyTimeToday {
    return todayAttempts.fold(
      0,
          (sum, a) => sum + a.elapsedSeconds,
    );
  }

}