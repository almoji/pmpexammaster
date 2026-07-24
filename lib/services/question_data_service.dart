import 'dart:convert';

import 'package:flutter/services.dart';

class QuestionDataService {

  static const List<String> _questionFiles = [

    'assets/questions/questions_0001_0200.json',

    'assets/questions/questions_0201_0400.json',

    'assets/questions/questions_0401_0600.json',

    'assets/questions/questions_0601_0800.json',

    'assets/questions/questions_0801_1000.json',

    'assets/questions/questions_1001_1200.json',

    'assets/questions/questions_1201_1400.json',

    'assets/questions/questions_1401_1600.json',

    // Add new files here:
    // 'assets/questions/questions_0601_0800.json',

  ];

  Future<List<dynamic>> loadQuestions() async {

    final List<dynamic> allQuestions = [];

    for (final file in _questionFiles) {

      final String response =
      await rootBundle.loadString(file);

      final List<dynamic> questions =
      json.decode(response) as List<dynamic>;

      allQuestions.addAll(questions);

    }

    return allQuestions;

  }

  Future<int> getQuestionCount() async {
    final questions = await loadQuestions();
    return questions.length;
  }

}