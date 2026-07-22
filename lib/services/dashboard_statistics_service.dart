import '../models/exam_result.dart';
import '../models/question_attempt.dart';

class DashboardStatisticsService {

  final List<ExamResult> results;
  final List<QuestionAttempt> attempts;

  DashboardStatisticsService({
    required this.results,
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

}