import 'exam_mode.dart';

class QuestionAttempt {
  final int questionId;
  final DateTime timestamp;
  final bool correct;
  final List<String> selectedAnswers;
  final int elapsedSeconds;
  final ExamMode mode;
  final String domain;

  QuestionAttempt({
    required this.questionId,
    required this.timestamp,
    required this.correct,
    required this.selectedAnswers,
    required this.elapsedSeconds,
    required this.mode,
    required this.domain,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'timestamp': timestamp.toIso8601String(),
      'correct': correct,
      'selectedAnswers': selectedAnswers,
      'elapsedSeconds': elapsedSeconds,
      'mode': mode.name,
      'domain': domain,
    };
  }

  factory QuestionAttempt.fromJson(Map<String, dynamic> json) {
    return QuestionAttempt(
      questionId: json['questionId'],
      timestamp: DateTime.parse(json['timestamp']),
      correct: json['correct'],
      selectedAnswers: List<String>.from(json['selectedAnswers']),
      elapsedSeconds: json['elapsedSeconds'],
      mode: ExamMode.values.firstWhere(
            (e) => e.name == json['mode'],
      ),
      domain: json['domain'] ?? '',
    );
  }
}