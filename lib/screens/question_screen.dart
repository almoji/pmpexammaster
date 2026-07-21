import 'dart:async';
import 'package:flutter/material.dart';

import '../models/question.dart';
import '../models/practice_filter.dart';
import '../services/question_service.dart';
import '../services/history_service.dart';
import '../models/exam_result.dart';
import '../models/domain_result.dart';
import 'result_screen.dart';
import 'exam_review_screen.dart';
import '../services/incorrect_questions_service.dart';
import '../services/favorite_questions_service.dart';

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

  late int remainingSeconds;
  Timer? _timer;

  final QuestionService _questionService = QuestionService();

  final HistoryService _historyService = HistoryService();

  final IncorrectQuestionsService _incorrectQuestionsService =
  IncorrectQuestionsService();

  List<Question> _questions = [];

  final FavoriteQuestionsService _favoriteQuestionsService =
  FavoriteQuestionsService();

  bool _isFavorite = false;

  String? _selectedAnswer;
  String? _resultMessage;

  bool _answered = false;

  int _currentQuestionIndex = 0;


  final List<Question> _incorrectQuestions = [];

  final Map<int, String> _userAnswers = {};

  final Set<int> _answeredQuestions = {};

@override
void initState() {

super.initState();

remainingSeconds = widget.examSeconds;

startTimer();

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


  void startTimer() {

    _timer = Timer.periodic(
const Duration(seconds: 1),
(timer) {

if (remainingSeconds > 0) {

setState(() {
remainingSeconds--;
});

} else {

timer.cancel();

finishExam();

}

},
);

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

      _questions = questions
          .take(widget.numberOfQuestions)
          .toList();

    });

    await _loadFavoriteStatus();
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

    if (_selectedAnswer == null) {

      return;

    }


    final question = _questions[_currentQuestionIndex];




    if (_selectedAnswer!.trim().toUpperCase() ==
        question.correctAnswer.trim().toUpperCase()) {

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
            userAnswer: _selectedAnswer,
          ),
        );

        _answered = true;

        _answeredQuestions.add(question.id);

        _resultMessage =
        "❌ Incorrect.\n\n"
            "Correct answer: ${question.correctAnswer}\n\n"
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

        _isFavorite = false;

        _selectedAnswer =
        _userAnswers[_questions[_currentQuestionIndex].id];

        _resultMessage = null;

        _answered = _answeredQuestions.contains(
            _questions[_currentQuestionIndex].id);
      });

      _loadFavoriteStatus();

    }

  }


  Future<void> nextQuestion() async {

    if (_currentQuestionIndex < _questions.length - 1) {

      setState(() {
        _currentQuestionIndex++;

        _isFavorite = false;

        _selectedAnswer =
        _userAnswers[_questions[_currentQuestionIndex].id];

        _resultMessage = null;

        _answered = _answeredQuestions.contains(
            _questions[_currentQuestionIndex].id);
      });

      await _loadFavoriteStatus();

    }

  }

  int calculateCorrectAnswers() {

    int correct = 0;

    for (var q in _questions) {

      final answer = _userAnswers[q.id];

      debugPrint(
          "CHECK DOMAIN -> ID:${q.id} | DOMAIN:${q.domain} | USER:$answer | CORRECT:${q.correctAnswer}"
      );

      if (answer != null &&
          answer.trim().toUpperCase() ==
              q.correctAnswer.trim().toUpperCase()) {

        correct++;

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


        if (answer != null &&
            q.correctAnswer.trim().toUpperCase() ==
                answer.trim().toUpperCase()) {

          correct++;

        }

      }


      return DomainResult(

        domain: entry.key,

        totalQuestions: questions.length,

        correctAnswers: correct,

      );


    }).toList();

  }

  void goToExamReview() {

    Navigator.push(

      context,

      MaterialPageRoute(

        builder: (context) => ExamReviewScreen(

          totalQuestions: _questions.length,

          userAnswers: _userAnswers,

          onSubmit: finishExam,

        ),

      ),

    );

  }

  Future<void> finishExam() async {

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

      await _historyService.saveResult(result);


      for (var domain in result.domainResults) {

        debugPrint(
            "${domain.domain}: "
                "${domain.correctAnswers}/"
                "${domain.totalQuestions}"
        );

      }


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



  Widget answerButton(String letter, String answer) {

    final question = _questions[_currentQuestionIndex];


    final bool isSelected = _selectedAnswer == letter;


    final bool isCorrect =
        question.correctAnswer.trim().toUpperCase() ==
            letter.trim().toUpperCase();


    Color buttonColor = Colors.grey.shade200;


    if (_answered) {

      if (isCorrect) {

        buttonColor = Colors.green;

      } else if (isSelected) {

        buttonColor = Colors.red;

      }

    } else if (isSelected) {

      buttonColor = Colors.blue;

    }



    return SizedBox(

      width: double.infinity,

      child: ElevatedButton(

        style: ButtonStyle(

          backgroundColor:
          WidgetStateProperty.all(buttonColor),

          foregroundColor:
          WidgetStateProperty.all(Colors.black),

        ),


        onPressed: _answered

            ? null

            : () {

          setState(() {

            _selectedAnswer = letter;

            _userAnswers[
            question.id
            ] = letter;

          });

        },


        child: Text(

          "$letter) $answer",

        ),

      ),

    );

  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Practice Questions",
        ),

        actions: [

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

                formatTime(remainingSeconds),

                style: const TextStyle(

                  fontSize: 18,

                  fontWeight: FontWeight.bold,

                ),

              ),

            ),

          ),

        ],

      ),


      body: SafeArea(

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


              Text(

                "Question ${_currentQuestionIndex + 1} of ${_questions.length}",

                style: const TextStyle(

                  fontSize: 16,

                  fontWeight: FontWeight.bold,

                ),

              ),

              const SizedBox(height: 10),

              LinearProgressIndicator(

                value:
                (_currentQuestionIndex + 1) /
                    _questions.length,

                minHeight: 8,

              ),

              const SizedBox(height: 10),

              Text(

                "Answered: ${answeredQuestions()} / ${_questions.length}",

                style: const TextStyle(

                  fontSize: 14,

                  fontWeight: FontWeight.w500,

                ),

              ),

              const SizedBox(height: 10),

              Text(
                "Time Remaining: ${remainingSeconds ~/ 60}:${(remainingSeconds % 60).toString().padLeft(2, '0')}",
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),

              const SizedBox(height: 10),



              if (!widget.isMockExam) ...[

                Text(
                  "Domain: ${_questions[_currentQuestionIndex].domain}",
                ),


                Text(
                  "Difficulty: ${_questions[_currentQuestionIndex].difficulty}",
                ),


                Text(
                  "Type: ${_questions[_currentQuestionIndex].type}",
                ),

              ],



              const SizedBox(height: 20),



              Text(

                _questions[_currentQuestionIndex].question,

                style: const TextStyle(

                  fontSize: 22,

                  fontWeight: FontWeight.bold,

                ),

              ),



              const SizedBox(height: 20),



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

                Center(

                  child: ElevatedButton(

                    onPressed:
                    _answered ? null : checkAnswer,

                    child: const Text(
                      "CHECK ANSWER",
                    ),

                  ),

                ),



              if (_resultMessage != null)

                Padding(

                  padding: const EdgeInsets.only(top: 20),

                  child: Text(

                    _resultMessage!,

                    style: const TextStyle(

                      fontSize: 18,

                    ),

                  ),

                ),



              const SizedBox(height: 20),



              Row(

                mainAxisAlignment: MainAxisAlignment.spaceBetween,

                children: [

                  ElevatedButton(

                    onPressed: _currentQuestionIndex > 0
                        ? previousQuestion
                        : null,

                    child: const Text(
                      "PREVIOUS",
                    ),

                  ),


                  ElevatedButton(

                    onPressed: widget.isMockExam

                        ? (_currentQuestionIndex == _questions.length - 1
                        ? goToExamReview
                        : nextQuestion)

                        : (_currentQuestionIndex == _questions.length - 1 && _answered
                        ? finishExam
                        : (_answered ? nextQuestion : null)),

                    child: Text(

                      _currentQuestionIndex == _questions.length - 1

                          ? "FINISH EXAM"

                          : "NEXT",

                    ),

                  ),

                ],

              ),


            ],

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