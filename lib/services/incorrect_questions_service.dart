import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/question.dart';

import 'package:flutter/foundation.dart';

class IncorrectQuestionsService {
  static const String _key = "incorrect_questions";

  Future<void> saveQuestion(Question question) async {

    debugPrint("Saving incorrect question: ${question.id}");

    final prefs = await SharedPreferences.getInstance();

    final questions = await getQuestions();

    // Evitar duplicados
    if (questions.any((q) => q.id == question.id)) {
      return;
    }

    questions.add(question);

    final jsonList = questions
        .map((item) => jsonEncode(item.toJson()))
        .toList();

    await prefs.setStringList(_key, jsonList);
  }

  Future<List<Question>> getQuestions() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = prefs.getStringList(_key);

    if (jsonList == null) {
      return [];
    }

    debugPrint("Incorrect questions stored: ${jsonList.length}");

    return jsonList
        .map((item) => Question.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<void> removeQuestion(int id) async {
    final prefs = await SharedPreferences.getInstance();

    final questions = await getQuestions();

    questions.removeWhere((q) => q.id == id);

    final jsonList = questions
        .map((item) => jsonEncode(item.toJson()))
        .toList();

    await prefs.setStringList(_key, jsonList);
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);
  }
}