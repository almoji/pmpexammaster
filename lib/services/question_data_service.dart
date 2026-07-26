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
    'assets/questions/questions_1601_1800.json',
    'assets/questions/questions_1801_2000.json',
    'assets/questions/questions_2001_2200.json',
    'assets/questions/questions_2201_2400.json',
    'assets/questions/questions_2401_2600.json',
    'assets/questions/questions_2601_2800.json',
    'assets/questions/questions_2801_3000.json',
    'assets/questions/questions_3001_3200.json',
    'assets/questions/questions_3201_3400.json',
    'assets/questions/questions_3401_3600.json',
    'assets/questions/questions_3601_3800.json',
    'assets/questions/questions_3801_4000.json',
    'assets/questions/questions_4001_4200.json',
    'assets/questions/questions_4201_4400.json',
    'assets/questions/questions_4401_4600.json',
    'assets/questions/questions_4601_4800.json',
    'assets/questions/questions_4801_5000.json',
    'assets/questions/questions_5001_5200.json',
    'assets/questions/questions_5201_5400.json',
    'assets/questions/questions_5401_5600.json',
    'assets/questions/questions_5601_5800.json',
    'assets/questions/questions_5801_6000.json',
    'assets/questions/questions_6001_6200.json',














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