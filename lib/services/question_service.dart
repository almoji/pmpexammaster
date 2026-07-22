import 'dart:convert';

import 'package:flutter/services.dart';

import '../models/question.dart';
import '../models/practice_filter.dart';
import 'incorrect_questions_service.dart';
import 'favorite_questions_service.dart';
import 'question_filter_service.dart';



class QuestionService {

  final IncorrectQuestionsService _incorrectQuestionsService =
  IncorrectQuestionsService();

  final FavoriteQuestionsService _favoriteQuestionsService =
  FavoriteQuestionsService();

  final QuestionFilterService _questionFilterService =
  QuestionFilterService();

  Future<List<Question>> loadQuestions({
    PracticeFilter? practiceFilter,
  }) async {


    final String response = await rootBundle.loadString(
      'lib/data/questions.json',
    );

    final List<dynamic> data = json.decode(response);

    if (practiceFilter?.mode == "Incorrect Questions") {
      return await _incorrectQuestionsService.getQuestions();
    }

    if (practiceFilter?.mode == "Favorite Questions") {
      return await _favoriteQuestionsService.getQuestions();
    }

    List<dynamic> filteredData = _questionFilterService.applyFilter(
      data,
      practiceFilter,
    );

    if (practiceFilter != null) {



      if (practiceFilter.mode == "By Difficulty") {

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



    }

    filteredData.shuffle();

    return filteredData.map((json) {

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
        correctAnswers: json['correctAnswers'] != null
            ? List<String>.from(json['correctAnswers'])
            : [json['correctAnswer']],
        explanation: json['explanation'],
      );

    }).toList();


  }

}