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
}