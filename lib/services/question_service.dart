import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/question.dart';
import '../models/practice_filter.dart';
import 'incorrect_questions_service.dart';
import 'package:flutter/foundation.dart';


class QuestionService {

  final IncorrectQuestionsService _incorrectQuestionsService =
  IncorrectQuestionsService();

  Future<List<Question>> loadQuestions({
    PracticeFilter? practiceFilter,
  }) async {

    debugPrint("========== QUESTION SERVICE ==========");
    debugPrint("Mode: ${practiceFilter?.mode}");

    final String response = await rootBundle.loadString(
      'lib/data/questions.json',
    );

    final List<dynamic> data = json.decode(response);

    if (practiceFilter?.mode == "Incorrect Questions") {
      debugPrint("Loading incorrect questions...");
      return await _incorrectQuestionsService.getQuestions();
    }

    List<dynamic> filteredData = data;

    if (practiceFilter != null) {

      if (practiceFilter.mode == "By Domain") {

        filteredData = data.where((question) {

          return question["domain"] == practiceFilter.domain;

        }).toList();

      }

      else if (practiceFilter.mode == "By Difficulty") {

        String difficulty = practiceFilter.difficulty;

        if (difficulty == "Moderate") {
          difficulty = "Medium";
        } else if (difficulty == "Difficult") {
          difficulty = "Hard";
        }

        filteredData = data.where((question) {


          return question["difficulty"] == difficulty;

        }).toList();



      }

      else if (practiceFilter.mode == "By Question Type") {

        String questionType = practiceFilter.questionType;

        if (questionType == "Multiple Choice") {
          questionType = "Knowledge";
        } else if (questionType == "Multiple Response") {
          questionType = "Situational";
        }

        filteredData = data.where((question) {

          return question["type"] == questionType;

        }).toList();

      }

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