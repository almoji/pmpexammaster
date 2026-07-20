import 'domain_result.dart';

class ExamResult {
  final DateTime date;
  final int score;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final int percentage;
  final bool passed;
  final List<DomainResult> domainResults;

  ExamResult({
    required this.date,
    required this.score,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.percentage,
    required this.passed,
    required this.domainResults,
  });


  Map<String, dynamic> toJson() {
    return {
      'date': date.toIso8601String(),
      'score': score,
      'totalQuestions': totalQuestions,
      'correctAnswers': correctAnswers,
      'incorrectAnswers': incorrectAnswers,
      'percentage': percentage,
      'passed': passed,

      'domainResults':
      domainResults
          .map((item) => item.toJson())
          .toList(),
    };
  }


  factory ExamResult.fromJson(Map<String, dynamic> json) {

    return ExamResult(

      date: DateTime.parse(json['date']),

      score: json['score'],

      totalQuestions: json['totalQuestions'],

      correctAnswers: json['correctAnswers'],

      incorrectAnswers: json['incorrectAnswers'],

      percentage: json['percentage'],

      passed: json['passed'],


      domainResults:
      (json['domainResults'] as List<dynamic>? ?? [])
          .map(
            (item) => DomainResult.fromJson(item),
      )
          .toList(),

    );
  }
}