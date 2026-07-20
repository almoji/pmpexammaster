class Question {

  final int id;

  final String domain;

  final String difficulty;

  final String type;

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

    required this.question,

    required this.optionA,

    required this.optionB,

    required this.optionC,

    required this.optionD,

    required this.correctAnswer,

    required this.explanation,

    this.userAnswer,

  });

}