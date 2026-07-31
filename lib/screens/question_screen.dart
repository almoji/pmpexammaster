import 'dart:async';
import 'package:flutter/material.dart';

import '../models/question.dart';
import '../models/practice_filter.dart';
import '../services/question_service.dart';
import '../services/history_service.dart';
import '../services/practice_history_service.dart';
import '../models/exam_result.dart';
import '../models/domain_result.dart';
import 'result_screen.dart';
import 'exam_review_screen.dart';
import '../services/incorrect_questions_service.dart';
import '../services/favorite_questions_service.dart';
import '../services/question_attempt_service.dart';
import '../models/question_attempt.dart';
import '../models/exam_mode.dart';
import '../services/mock_exam_session_service.dart';



class QuestionScreen extends StatefulWidget {

  final int numberOfQuestions;
  final int examSeconds;
  final bool isMockExam;

  final PracticeFilter? practiceFilter;


  const QuestionScreen({

    super.key,

    required this.numberOfQuestions,

    required this.examSeconds,

    required this.isMockExam,

    this.practiceFilter,

  });

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  final Set<int> _flaggedQuestions = {};

  late int remainingSeconds;
  DateTime? _questionStartTime;
  Timer? _timer;

  final QuestionService _questionService = QuestionService();

  final HistoryService _historyService = HistoryService();

  final PracticeHistoryService _practiceHistoryService =
  PracticeHistoryService();

  final IncorrectQuestionsService _incorrectQuestionsService =
  IncorrectQuestionsService();

  final QuestionAttemptService _questionAttemptService =
  QuestionAttemptService();

  List<Question> _questions = [];

  final FavoriteQuestionsService _favoriteQuestionsService =
  FavoriteQuestionsService();

  bool _isFavorite = false;


  final Set<String> _selectedAnswers = {};

  String? _resultMessage;

  bool _answered = false;

  bool _cameFromReview = false;

  int _currentQuestionIndex = 0;

  bool _examFinished = false;

  bool _isOnOfficialBreak = false;

  bool _firstBreakTaken = false;
  bool _secondBreakTaken = false;

  final List<Question> _incorrectQuestions = [];

  final Map<int, Set<String>> _userAnswers = {};

  final Set<int> _answeredQuestions = {};

  final MockExamSessionService _sessionService =
  MockExamSessionService();



  @override
  void initState() {
    super.initState();

    remainingSeconds =
    widget.isMockExam
        ? 230 * 60
        : (widget.examSeconds == 0 ? -1 : widget.examSeconds);

    loadQuestions();
  }


  String formatTime(int seconds) {

    final minutes = seconds ~/ 60;

    final secs = seconds % 60;

    return
      "${minutes.toString().padLeft(2, '0')}:"
          "${secs.toString().padLeft(2, '0')}";

  }


  int answeredQuestions() {

    return _userAnswers.length;

  }

  Future<void> _saveMockExamSession() async {
    if (!widget.isMockExam) return;

    await _sessionService.saveSession({
      'currentQuestionIndex': _currentQuestionIndex,
      'remainingSeconds': remainingSeconds,
      'userAnswers': _userAnswers.map(
            (key, value) => MapEntry(
          key.toString(),
          value.toList(),
        ),
      ),
      'flaggedQuestions': _flaggedQuestions.toList(),
    });
  }

  Future<void> _checkForSavedMockExam() async {
    if (!widget.isMockExam) return;

    final hasSavedSession = await _sessionService.hasSession();

    debugPrint("Mock Exam saved session: $hasSavedSession");

    if (!hasSavedSession) {
      startTimer();
      return;
    }

    final session = await _sessionService.loadSession();

    debugPrint("Saved session: $session");

    await _showRestoreMockExamDialog();
  }

