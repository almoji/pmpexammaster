class QuestionAttempt {
  final int questionId;
  final DateTime timestamp;
  final bool correct;
  final List<String> selectedAnswers;
  final int elapsedSeconds;
  final bool practiceMode;
  final bool mockMode;

  QuestionAttempt({
    required this.questionId,
    required this.timestamp,
    required this.correct,
    required this.selectedAnswers,
    required this.elapsedSeconds,
    required this.practiceMode,
    required this.mockMode,
  });

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'timestamp': timestamp.toIso8601String(),
      'correct': correct,
      'selectedAnswers': selectedAnswers,
      'elapsedSeconds': elapsedSeconds,
      'practiceMode': practiceMode,
      'mockMode': mockMode,
    };
  }

  factory QuestionAttempt.fromJson(Map<String, dynamic> json) {
    return QuestionAttempt(
      questionId: json['questionId'],
      timestamp: DateTime.parse(json['timestamp']),
      correct: json['correct'],
      selectedAnswers: List<String>.from(json['selectedAnswers']),
      elapsedSeconds: json['elapsedSeconds'],
      practiceMode: json['practiceMode'],
      mockMode: json['mockMode'],
    );
  }
}