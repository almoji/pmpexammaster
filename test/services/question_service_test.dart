import 'package:flutter_test/flutter_test.dart';

import 'package:pmp_exam_app/models/question.dart';
import 'package:pmp_exam_app/models/practice_filter.dart';
import 'package:pmp_exam_app/services/question_data_service.dart';
import 'package:pmp_exam_app/services/question_filter_service.dart';
import 'package:pmp_exam_app/services/question_service.dart';

class FakeQuestionDataService extends QuestionDataService {
  @override
  Future<List<dynamic>> loadQuestions() async {
    return [
      {
        'id': 1,
        'domain': 'People',
        'difficulty': 'Easy',
        'type': 'Knowledge',
        'questionFormat': 'singleChoice',
        'question': 'Question 1',
        'optionA': 'A',
        'optionB': 'B',
        'optionC': 'C',
        'optionD': 'D',
        'correctAnswer': 'A',
        'correctAnswers': ['A'],
        'explanation': 'Explanation',
      }
    ];
  }
}

void main() {
  group('QuestionService', () {
    test('loads questions from data service', () async {
      final service = QuestionService(
        questionDataService: FakeQuestionDataService(),
        questionFilterService: QuestionFilterService(),
      );

      final questions = await service.loadQuestions();

      expect(questions, hasLength(1));
      expect(questions.first, isA<Question>());
      expect(questions.first.id, 1);
    });
  });

  test('applies domain filter', () async {
    final service = QuestionService(
      questionDataService: FakeQuestionDataService(),
      questionFilterService: QuestionFilterService(),
    );

    const filter = PracticeFilter(
      mode: 'By Domain',
      domain: 'People',
      difficulty: '',
      questionType: '',
    );

    final questions = await service.loadQuestions(
      practiceFilter: filter,
    );

    expect(questions, hasLength(1));
    expect(questions.first.domain, 'People');
  });

}