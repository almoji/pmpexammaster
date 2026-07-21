class ExamHistory {
  final DateTime date;
  final String examType;
  final int totalQuestions;
  final int correctAnswers;
  final int incorrectAnswers;
  final int score;
  final int durationSeconds;

  ExamHistory({
    required this.date,
    required this.examType,
    required this.totalQuestions,
    required this.correctAnswers,
    required this.incorrectAnswers,
    required this.score,
    required this.durationSeconds,
  });

  Map<String, dynamic> toJson() => {
    'date': date.toIso8601String(),
    'examType': examType,
    'totalQuestions': totalQuestions,
    'correctAnswers': correctAnswers,
    'incorrectAnswers': incorrectAnswers,
    'score': score,
    'durationSeconds': durationSeconds,
  };

  factory ExamHistory.fromJson(Map<String, dynamic> json) {
    return ExamHistory(
      date: DateTime.parse(json['date']),
      examType: json['examType'],
      totalQuestions: json['totalQuestions'],
      correctAnswers: json['correctAnswers'],
      incorrectAnswers: json['incorrectAnswers'],
      score: json['score'],
      durationSeconds: json['durationSeconds'],
    );
  }
}
