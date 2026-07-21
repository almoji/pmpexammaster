import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/question_attempt.dart';

class QuestionAttemptService {
  static const String _storageKey = 'question_attempts';



  Future<void> addAttempt(QuestionAttempt attempt) async {
    final attempts = await getAttempts();

    attempts.add(attempt);

    await saveAttempts(attempts);
  }

  Future<void> saveAttempts(List<QuestionAttempt> attempts) async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = attempts
        .map((attempt) => jsonEncode(attempt.toJson()))
        .toList();

    await prefs.setStringList(_storageKey, jsonList);
  }

  Future<List<QuestionAttempt>> getAttempts() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = prefs.getStringList(_storageKey);

    if (jsonList == null) {
      return [];
    }

    return jsonList
        .map((item) => QuestionAttempt.fromJson(jsonDecode(item)))
        .toList();
  }

  Future<void> clear() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_storageKey);
  }

}