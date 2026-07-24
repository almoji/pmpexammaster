import 'package:flutter/material.dart';

import '../services/history_service.dart';
import '../models/exam_result.dart';
import '../models/question_attempt.dart';
import '../services/question_attempt_service.dart';
import '../services/dashboard_statistics_service.dart';
import '../services/exam_statistics_service.dart';
import '../widgets/exam_trend_card.dart';

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

  late DashboardStatisticsService stats;
  late ExamStatisticsService examStats;

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

      stats = DashboardStatisticsService(
        attempts: attempts,
      );

      examStats = ExamStatisticsService(
        results: results,
      );

      loading = false;
    });

  }




  double get averageScore {

    return examStats.averageScore;

  }

  int get attemptsCorrect {

    return stats.attemptsCorrect;

  }

  int get attemptsIncorrect {

    return stats.attemptsIncorrect;

  }





  int get totalQuestionsAnswered {

    return stats.questionsPracticed;

  }






  double get globalAccuracy {

    return stats.globalAccuracy;

  }

  double get readinessScore {

    if(results.isEmpty) {
      return 0;
    }


    final accuracyFactor = stats.globalAccuracy;

    final practiceFactor =
    stats.questionsPracticed >= 500
        ? 100
        : (stats.questionsPracticed / 500) * 100;

    final examFactor = examStats.averageScore;


    return (
        accuracyFactor * 0.4 +
            practiceFactor * 0.2 +
            examFactor * 0.4
    );

  }


  int get bestScore {

    return examStats.bestScore;

  }





  String get status {

    return examStats.status;

  }







  Color get statusColor {

    return examStats.statusColor;

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

                      "Progress",

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
                  child: _infoCard(
                    "✅ Correct",
                    "$attemptsCorrect",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _infoCard(
                    "❌ Incorrect",
                    "$attemptsIncorrect",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

            Row(
              children: [
                Expanded(
                  child: _infoCard(
                    "🎯 Accuracy",
                    "${globalAccuracy.round()}%",
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: _infoCard(
                    "🏆 Best Score",
                    "$bestScore%",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),

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

            ...stats.domainStatistics.values.map((domain) {

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


            const SizedBox(height: 30),

            if (results.isNotEmpty) ...[
              ExamTrendCard(
                results: results.reversed.take(5).toList(),
              ),
              const SizedBox(height: 30),
            ],

            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
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



                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${result.percentage}%",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        Text(
                          result.passed ? "PASSED" : "FAILED",
                          style: TextStyle(
                            fontSize: 12,
                            color: result.passed ? Colors.green : Colors.red,
                          ),
                        ),
                      ],
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





  Widget _infoCard(String title, String value) {


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