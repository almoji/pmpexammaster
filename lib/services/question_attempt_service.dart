import '../models/question_attempt.dart';

class QuestionAttemptService {
  final List<QuestionAttempt> _attempts = [];

  List<QuestionAttempt> get attempts => List.unmodifiable(_attempts);

  void addAttempt(QuestionAttempt attempt) {
    _attempts.add(attempt);
  }

  void clear() {
    _attempts.clear();
  }
}