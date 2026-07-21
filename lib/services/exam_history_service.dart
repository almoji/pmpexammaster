import '../models/exam_history.dart';

class ExamHistoryService {
  static final List<ExamHistory> _history = [];

  static List<ExamHistory> getHistory() {
    return List.unmodifiable(_history);
  }

  static void addExam(ExamHistory exam) {
    _history.add(exam);
  }

  static void clearHistory() {
    _history.clear();
  }
}