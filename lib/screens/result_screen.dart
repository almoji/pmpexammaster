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



    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Exam Result",
        ),

      ),


      body: Center(

        child: Card(

          elevation: 8,

          margin: const EdgeInsets.all(20),


          child: Padding(

            padding: const EdgeInsets.all(25),


            child: Column(

              mainAxisSize: MainAxisSize.min,

              mainAxisAlignment: MainAxisAlignment.center,


              children: [


                const Text(

                  "PMP Exam Result",

                  style: TextStyle(

                    fontSize: 28,

                    fontWeight: FontWeight.bold,

                  ),

                ),



                const SizedBox(height: 30),



                Text(

                  "Correct Answers: $correctAnswers / $totalQuestions",

                  style: const TextStyle(

                    fontSize: 20,

                  ),

                ),



                const SizedBox(height: 15),



                Text(

                  "Incorrect Answers: $incorrectAnswers",

                  style: const TextStyle(

                    fontSize: 20,

                  ),

                ),



                const SizedBox(height: 20),


                const Text(
                  "Performance by Domain",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 15),

                ...domainResults.map((DomainResult domain) {

                  return Padding(

                    padding: const EdgeInsets.only(bottom: 10),

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        Text(
                          "${domain.domain}: ${domain.correctAnswers}/${domain.totalQuestions}",
                          style: const TextStyle(
                            fontSize: 16,
                          ),
                        ),

                        LinearProgressIndicator(
                          value: domain.percentage / 100,
                          minHeight: 10,
                        ),

                      ],

                    ),

                  );

                }),

                const SizedBox(height: 20),


                Text(

                  "Score: $percentage%",

                  style: const TextStyle(

                    fontSize: 24,

                    fontWeight: FontWeight.bold,

                  ),

                ),



                const SizedBox(height: 20),





                const SizedBox(height: 30),



                Text(

                  passed ? "PASSED ✅" : "FAILED ❌",

                  style: const TextStyle(

                    fontSize: 26,

                    fontWeight: FontWeight.bold,

                  ),

                ),


                const SizedBox(height: 15),


                ElevatedButton(

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


                  child: const Text(

                    "REVIEW INCORRECT ANSWERS",

                  ),

                ),


                const SizedBox(height: 15),



                if (!isMockExam)

                  ElevatedButton(

                    onPressed: () {

                      Navigator.push(

                        context,

                        MaterialPageRoute(

                          builder: (context) => HistoryScreen(),

                        ),

                      );

                    },

                    child: const Text(

                      "VIEW EXAM HISTORY",

                    ),

                  ),

                if (!isMockExam)

                  ElevatedButton(

                    onPressed: () {

                      Navigator.pop(context);

                    },

                    child: const Text(

                      "BACK TO EXAM",

                    ),

                  ),


              ],

            ),

          ),

        ),

      ),

    );

  }

}