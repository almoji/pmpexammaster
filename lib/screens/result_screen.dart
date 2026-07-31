import 'package:flutter/material.dart';

import '../models/question.dart';
import '../models/domain_result.dart';

import 'history_screen.dart';
import 'review_screen.dart';


class ResultScreen extends StatelessWidget {

  final int correctAnswers;

  final int totalQuestions;

  final List<Question> incorrectQuestions;

  final List<DomainResult> domainResults;

  final bool isMockExam;

  const ResultScreen({

    super.key,

    required this.correctAnswers,

    required this.totalQuestions,

    required this.incorrectQuestions,

    required this.domainResults,

    required this.isMockExam,

  });


  @override
  Widget build(BuildContext context) {


    final percentage =
    (correctAnswers / totalQuestions * 100).round();


    final incorrectAnswers =
        totalQuestions - correctAnswers;


    final passed = percentage >= 70;

    final screenTitle =
    isMockExam ? "Exam Result" : "Practice Result";

    final resultTitle =
    isMockExam ? "PMP Exam Result" : "Practice Result";

    final historyButton =
    isMockExam ? "VIEW MOCK HISTORY" : "VIEW PRACTICE HISTORY";



    return Scaffold(

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,
        surfaceTintColor: Colors.transparent,
        title: Text(
          screenTitle,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Color(0xFF173B7A),
          ),
        ),
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
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),

