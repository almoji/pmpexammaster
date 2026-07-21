import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/question_attempt.dart';

class QuestionAttemptService {
  static const String _storageKey = 'question_attempts';

  final List<QuestionAttempt> _attempts = [];

  List<QuestionAttempt> get attempts => List.unmodifiable(_attempts);

  Future<void> addAttempt(QuestionAttempt attempt) async {
    _attempts.add(attempt);
    await saveAttempts();
  }

  Future<void> saveAttempts() async {
    final prefs = await SharedPreferences.getInstance();

    final jsonList = _attempts
        .map((attempt) => jsonEncode(attempt.toJson()))
        .toList();

    await prefs.setStringList(_storageKey, jsonList);
  }

  void clear() {
    _attempts.clear();
  }
}