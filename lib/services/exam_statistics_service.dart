import '../models/exam_result.dart';

class ExamStatisticsService {

  final List<ExamResult> results;

  ExamStatisticsService({
    required this.results,
  });

  double get averageScore {

    if (results.isEmpty) {
      return 0;
    }

    final total = results.fold<int>(
      0,
          (sum, result) => sum + result.percentage,
    );

    return total / results.length;

  }

  int get bestScore {

    if (results.isEmpty) {
      return 0;
    }

    return results
        .map((result) => result.percentage)
        .reduce((a, b) => a > b ? a : b);

  }

}