              child: Container(
                width: double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
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
                  crossAxisAlignment: CrossAxisAlignment.stretch,


              children: [


                Center(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 8,
                    ),
                    child: Text(
                      passed
                          ? "Great job! Keep improving your PMP knowledge."
                          : "Keep practicing. Every question gets you closer to passing.",
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF173B7A),
                        height: 1.5,
                      ),
                    ),
                  ),
                ),



                const SizedBox(height: 5),

                Row(
                  children: [

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFFAF3),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Column(
                          children: [

                            const Text(
                              "Correct",
                              style: TextStyle(
                                color: Color(0xFF5F6C80),
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 5),

                            Text(
                              "$correctAnswers",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF18B76A),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                    const SizedBox(width: 16),

                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF2F2),
                          borderRadius: BorderRadius.circular(22),
                        ),
                        child: Column(
                          children: [

                            const Text(
                              "Incorrect",
                              style: TextStyle(
                                color: Color(0xFF5F6C80),
                                fontSize: 14,
                              ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              "$incorrectAnswers",
                              style: const TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFE5484D),
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),

                  ],
                ),

                const SizedBox(height: 15),

                ...domainResults.map((domain) {

                  Color progressColor;
                  Color percentageColor;

                  switch (domain.domain) {

                    case "People":
                      progressColor = const Color(0xFF8B5CF6);
                      percentageColor = const Color(0xFF8B5CF6);
                      break;

                    case "Business Environment":
                      progressColor = const Color(0xFFFF9800);
                      percentageColor = const Color(0xFFFF9800);
                      break;

                    default:
                      progressColor = const Color(0xFF2D86FF);
                      percentageColor = const Color(0xFF2D86FF);

                  }

                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 10,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FBFF),
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: const Color(0xFFE6EEF8),
                      ),
                    ),

                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        Row(
                          children: [

                            Expanded(
                              child: Text(
                                domain.domain,
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF173B7A),
                                ),
                              ),
                            ),

                            Text(
                              "${domain.correctAnswers}/${domain.totalQuestions}",
                              style: const TextStyle(
                                color: Color(0xFF74829C),
                                fontWeight: FontWeight.w600,
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 5),

                        ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: LinearProgressIndicator(
                            value: domain.percentage / 100,
                            minHeight: 6,
                            backgroundColor: const Color(0xFFE9EFF8),
                            color: progressColor,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "${domain.percentage.round()}%",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: percentageColor,
                            ),
                          ),
                        ),

                      ],
                    ),
                  );

                }),

                const SizedBox(height: 5),


                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF8FBFF),
                    borderRadius: BorderRadius.circular(24),
                    border: Border.all(
                      color: const Color(0xFFE6EEF8),
                    ),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(
                        width: 78,
                        height: 78,
                        child: Stack(
                          alignment: Alignment.center,
                          children: [

                            SizedBox(
                              width: 78,
                              height: 78,
                              child: CircularProgressIndicator(
                                value: percentage / 100,
                                strokeWidth: 8,
                                backgroundColor: const Color(0xFFFFD9D9),
                                valueColor: AlwaysStoppedAnimation(
                                  passed
                                      ? const Color(0xFF18B76A)
                                      : const Color(0xFFE5484D),
                                ),
                              ),
                            ),

                            Text(
                              "$percentage%",
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF173B7A),
                              ),
                            ),

                          ],
                        ),
                      ),

                      const SizedBox(width: 22),

                      Expanded(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                            const Text(
                              "Overall Score",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF74829C),
                              ),
                            ),

                            const SizedBox(height: 6),




                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 22,
                                vertical: 10,
                              ),
                              decoration: BoxDecoration(
                                color: passed
                                    ? const Color(0xFFEFFAF3)
                                    : const Color(0xFFFFF2F2),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: Text(
                                passed ? "PASSED" : "FAILED",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: passed
                                      ? const Color(0xFF18B76A)
                                      : const Color(0xFFE5484D),
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 1.5,
                                ),
                              ),
                            ),

                          ], // children del Column
                        ),   // Column
                      ),     // Expanded

                    ],       // children del Row
                  ),         // Row
                ),           // Container Overall Score

                const SizedBox(height: 15),

                SizedBox(
                  width: double.infinity,
                  height: 56,
                  child: ElevatedButton(
                    onPressed: incorrectQuestions.isEmpty
                        ? null
                        : () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ReviewScreen(
                            incorrectQuestions: incorrectQuestions,
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: const Color(0xFF2D86FF),
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: const Color(0xFFD8E4F8),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [

                        Icon(
                          Icons.fact_check_outlined,
                          size: 22,
                        ),

                        SizedBox(width: 10),

                        Text(
                          "REVIEW INCORRECT ANSWERS",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                            letterSpacing: .3,
                          ),
                        ),

                      ],
                    ),
                  ),
                ),


                const SizedBox(height: 5),



                if (!isMockExam)

                  SizedBox(
                    width: double.infinity,
                    height: 56,

                    child: OutlinedButton(

                      onPressed: () {

                        Navigator.push(

                          context,

                          MaterialPageRoute(

                            builder: (context) => HistoryScreen(),

                          ),

                        );

                      },

                      style: OutlinedButton.styleFrom(

                        foregroundColor: const Color(0xFF2D86FF),

                        side: const BorderSide(
                          color: Color(0xFFD8E4F8),
                          width: 1.3,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),

                      ),

                      child: Row(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          const Icon(
                            Icons.history,
                            size: 22,
                          ),

                          const SizedBox(width: 10),

                          Text(
                            historyButton,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                        ],

                      ),

                    ),

                  ),

                if (!isMockExam)

                  SizedBox(
                    width: double.infinity,
                    height: 56,

                    child: OutlinedButton(

                      onPressed: () {

                        Navigator.pop(context);

                      },

                      style: OutlinedButton.styleFrom(

                        foregroundColor: const Color(0xFF2D86FF),

                        side: const BorderSide(
                          color: Color(0xFFD8E4F8),
                          width: 1.3,
                        ),

                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18),
                        ),

                      ),

                      child: const Row(

                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [

                          Icon(
                            Icons.home_rounded,
                            size: 22,
                          ),

                          SizedBox(width: 10),

                          Text(
                            "BACK TO HOME",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),

                        ],

                      ),

                    ),

                  ),


              ],
              ),
              ), // Container blanco
            ),   // SingleChildScrollView
          ),     // SafeArea
        ),       // Container fondo
    );

  }

}