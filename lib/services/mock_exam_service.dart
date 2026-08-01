import 'package:shared_preferences/shared_preferences.dart';

import 'premium_service.dart';

class MockExamService {
  MockExamService._();

  static const _lastMockExamKey = 'last_mock_exam';

  static const int freeCooldownDays = 15;

  /// Returns true if the user can start a Mock Exam.
  static Future<bool> canStartMockExam() async {
    if (PremiumService.isPremium) {
      return true;
    }

    final prefs = await SharedPreferences.getInstance();

    final lastExamString = prefs.getString(_lastMockExamKey);

    if (lastExamString == null) {
      return true;
    }

    final lastExam = DateTime.parse(lastExamString);

    final nextAvailable =
    lastExam.add(const Duration(days: freeCooldownDays));

    return DateTime.now().isAfter(nextAvailable);
  }

  /// Saves the current date when a Mock Exam starts.
  static Future<void> registerMockExam() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _lastMockExamKey,
      DateTime.now().toIso8601String(),
    );
  }

  /// Returns the remaining cooldown days.
  static Future<int> remainingDays() async {
    if (PremiumService.isPremium) {
      return 0;
    }

    final prefs = await SharedPreferences.getInstance();

    final lastExamString = prefs.getString(_lastMockExamKey);

    if (lastExamString == null) {
      return 0;
    }

    final lastExam = DateTime.parse(lastExamString);

    final nextAvailable =
    lastExam.add(const Duration(days: freeCooldownDays));

    final difference =
        nextAvailable.difference(DateTime.now()).inDays;

    return difference <= 0 ? 0 : difference + 1;
  }
}