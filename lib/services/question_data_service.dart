import 'dart:convert';

import 'package:flutter/services.dart';

class QuestionDataService {
  Future<List<dynamic>> loadQuestions() async {
    final String response = await rootBundle.loadString(
      'lib/data/questions.json',
    );

    return json.decode(response) as List<dynamic>;
  }
}