  Future<void> _showRestoreMockExamDialog() async {
    if (!mounted) return;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          title: const Text("Resume Mock Exam?"),
          content: const Text(
            "An unfinished Mock Exam was found.",
          ),
          actions: [
            TextButton(
              onPressed: () async {
                final navigator = Navigator.of(context);

                await _sessionService.clearSession();

                if (!mounted) return;

                navigator.pop();

                startTimer();
              },
              child: const Text("Start New"),
            ),
            ElevatedButton(
              onPressed: () async {
                final navigator = Navigator.of(context);

                await _restoreMockExamSession();

                if (!mounted) return;

                navigator.pop();

                startTimer();
              },
              child: const Text("Continue"),
            ),
          ],
        );
      },
    );
  }

  Future<void> _restoreMockExamSession() async {
    final session = await _sessionService.loadSession();

    if (session == null) return;

try {

    final savedIndex = session['currentQuestionIndex'] as int;

    final safeIndex = _questions.isEmpty
        ? 0
        : savedIndex.clamp(0, _questions.length - 1);

    final savedRemainingSeconds =
    session['remainingSeconds'] as int;

    final safeRemainingSeconds = savedRemainingSeconds.clamp(
      0,
      widget.examSeconds,
    );

    setState(() {
      _currentQuestionIndex = safeIndex;
      remainingSeconds = safeRemainingSeconds;

      _userAnswers.clear();
      _userAnswers.addAll(
        (session['userAnswers'] as Map<String, dynamic>).map(
              (key, value) => MapEntry(
            int.parse(key),
            Set<String>.from(value),
          ),
        ),
      );

      _flaggedQuestions.clear();
      _flaggedQuestions.addAll(
        List<int>.from(session['flaggedQuestions']),
      );
    });

    debugPrint("RESTORED QUESTION: $_currentQuestionIndex");
    debugPrint("RESTORED TIME: $remainingSeconds");
} catch (e) {
  debugPrint("Failed to restore Mock Exam session: $e");

  await _sessionService.clearSession();

  if (!mounted) return;

  setState(() {
    remainingSeconds = widget.examSeconds;
    _currentQuestionIndex = 0;
    _userAnswers.clear();
    _flaggedQuestions.clear();
  });
}

  }

  void startTimer() {

    // Practice sin límite de tiempo (ALL Questions)
    if (!widget.isMockExam && remainingSeconds < 0) {
      return;
    }

    _timer = Timer.periodic(
      const Duration(seconds: 1),
          (timer) {

        if (!mounted) {
          timer.cancel();
          return;
        }

        if (_isOnOfficialBreak) {
          return;
        }

        if (remainingSeconds > 0) {

          setState(() {
            remainingSeconds--;
          });

          _checkTimeWarnings();

          return;
        }

        timer.cancel();

        finishExam();
      },
    );
  }

  void _showTimeWarning(
      String message, {
        int durationSeconds = 3,
      }) {
    if (!mounted) return;

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(message),
          duration: Duration(seconds: durationSeconds),
        ),
      );
  }

  void _checkTimeWarnings() {

    if (!widget.isMockExam) return;

    if (remainingSeconds == 1800) {
      _showTimeWarning("⏰ 30 minutes remaining.");
    } else if (remainingSeconds == 600) {
      _showTimeWarning("⏰ 10 minutes remaining.");
    } else if (remainingSeconds == 300) {
      _showTimeWarning("⚠️ 5 minutes remaining.");
    } else if (remainingSeconds == 60) {
      _showTimeWarning(
        "🚨 Final minute remaining.\n"
            "The exam will be submitted automatically.",
        durationSeconds: 5,
      );
    }
  }

  Future<void> loadQuestions() async {


    final questions = await _questionService.loadQuestions(
      practiceFilter: widget.practiceFilter,
    );

    if (questions.isEmpty) {

      if (mounted) {

        ScaffoldMessenger.of(context).showSnackBar(

          const SnackBar(

            content: Text(
              "🎉 Great job! You don't have any incorrect questions to review.",
            ),

          ),

        );

        Navigator.pop(context);

      }

      return;

    }



    setState(() {

      final int questionsToLoad =
      widget.isMockExam
          ? 180
          : widget.numberOfQuestions;

      _questions = questions
          .take(questionsToLoad)
          .toList();

      _questionStartTime = DateTime.now();

    });

    await _loadFavoriteStatus();

    if (widget.isMockExam) {
      await _checkForSavedMockExam();
    } else if (remainingSeconds > 0) {
      startTimer();
    }
  }
  Future<void> _loadFavoriteStatus() async {
    if (_questions.isEmpty) return;

    final favorites = await _favoriteQuestionsService.getQuestions();

    final currentQuestion = _questions[_currentQuestionIndex];

    final isFavorite = favorites.any((q) => q.id == currentQuestion.id);

    if (!mounted) return;

    setState(() {
      _isFavorite = isFavorite;
    });
  }


  Future<void> checkAnswer() async {

    if (_selectedAnswers.isEmpty) {
      return;
    }


    final question = _questions[_currentQuestionIndex];

    final elapsedSeconds = _questionStartTime == null
        ? 0
        : DateTime.now()
        .difference(_questionStartTime!)
        .inSeconds;

    assert(elapsedSeconds >= 0);

    final selectedAnswers = _selectedAnswers
        .map((e) => e.trim().toUpperCase())
        .toSet();

    final correctAnswers = question.correctAnswers
        .map((e) => e.trim().toUpperCase())
        .toSet();

    final isCorrect =
        selectedAnswers.length == correctAnswers.length &&
            selectedAnswers.containsAll(correctAnswers);

    final attempt = QuestionAttempt(
      questionId: question.id,
      timestamp: DateTime.now(),
      correct: isCorrect,
      selectedAnswers: List.from(_selectedAnswers),
      elapsedSeconds: elapsedSeconds,
      mode: ExamMode.practice,
      domain: question.domain,
    );

    await _questionAttemptService.addAttempt(attempt);


    if (isCorrect) {

      setState(() {

        _answered = true;

        _answeredQuestions.add(question.id);

        _resultMessage =
        "✅ Correct!\n\n${question.explanation}";

      });

      if (widget.practiceFilter?.mode == "Incorrect Questions") {
        await _incorrectQuestionsService.removeQuestion(question.id);
      }


    } else {

      setState(() {

        _incorrectQuestions.add(
          Question(
            id: question.id,
            domain: question.domain,
            difficulty: question.difficulty,
            type: question.type,
            questionFormat: question.questionFormat,
            question: question.question,
            optionA: question.optionA,
            optionB: question.optionB,
            optionC: question.optionC,
            optionD: question.optionD,
            correctAnswer: question.correctAnswer,
            correctAnswers: question.correctAnswers,
            explanation: question.explanation,
            userAnswer: _selectedAnswers.isEmpty ? null : _selectedAnswers.first,
          ),
        );

        _answered = true;

        _answeredQuestions.add(question.id);

        _resultMessage =
        "❌ Incorrect.\n\n"
            "Correct answer: ${question.correctAnswers.join(", ")}\n\n"
            "${question.explanation}";

      });

      await _incorrectQuestionsService.saveQuestion(
        _incorrectQuestions.last,
      );

    }

  }


  void previousQuestion() {

    if (_currentQuestionIndex > 0) {

      setState(() {
        _currentQuestionIndex--;

        _questionStartTime = DateTime.now();

        _isFavorite = false;

        _selectedAnswers.clear();

        final answer =
        _userAnswers[_questions[_currentQuestionIndex].id];

        if (answer != null) {
          _selectedAnswers.addAll(answer);
        }

        _resultMessage = null;

        _answered = _answeredQuestions.contains(
            _questions[_currentQuestionIndex].id);
      });

      _loadFavoriteStatus();

    }

  }
  Future<void> _toggleFlag() async {
    final questionId = _questions[_currentQuestionIndex].id;

    setState(() {
      if (_flaggedQuestions.contains(questionId)) {
        _flaggedQuestions.remove(questionId);
      } else {
        _flaggedQuestions.add(questionId);
      }
    });

    await _saveMockExamSession();
  }

  bool _isCurrentQuestionFlagged() {
    if (_questions.isEmpty) return false;

    final questionId = _questions[_currentQuestionIndex].id;
    return _flaggedQuestions.contains(questionId);
  }

  Future<void> nextQuestion() async {

    if (_currentQuestionIndex < _questions.length - 1) {

      if (widget.isMockExam) {

        if (_currentQuestionIndex == 59 && !_firstBreakTaken) {
          _firstBreakTaken = true;
          await _showOfficialBreak();
        }

        if (_currentQuestionIndex == 119 && !_secondBreakTaken) {
          _secondBreakTaken = true;
          await _showOfficialBreak();
        }
      }

      setState(() {
        _currentQuestionIndex++;

        _questionStartTime = DateTime.now();

        _isFavorite = false;

        _selectedAnswers.clear();

        final answer =
        _userAnswers[_questions[_currentQuestionIndex].id];

        if (answer != null) {
          _selectedAnswers.addAll(answer);
        }

        _resultMessage = null;

        _answered = _answeredQuestions.contains(
            _questions[_currentQuestionIndex].id);
      });

      await _saveMockExamSession();

      await _loadFavoriteStatus();

    }

  }

  Future<void> _showOfficialBreak() async {
    if (!mounted) return;

    _isOnOfficialBreak = true;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        final isFirstBreak = _currentQuestionIndex == 59;

        return PopScope(
          canPop: false,
          child: AlertDialog(
            title: const Text("Official Break"),
            content: Text(
              isFirstBreak
                  ? "You have completed the first section of the exam.\n\n"
                  "The exam timer is paused.\n\n"
                  "You may take an optional break of up to 10 minutes.\n\n"
                  "When you are ready, press \"Resume Exam\" to continue with the next section."
                  : "You have completed the second section of the exam.\n\n"
                  "The exam timer is paused.\n\n"
                  "You may take an optional break of up to 10 minutes.\n\n"
                  "When you are ready, press \"Resume Exam\" to continue with the final section.",
            ),
            actions: [
              FilledButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("Resume Exam"),
              ),
            ],
          ),
        );
      },
    );

    _isOnOfficialBreak = false;
  }

  int calculateCorrectAnswers() {

    int correct = 0;

    for (var q in _questions) {

      final answer = _userAnswers[q.id];

      debugPrint(
          "CHECK DOMAIN -> ID:${q.id} | DOMAIN:${q.domain} | USER:$answer | CORRECT:${q.correctAnswer}"
      );

      if (answer != null) {
        final correctAnswers = q.correctAnswers
            .map((e) => e.trim().toUpperCase())
            .toSet();

        if (answer.length == correctAnswers.length &&
            answer.containsAll(correctAnswers)) {
          correct++;
        }
      }

    }

    return correct;

  }

  List<DomainResult> calculateDomainResults() {

    Map<String, List<Question>> domainMap = {};


    for (var question in _questions) {

      if (!domainMap.containsKey(question.domain)) {

        domainMap[question.domain] = [];

      }

      domainMap[question.domain]!.add(question);

    }


    return domainMap.entries.map((entry) {

      final questions = entry.value;

      int correct = 0;


      for (var q in questions) {

        final answer = _userAnswers[q.id];

        debugPrint(
            "DOMAIN ${q.domain} | Q${q.id} | ANSWER $answer | CORRECT ${q.correctAnswer}"
        );


        if (answer != null) {
          final correctAnswers = q.correctAnswers
              .map((e) => e.trim().toUpperCase())
              .toSet();

          if (answer.length == correctAnswers.length &&
              answer.containsAll(correctAnswers)) {
            correct++;
          }
        }

      }


      return DomainResult(

        domain: entry.key,

        totalQuestions: questions.length,

        correctAnswers: correct,

      );


    }).toList();

  }

  Future<void> goToExamReview() async {
    final selectedQuestion = await Navigator.push<int>(
      context,
      MaterialPageRoute(
        builder: (context) => ExamReviewScreen(
          questions: _questions,
          userAnswers: _userAnswers,
          flaggedQuestions: _flaggedQuestions,
          onSubmit: finishExam,
        ),
      ),
    );

    if (selectedQuestion != null) {
      setState(() {
        _cameFromReview = true;
        _currentQuestionIndex = selectedQuestion;

        _selectedAnswers.clear();

        final answer = _userAnswers[_questions[_currentQuestionIndex].id];
        if (answer != null) {
          _selectedAnswers.addAll(answer);
        }

        _answered = _answeredQuestions.contains(
          _questions[_currentQuestionIndex].id,
        );

        _resultMessage = null;
      });

      await _loadFavoriteStatus();
    }
  }

  Future<void> finishExam() async {

    if (_examFinished) return;

    _examFinished = true;

    debugPrint("===== FINISH EXAM START =====");

    final int correctAnswers =
    calculateCorrectAnswers();


    final int incorrectAnswers =
        _questions.length - correctAnswers;


    final int percentage =
    ((correctAnswers / _questions.length) * 100).round();



    final result = ExamResult(

      date: DateTime.now(),

      score: percentage,

      totalQuestions: _questions.length,

      correctAnswers: correctAnswers,

      incorrectAnswers: incorrectAnswers,

      percentage: percentage,

      passed: percentage >= 70,

      domainResults: calculateDomainResults(),

    );



    try {

      debugPrint(
          "DOMAINS COUNT: ${result.domainResults.length}"
      );

      if (widget.isMockExam) {
        await _historyService.saveResult(result);
      } else {
        await _practiceHistoryService.saveResult(result);
      }


      for (var domain in result.domainResults) {

        debugPrint(
            "${domain.domain}: "
                "${domain.correctAnswers}/"
                "${domain.totalQuestions}"
        );

      }
      await _sessionService.clearSession();

      debugPrint("===== RESULT SAVED =====");



      if (!mounted) {

        return;

      }



      debugPrint("===== OPEN RESULT SCREEN =====");



      Navigator.pushAndRemoveUntil(

        context,

        MaterialPageRoute(

          builder: (context) => ResultScreen(

            correctAnswers: correctAnswers,

            totalQuestions: _questions.length,

            incorrectQuestions: _incorrectQuestions,

            domainResults: result.domainResults,

            isMockExam: widget.isMockExam,

          ),

        ),

            (route) => route.isFirst,

      );


    } catch (e) {


      debugPrint("ERROR FINISH EXAM: $e");


    }

  }

  Widget _buildChip({
    required IconData icon,
    required String text,
    required Color background,
    required Color color,
  }) {

    return Container(
      height: 48,
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Icon(
            icon,
            size: 20,
            color: color,
          ),

          const SizedBox(width: 8),

          Flexible(
            child: Text(
              text,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w700,
                fontSize: 14,
              ),
            ),
          ),

        ],
      ),
    );
  }


  Widget answerButton(String letter, String answer) {

    final question = _questions[_currentQuestionIndex];


    final bool isSelected = _selectedAnswers.contains(letter);


    final bool isCorrect = question.correctAnswers.contains(
      letter.trim().toUpperCase(),
    );


    Color buttonColor = Colors.white;

    if (_answered) {

      if (isCorrect) {

        buttonColor = const Color(0xFFE9F9EE);

      } else if (isSelected) {

        buttonColor = const Color(0xFFFFECEC);

      }

    } else if (isSelected) {

      buttonColor = const Color(0xFFEAF4FF);

    }



    return Padding(
      padding: const EdgeInsets.only(bottom: 14),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(22),
          onTap: _answered
              ? null
              : () async {

            setState(() {

              if (question.questionFormat == "singleChoice") {

                _selectedAnswers
                  ..clear()
                  ..add(letter);

                _userAnswers[question.id] = {letter};

              } else {

                final maxAnswers = question.correctAnswers.length;

                if (_selectedAnswers.contains(letter)) {
                  _selectedAnswers.remove(letter);
                } else if (_selectedAnswers.length < maxAnswers) {
                  _selectedAnswers.add(letter);
                }

                _userAnswers[question.id] =
                Set<String>.from(_selectedAnswers);
              }

            });

            await _saveMockExamSession();
          },
          child: Ink(
            decoration: BoxDecoration(
              color: buttonColor,
              borderRadius: BorderRadius.circular(22),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.05),
                  blurRadius: 20,
                  spreadRadius: -6,
                  offset: const Offset(0, 10),
                ),
              ],
              border: Border.all(
                color: _answered
                    ? (isCorrect
                    ? const Color(0xFF26A65B)
                    : (isSelected
                    ? const Color(0xFFE74C3C)
                    : const Color(0xFFE8EEF7)))
                    : (isSelected
                    ? const Color(0xFF2D86FF)
                    : const Color(0xFFE8EEF7)),
                width: 2,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Text(
                        letter,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF173B7A),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 18),

                  Expanded(
                    child: Text(
                      answer,
                      style: const TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: Color(0xFF173B7A),
                      ),
                    ),
                  ),

                  if (_answered)
                    Icon(
                      isCorrect
                          ? Icons.check_circle
                          : (isSelected
                          ? Icons.cancel
                          : Icons.circle_outlined),
                      color: isCorrect
                          ? const Color(0xFF26A65B)
                          : const Color(0xFFE74C3C),
                    ),
                ],
              ),
            ),
          ),
        ),
      ),
    );

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(
      backgroundColor: const Color(0xFFF6F9FE),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,

        title: Text(
          widget.isMockExam
              ? "Mock Exam"
              : "Practice Questions",
        ),

        actions: [
          if (widget.isMockExam)
            IconButton(
              icon: Icon(
                _isCurrentQuestionFlagged()
                    ? Icons.flag
                    : Icons.outlined_flag,
              ),
              onPressed: _toggleFlag,
            ),

          if (!widget.isMockExam)
            IconButton(
              icon: Icon(
                _isFavorite ? Icons.star : Icons.star_border,
              ),
              onPressed: () async {
                final question = _questions[_currentQuestionIndex];

                if (_isFavorite) {
                  await _favoriteQuestionsService.removeQuestion(question.id);
                } else {
                  await _favoriteQuestionsService.saveQuestion(question);
                }

                setState(() {
                  _isFavorite = !_isFavorite;
                });
              },
            ),

          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Center(
              child: Text(
                (!widget.isMockExam && remainingSeconds < 0)
                    ? "No Time Limit"
                    : formatTime(remainingSeconds),
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

        ],

      ),


        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFEAF4FF),
                Color(0xFFF6F9FE),
                Colors.white,
              ],
              stops: [
                0,
                .22,
                .45,
              ],
            ),
          ),
          child: SafeArea(

        child: _questions.isEmpty

            ? const Center(
          child: CircularProgressIndicator(),
        )


            : SingleChildScrollView(

          padding: const EdgeInsets.all(20),

          physics: const BouncingScrollPhysics(),


          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,


            children: [


              Container(
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 30,
                      spreadRadius: -8,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Container(
                      width: 72,
                      height: 72,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFF63B4FF),
                            Color(0xFF2D86FF),
                          ],
                        ),
                      ),
                      child: const Icon(
                        Icons.track_changes_rounded,
                        color: Colors.white,
                        size: 38,
                      ),
                    ),

                    const SizedBox(width: 18),

                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Text(
                            "Question ${_currentQuestionIndex + 1} of ${_questions.length}",
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF173B7A),
                            ),
                          ),

                          const SizedBox(height: 10),

                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: SizedBox(
                              height: 10,
                              child: LinearProgressIndicator(
                                value:
                                (_currentQuestionIndex + 1) /
                                    _questions.length,
                                color: const Color(0xFF2D86FF),
                                backgroundColor: const Color(0xFFE7EEF8),
                              ),
                            ),
                          ),

                          const SizedBox(height: 10),

                          InkWell(
                            onTap: goToExamReview,
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.assignment_outlined,
                                  size: 18,
                                  color: Color(0xFF74829C),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  "Answered ${answeredQuestions()} / ${_questions.length}",
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    color: Color(0xFF74829C),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 16),

                    Column(
                      children: [

                        Text(
                          "${(((_currentQuestionIndex + 1) / _questions.length) * 100).round()}%",
                          style: const TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF2D86FF),
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          (!widget.isMockExam && remainingSeconds < 0)
                              ? "--"
                              : formatTime(remainingSeconds),
                          style: const TextStyle(
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF74829C),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),








              if (!widget.isMockExam) ...[

                const SizedBox(height: 10),

                Row(
                  children: [

                    Expanded(
                      child: _buildChip(
                        icon: Icons.groups_rounded,
                        text: _questions[_currentQuestionIndex].domain,
                        background: const Color(0xFFEAF4FF),
                        color: const Color(0xFF2D86FF),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _buildChip(
                        icon: Icons.speed_rounded,
                        text: _questions[_currentQuestionIndex].difficulty,
                        background: const Color(0xFFE9F9EE),
                        color: const Color(0xFF26A65B),
                      ),
                    ),

                    const SizedBox(width: 10),

                    Expanded(
                      child: _buildChip(
                        icon: Icons.list_alt_rounded,
                        text: _questions[_currentQuestionIndex].questionFormat,
                        background: const Color(0xFFF1EBFF),
                        color: const Color(0xFF7B46E3),
                      ),
                    ),

                  ],
                ),

              ],



              const SizedBox(height: 10),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(26),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 30,
                      spreadRadius: -8,
                      offset: const Offset(0, 14),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [



                    Text(
                      _questions[_currentQuestionIndex].question,
                      style: const TextStyle(
                        fontSize: 17,
                        height: 1.6,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF173B7A),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),



              answerButton(
                "A",
                _questions[_currentQuestionIndex].optionA,
              ),


              answerButton(
                "B",
                _questions[_currentQuestionIndex].optionB,
              ),


              answerButton(
                "C",
                _questions[_currentQuestionIndex].optionC,
              ),


              answerButton(
                "D",
                _questions[_currentQuestionIndex].optionD,
              ),



              if (!widget.isMockExam)

                Padding(
                  padding: const EdgeInsets.only(top: 10),
                  child: SizedBox(
                    width: double.infinity,
                    height: 58,
                    child: ElevatedButton.icon(

                      onPressed: _answered
                          ? null
                          : (_selectedAnswers.length ==
                          _questions[_currentQuestionIndex]
                              .correctAnswers
                              .length
                          ? checkAnswer
                          : null),

                      icon: const Icon(Icons.task_alt_rounded),

                      label: const Text(
                        "Check Answer",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      style: ElevatedButton.styleFrom(
                        elevation: 0,
                        backgroundColor: const Color(0xFF2D86FF),
                        foregroundColor: Colors.white,
                        disabledBackgroundColor: const Color(0xFFBFCDE4),
                        disabledForegroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),
                      ),
                    ),
                  ),
                ),



              if (_resultMessage != null)

                Padding(
                  padding: const EdgeInsets.only(top: 24),
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: _resultMessage!.startsWith("✅")
                          ? const Color(0xFFE9F9EE)
                          : const Color(0xFFFFF1F1),
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(
                        color: _resultMessage!.startsWith("✅")
                            ? const Color(0xFF26A65B)
                            : const Color(0xFFE74C3C),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Icon(
                          _resultMessage!.startsWith("✅")
                              ? Icons.check_circle_rounded
                              : Icons.cancel_rounded,
                          size: 34,
                          color: _resultMessage!.startsWith("✅")
                              ? const Color(0xFF26A65B)
                              : const Color(0xFFE74C3C),
                        ),

                        const SizedBox(width: 10),

                        Expanded(
                          child: Text(
                            _resultMessage!,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.6,
                              color: Color(0xFF173B7A),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),




              const SizedBox(height: 10),

              Row(
                children: [

                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: OutlinedButton.icon(

                        onPressed: _currentQuestionIndex > 0
                            ? previousQuestion
                            : null,

                        icon: const Icon(Icons.arrow_back_rounded),

                        label: const Text(
                          "Previous",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        style: OutlinedButton.styleFrom(
                          foregroundColor: const Color(0xFF2D86FF),
                          side: const BorderSide(
                            color: Color(0xFF2D86FF),
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(width: 16),

                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ElevatedButton.icon(

                        onPressed: widget.isMockExam
                            ? (_currentQuestionIndex == _questions.length - 1
                            ? goToExamReview
                            : () async {
                          if (_cameFromReview) {
                            _cameFromReview = false;
                            await goToExamReview();
                          } else {
                            await nextQuestion();
                          }
                        })
                            : (_currentQuestionIndex == _questions.length - 1 && _answered
                            ? finishExam
                            : (_answered ? nextQuestion : null)),

                        icon: Icon(
                          _currentQuestionIndex == _questions.length - 1
                              ? Icons.flag_circle_rounded
                              : Icons.arrow_forward_rounded,
                        ),

                        label: Text(
                          _currentQuestionIndex == _questions.length - 1
                              ? "Finish"
                              : "Next",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        style: ElevatedButton.styleFrom(
                          elevation: 0,
                          backgroundColor: const Color(0xFF2D86FF),
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                        ),
                      ),
                    ),
                  ),

                ],
              ),


            ],

          ),

        ),

          ),
        ),
    );

  }
  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

}