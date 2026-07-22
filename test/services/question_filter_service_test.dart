import 'package:flutter_test/flutter_test.dart';

import 'package:pmp_exam_app/models/practice_filter.dart';
import 'package:pmp_exam_app/services/question_filter_service.dart';

void main() {
  group('QuestionFilterService', () {
    test('returns original data when filter is null', () {
      final service = QuestionFilterService();

      final data = [
        {'id': 1},
        {'id': 2},
      ];

      final result = service.applyFilter(data, null);

      expect(result, same(data));
    });

    test('filters questions by domain', () {
      final service = QuestionFilterService();

      final data = [
        {'id': 1, 'domain': 'People'},
        {'id': 2, 'domain': 'Process'},
        {'id': 3, 'domain': 'People'},
      ];

      final filter = const PracticeFilter(
        mode: 'By Domain',
        domain: 'People',
        difficulty: '',
        questionType: '',
      );

      final result = service.applyFilter(data, filter);

      expect(result, hasLength(2));
      expect(result[0]['id'], 1);
      expect(result[1]['id'], 3);
    });
  });

  test('filters questions by difficulty', () {
    final service = QuestionFilterService();

    final data = [
      {'id': 1, 'difficulty': 'Easy'},
      {'id': 2, 'difficulty': 'Medium'},
      {'id': 3, 'difficulty': 'Hard'},
    ];

    const filter = PracticeFilter(
      mode: 'By Difficulty',
      domain: '',
      difficulty: 'Moderate',
      questionType: '',
    );

    final result = service.applyFilter(data, filter);

    expect(result, hasLength(1));
    expect(result.first['id'], 2);
  });
  test('maps Multiple Choice to Knowledge', () {
    final service = QuestionFilterService();

    final data = [
      {'id': 1, 'type': 'Knowledge'},
      {'id': 2, 'type': 'Situational'},
    ];

    const filter = PracticeFilter(
      mode: 'By Question Type',
      domain: '',
      difficulty: '',
      questionType: 'Multiple Choice',
    );

    final result = service.applyFilter(data, filter);

    expect(result, hasLength(1));
    expect(result.first['id'], 1);
  });

  test('maps Multiple Response to Situational', () {
    final service = QuestionFilterService();

    final data = [
      {'id': 1, 'type': 'Knowledge'},
      {'id': 2, 'type': 'Situational'},
    ];

    const filter = PracticeFilter(
      mode: 'By Question Type',
      domain: '',
      difficulty: '',
      questionType: 'Multiple Response',
    );

    final result = service.applyFilter(data, filter);

    expect(result, hasLength(1));
    expect(result.first['id'], 2);
  });

}