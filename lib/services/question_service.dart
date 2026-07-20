import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/question.dart';
import '../models/practice_filter.dart';


class QuestionService {


  Future<List<Question>> loadQuestions({
    PracticeFilter? practiceFilter,
  }) async {


    final String response = await rootBundle.loadString(
      'lib/data/questions.json',
    );


    final List<dynamic> data = json.decode(response);

    List<dynamic> filteredData = data;

    if (practiceFilter != null &&
        practiceFilter.mode == "By Domain") {

      filteredData = data.where((question) {

        return question["domain"] == practiceFilter.domain;

      }).toList();

    }

    filteredData.shuffle();

    return filteredData.map((json) {

      return Question(

        id: json['id'],

        domain: json['domain'],

        difficulty: json['difficulty'],

        type: json['type'],

        question: json['question'],

        optionA: json['optionA'],

        optionB: json['optionB'],

        optionC: json['optionC'],

        optionD: json['optionD'],

        correctAnswer: json['correctAnswer'],

        explanation: json['explanation'],

      );

    }).toList();


  }

}