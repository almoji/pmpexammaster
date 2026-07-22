import '../models/practice_filter.dart';

class QuestionFilterService {
  List<dynamic> applyFilter(
      List<dynamic> data,
      PracticeFilter? practiceFilter,
      ) {
    List<dynamic> filteredData = data;

    if (practiceFilter != null &&
        practiceFilter.mode == "By Domain") {
      filteredData = data.where((question) {
        return question["domain"] == practiceFilter.domain;
      }).toList();
    }

    if (practiceFilter != null &&
        practiceFilter.mode == "By Difficulty") {
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

    if (practiceFilter != null &&
        practiceFilter.mode == "By Question Type") {
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

    return filteredData;
  }
}