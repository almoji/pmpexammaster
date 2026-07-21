import 'package:flutter/material.dart';

import '../services/history_service.dart';
import '../models/exam_result.dart';
import '../models/domain_result.dart';
import '../models/question_attempt.dart';
import '../services/question_attempt_service.dart';

class DashboardScreen extends StatefulWidget {

  const DashboardScreen({super.key});


  @override
  State<DashboardScreen> createState() =>
      _DashboardScreenState();

}



class _DashboardScreenState extends State<DashboardScreen> {


  final HistoryService _historyService =
  HistoryService();
  final QuestionAttemptService _questionAttemptService =
  QuestionAttemptService();

  List<ExamResult> results = [];
  List<QuestionAttempt> attempts = [];

  bool loading = true;



  @override
  void initState() {

    super.initState();

    loadData();

  }



  Future<void> loadData() async {


    final data =
    await _historyService.getResults();

    final questionAttempts =
    await _questionAttemptService.getAttempts();


    setState(() {
      results = data;
      attempts = questionAttempts;
      loading = false;
    });

  }




  double get averageScore {

    if(results.isEmpty) {

      return 0;

    }

    final total =
    results.fold<int>(
      0,
          (sum,item) =>
      sum + item.percentage,
    );

    return total / results.length;

  }

  int get attemptsCorrect {

    return attempts.where((a) => a.correct).length;

  }

  int get attemptsIncorrect {

    return attempts.where((a) => !a.correct).length;

  }

  double get attemptsAccuracy {

    if (attempts.isEmpty) {

      return 0;

    }

    return (attemptsCorrect / attempts.length) * 100;

  }




  int get totalQuestionsAnswered {

    if(results.isEmpty) {
      return 0;
    }

    return results.fold<int>(
        0,
            (sum, item) =>
        sum + item.totalQuestions
    );

  }


  int get totalCorrectAnswers {

    if(results.isEmpty) {
      return 0;
    }

    return results.fold<int>(
        0,
            (sum, item) =>
        sum + item.correctAnswers
    );

  }


  int get totalIncorrectAnswers {

    if(results.isEmpty) {
      return 0;
    }

    return results.fold<int>(
        0,
            (sum, item) =>
        sum + item.incorrectAnswers
    );

  }


  double get globalAccuracy {

    if(totalQuestionsAnswered == 0) {
      return 0;
    }

    return
      (totalCorrectAnswers /
          totalQuestionsAnswered) * 100;

  }

  double get readinessScore {

    if(results.isEmpty) {
      return 0;
    }


    double accuracyFactor = globalAccuracy;


    double practiceFactor =
    totalQuestionsAnswered >= 500
        ? 100
        : (totalQuestionsAnswered / 500) * 100;


    double examFactor = averageScore;


    return (
        accuracyFactor * 0.4 +
            practiceFactor * 0.2 +
            examFactor * 0.4
    );

  }


  int get bestScore {

    if(results.isEmpty) {

      return 0;

    }


    return results
        .map((e) => e.percentage)
        .reduce(
            (a,b) => a > b ? a : b
    );

  }


  String get status {

    if(averageScore >= 85) {

      return "PMP Ready 🚀";

    }


    if(averageScore >= 70) {

      return "Good Progress";

    }


    if(averageScore >= 50) {

      return "Improving";

    }


    return "Needs Improvement";

  }







  Color get statusColor {


    if(averageScore >=85){

      return Colors.green;

    }


    if(averageScore >=70){

      return Colors.blue;

    }


    if(averageScore >=50){

      return Colors.orange;

    }


    return Colors.red;

  }

  Map<String, DomainResult> get domainStatistics {

    final Map<String, DomainResult> domains = {};

    for (final attempt in attempts) {

      if (attempt.domain.isEmpty) continue;

      if (!domains.containsKey(attempt.domain)) {

        domains[attempt.domain] = DomainResult(
          domain: attempt.domain,
          totalQuestions: 1,
          correctAnswers: attempt.correct ? 1 : 0,
        );

      } else {

        final current = domains[attempt.domain]!;

        domains[attempt.domain] = DomainResult(
          domain: current.domain,
          totalQuestions: current.totalQuestions + 1,
          correctAnswers: current.correctAnswers + (attempt.correct ? 1 : 0),
        );

      }

    }


    return domains;

  }

  String getDomainLevel(double percentage) {

    if (percentage >= 85) {

      return "Excellent";

    }

    if (percentage >= 70) {

      return "Good";

    }

    if (percentage >= 50) {

      return "Needs Practice";

    }

    return "Focus Here";

  }

  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title:
        const Text(
            "PMP Dashboard"
        ),

