class DomainResult {

  final String domain;

  final int totalQuestions;

  final int correctAnswers;


  DomainResult({

    required this.domain,

    required this.totalQuestions,

    required this.correctAnswers,

  });


  double get percentage {

    if (totalQuestions == 0) {

      return 0;

    }

    return (correctAnswers / totalQuestions) * 100;

  }


  Map<String, dynamic> toJson() {

    return {

      "domain": domain,

      "totalQuestions": totalQuestions,

      "correctAnswers": correctAnswers,

    };

  }


  factory DomainResult.fromJson(Map<String, dynamic> json) {

    return DomainResult(

      domain: json["domain"],

      totalQuestions: json["totalQuestions"],

      correctAnswers: json["correctAnswers"],

    );

  }

}