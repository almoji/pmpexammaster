import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../models/exam_result.dart';


class HistoryService {

  static const String _key = "exam_history";


  Future<void> saveResult(ExamResult result) async {

    final prefs = await SharedPreferences.getInstance();


    final results = await getResults();


    results.add(result);


    final jsonList = results
        .map((item) => jsonEncode(item.toJson()))
        .toList();


    await prefs.setStringList(
      _key,
      jsonList,
    );

  }



  Future<List<ExamResult>> getResults() async {

    final prefs = await SharedPreferences.getInstance();


    final jsonList = prefs.getStringList(_key);


    if (jsonList == null) {

      return [];

    }


    return jsonList.map((item) {

      return ExamResult.fromJson(
        jsonDecode(item),
      );

    }).toList();

  }



  Future<void> clearHistory() async {

    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_key);

  }

}