        centerTitle: true,

      ),



      body: loading


          ? const Center(

        child:
        CircularProgressIndicator(),

      )

          :

      SingleChildScrollView(

        padding:
        const EdgeInsets.all(20),


        child: Column(


          children: [



            Card(

              elevation:4,

              child:
              Padding(

                padding:
                const EdgeInsets.all(20),


                child:
                Column(

                  children: [


                    const Text(

                      "PMP Progress",

                      style:
                      TextStyle(

                        fontSize:22,

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),



                    const SizedBox(height:20),



                    SizedBox(

                      height:150,

                      width:150,


                      child:
                      Stack(

                        alignment:
                        Alignment.center,


                        children: [


                          CircularProgressIndicator(

                            value:
                            averageScore / 100,


                            strokeWidth:12,

                          ),



                          Text(

                            "${averageScore.round()}%",

                            style:
                            const TextStyle(

                              fontSize:30,

                              fontWeight:
                              FontWeight.bold,

                            ),

                          )


                        ],

                      ),

                    ),



                    const SizedBox(height:20),



                    Text(

                      status,

                      style:
                      TextStyle(

                        fontSize:22,

                        fontWeight:
                        FontWeight.bold,

                        color:
                        statusColor,

                      ),

                    )


                  ],

                ),

              ),

            ),




            const SizedBox(height:20),




            Row(

              children: [

                Expanded(
                  child:
                  _infoCard(

                    "✅ Correct",

                    "$attemptsCorrect",

                  ),
                ),


                const SizedBox(width:10),


                Expanded(
                  child:
                  _infoCard(

                    "❌ Incorrect",

                    "$attemptsIncorrect",

                  ),
                ),


              ],

            ),


            const SizedBox(height:10),


            _infoCard(

              "🎯 Accuracy",

              "${attemptsAccuracy.round()}%",

            ),




            const SizedBox(height:10),




            _infoCard(

              "🏆 Best Score",

              "$bestScore%",

            ),


            const SizedBox(height:10),


            _infoCard(

              "📝 Questions Practiced",

              "${attempts.length}",

            ),

            const SizedBox(height: 30),

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Performance by Domain",
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            const SizedBox(height: 15),

            ...domainStatistics.values.map((domain) {

              return Padding(

                padding: const EdgeInsets.only(bottom: 15),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Text(

                      "${domain.domain} (${domain.percentage.round()}%)",

                      style: const TextStyle(

                        fontWeight: FontWeight.bold,

                        fontSize: 16,

                      ),

                    ),

                    const SizedBox(height: 6),

                    LinearProgressIndicator(

                      value: domain.percentage / 100,

                      minHeight: 10,

                    ),

                    const SizedBox(height: 6),

                    Text(

                      getDomainLevel(domain.percentage),

                      style: TextStyle(

                        color: domain.percentage >= 70
                            ? Colors.green
                            : Colors.orange,

                        fontWeight: FontWeight.w600,

                      ),

                    ),

                  ],

                ),

              );

            }),


            const SizedBox(height:30),




            const Align(

              alignment:
              Alignment.centerLeft,


              child:
              Text(

                "Latest Exams",

                style:
                TextStyle(

                  fontSize:22,

                  fontWeight:
                  FontWeight.bold,

                ),

              ),


            ),

            const SizedBox(height:20),


            Text(

              "PMP Readiness",

              style:
              const TextStyle(

                fontSize:18,

                fontWeight:
                FontWeight.bold,

              ),

            ),


            const SizedBox(height:10),


            LinearProgressIndicator(

              value: readinessScore / 100,

              minHeight: 12,

            ),


            const SizedBox(height:8),


            Text(

              "${readinessScore.round()}%",

              style:
              const TextStyle(

                fontSize:24,

                fontWeight:
                FontWeight.bold,

              ),

            ),




            const SizedBox(height:10),




            results.isEmpty


                ? const Text(
              "No exams completed yet",
            )



                :

            ListView.builder(

              shrinkWrap:true,

              physics:
              const NeverScrollableScrollPhysics(),


              itemCount:
              results.length,


              itemBuilder:
                  (context,index){


                final result =
                results[
                results.length -
                    1 -
                    index
                ];



                return Card(


                  child:
                  ListTile(


                    leading:
                    Icon(

                      result.passed

                          ? Icons.check_circle

                          : Icons.cancel,


                      color:
                      result.passed

                          ? Colors.green

                          : Colors.red,

                    ),



                    title:
                    Text(

                      "${result.date.day}/"
                          "${result.date.month}/"
                          "${result.date.year}",

                    ),



                    trailing:
                    Text(

                      "${result.percentage}%",

                      style:
                      const TextStyle(

                        fontWeight:
                        FontWeight.bold,

                      ),

                    ),


                  ),

                );


              },

            )



          ],

        ),

      ),

    );

  }





  Widget _infoCard(String title,String value){


    return Card(

      elevation:3,


      child:
      Padding(

        padding:
        const EdgeInsets.all(16),


        child:
        Column(

          children: [


            Text(

              title,

              style:
              const TextStyle(

                fontSize:16,

              ),

            ),



            const SizedBox(height:8),



            Text(

              value,

              style:
              const TextStyle(

                fontSize:26,

                fontWeight:
                FontWeight.bold,

              ),

            )


          ],

        ),

      ),

    );


  }


}