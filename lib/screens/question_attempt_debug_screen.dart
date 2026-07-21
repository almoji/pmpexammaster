import 'package:flutter/material.dart';
import '../models/question_attempt.dart';
import '../services/question_attempt_service.dart';

class QuestionAttemptDebugScreen extends StatefulWidget {
  const QuestionAttemptDebugScreen({super.key});

  @override
  State<QuestionAttemptDebugScreen> createState() =>
      _QuestionAttemptDebugScreenState();
}

class _QuestionAttemptDebugScreenState
    extends State<QuestionAttemptDebugScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Question Attempts'),
      ),
      body: Center(
        child: Text(
          'Attempts: ${_attempts.length}',
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }

  final QuestionAttemptService _questionAttemptService =
  QuestionAttemptService();

  List<QuestionAttempt> _attempts = [];

  @override
  void initState() {
    super.initState();
    _loadAttempts();
  }

  Future<void> _loadAttempts() async {
    final attempts = await _questionAttemptService.getAttempts();

    setState(() {
      _attempts = attempts;
    });
  }

}
