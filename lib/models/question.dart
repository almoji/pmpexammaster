class Question {

  final int id;

  final String domain;

  final String difficulty;

  final String type;

  final String questionFormat;

  final String question;

  final String optionA;

  final String optionB;

  final String optionC;

  final String optionD;

  final String correctAnswer;

  final String explanation;

  String? userAnswer;


  Question({

    required this.id,

    required this.domain,

    required this.difficulty,

    required this.type,

    required this.questionFormat,

    required this.question,

    required this.optionA,

    required this.optionB,

    required this.optionC,

    required this.optionD,

    required this.correctAnswer,

    required this.explanation,

    this.userAnswer,

  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'domain': domain,
      'difficulty': difficulty,
      'type': type,
      'questionFormat': questionFormat,
      'question': question,
      'optionA': optionA,
      'optionB': optionB,
      'optionC': optionC,
      'optionD': optionD,
      'correctAnswer': correctAnswer,
      'explanation': explanation,
      'userAnswer': userAnswer,
    };
  }

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      id: json['id'],
      domain: json['domain'],
      difficulty: json['difficulty'],
      type: json['type'],
      questionFormat: json['questionFormat'] ?? 'singleChoice',
      question: json['question'],
      optionA: json['optionA'],
      optionB: json['optionB'],
      optionC: json['optionC'],
      optionD: json['optionD'],
      correctAnswer: json['correctAnswer'],
      explanation: json['explanation'],
      userAnswer: json['userAnswer'],
    );
  }

}