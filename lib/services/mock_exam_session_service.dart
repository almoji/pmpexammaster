import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class MockExamSessionService {
  static const _sessionKey = 'mock_exam_session';

  Future<void> saveSession(Map<String, dynamic> session) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      _sessionKey,
      jsonEncode(session),
    );
  }

  Future<Map<String, dynamic>?> loadSession() async {
    final prefs = await SharedPreferences.getInstance();

    final json = prefs.getString(_sessionKey);

    if (json == null) return null;

    return jsonDecode(json) as Map<String, dynamic>;
  }

  Future<void> clearSession() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.remove(_sessionKey);
  }

  Future<bool> hasSession() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.containsKey(_sessionKey);
  }
}