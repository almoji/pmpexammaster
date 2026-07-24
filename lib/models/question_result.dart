class QuestionResult {
  final int questionId;
  final String domain;
  final String difficulty;
  final String type;
  final String userAnswer;
  final String correctAnswer;

  const QuestionResult({
    required this.questionId,
    required this.domain,
    required this.difficulty,
    required this.type,
    required this.userAnswer,
    required this.correctAnswer,
  });

  bool get isCorrect => userAnswer == correctAnswer;

  Map<String, dynamic> toJson() {
    return {
      'questionId': questionId,
      'domain': domain,
      'difficulty': difficulty,
      'type': type,
      'userAnswer': userAnswer,
      'correctAnswer': correctAnswer,
    };
  }

  factory QuestionResult.fromJson(Map<String, dynamic> json) {
    return QuestionResult(
      questionId: json['questionId'],
      domain: json['domain'],
      difficulty: json['difficulty'],
      type: json['type'],
      userAnswer: json['userAnswer'],
      correctAnswer: json['correctAnswer'],
    );
  }
}