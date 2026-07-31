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

        elevation: 0,

        backgroundColor: Colors.transparent,

        surfaceTintColor: Colors.transparent,

        centerTitle: true,

        title: const Text(

          "PMP Dashboard",

          style: TextStyle(

            color: Color(0xFF173B7A),

            fontWeight: FontWeight.bold,

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

          child: loading


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



            Container(

              width: double.infinity,

              padding: const EdgeInsets.fromLTRB(22, 14, 22, 14),

              decoration: BoxDecoration(

                color: Colors.white,

                borderRadius: BorderRadius.circular(26),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black.withValues(alpha: 0.05),

                    blurRadius: 25,

                    spreadRadius: -8,

                    offset: const Offset(0, 12),

                  ),

                ],

              ),

              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [


                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [

                      SizedBox(

                        width: 190,

                        height: 190,

                        child: Stack(

                          alignment: Alignment.center,

                          children: [

                            SizedBox(

                              width: 140,

                              height: 140,

                              child: CircularProgressIndicator(

                                value: averageScore / 100,

                                strokeWidth: 18,

                                backgroundColor: const Color(0xFFE9EFF8),

                                color: const Color(0xFF3D73F6),

                              ),

                            ),

                            RichText(

                              text: TextSpan(

                                children: [

                                  TextSpan(

                                    text: averageScore.round().toString(),

                                    style: const TextStyle(

                                      fontSize: 42,

                                      fontWeight: FontWeight.bold,

                                      color: Color(0xFF173B7A),

                                    ),

                                  ),

                                  const TextSpan(

                                    text: "%",

                                    style: TextStyle(

                                      fontSize: 22,

                                      fontWeight: FontWeight.bold,

                                      color: Color(0xFF173B7A),

                                    ),

                                  ),

                                ],

                              ),

                            ),

                          ],

                        ),

                      ),

                      const SizedBox(width: 10),

                      Expanded(

                        child: Column(

                          crossAxisAlignment: CrossAxisAlignment.start,

                          children: [

                            Text(

                              "$status 🚀",

                              style: TextStyle(

                                fontSize: 22,

                                fontWeight: FontWeight.bold,

                                color: statusColor,

                              ),

                            ),

                            const SizedBox(height: 12),

                            const Text(

                              "Keep going!\nYou're almost there.",

                              style: TextStyle(

                                fontSize: 16,

                                height: 1.5,

                                color: Color(0xFF74829C),

                              ),

                            ),

                          ],

                        ),

                      ),

                    ],

                  ),

                ],

              ),

            ),




            const SizedBox(height:5),




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

            const SizedBox(height: 8),

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

            Container(

              width: double.infinity,

              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),

              decoration: BoxDecoration(

                borderRadius: BorderRadius.circular(24),

                gradient: const LinearGradient(

                  begin: Alignment.topLeft,

                  end: Alignment.bottomRight,

                  colors: [

                    Color(0xFFF3EEFF),

                    Color(0xFFEAF4FF),

                  ],

                ),

                boxShadow: [

                  BoxShadow(

                    color: Colors.black.withValues(alpha: 0.05),

                    blurRadius: 22,

                    spreadRadius: -6,

                    offset: const Offset(0, 10),

                  ),

                ],

              ),

              child: Row(

                children: [

                  Expanded(

                    child: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [

                        const Text(

                          "Questions Practiced",

                          style: TextStyle(

                            fontSize: 15,

                            color: Color(0xFF74829C),

                            fontWeight: FontWeight.w600,

                          ),

                        ),

                        const SizedBox(height: 8),

                        Text(

                          "${attempts.length}",

                          style: const TextStyle(

                            fontSize: 34,

                            fontWeight: FontWeight.bold,

                            color: Color(0xFF173B7A),

                          ),

                        ),

                        const SizedBox(height: 6),

                        const Text(

                          "Total questions answered",

                          style: TextStyle(

                            fontSize: 14,

                            color: Color(0xFF74829C),

                          ),

                        ),

                      ],

                    ),

                  ),

                  Container(

                    width: 72,

                    height: 72,

                    decoration: BoxDecoration(

                      color: Colors.white.withValues(alpha: 0.75),

                      shape: BoxShape.circle,

                    ),

                    child: const Icon(

                      Icons.menu_book_rounded,

                      color: Color(0xFF6C4CF7),

                      size: 36,

                    ),

                  ),

                ],

              ),

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

              Color progressColor;
              Color percentageColor;
              Color badgeColor;

              switch (domain.domain) {

                case "People":
                  progressColor = const Color(0xFF8B5CF6);
                  percentageColor = const Color(0xFF8B5CF6);
                  badgeColor = const Color(0xFFF5F0FF);
                  break;

                case "Business Environment":
                  progressColor = const Color(0xFFFF9800);
                  percentageColor = const Color(0xFFFF9800);
                  badgeColor = const Color(0xFFFFF7E8);
                  break;

                default:
                  progressColor = const Color(0xFF2D86FF);
                  percentageColor = const Color(0xFF2D86FF);
                  badgeColor = const Color(0xFFEAF4FF);

              }

              return Container(

                margin: const EdgeInsets.only(bottom: 12),

                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 18,
                ),

                decoration: BoxDecoration(

                  color: badgeColor.withValues(alpha: 0.35),

                  borderRadius: BorderRadius.circular(20),

                  border: Border.all(

                    color: badgeColor,

                    width: 1.2,

                  ),

                ),

                child: Column(

                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [

                    Row(

                      children: [

                        Text(

                          domain.domain,

                          style: const TextStyle(

                            fontSize: 17,

                            fontWeight: FontWeight.bold,

                            color: Color(0xFF173B7A),

                          ),

                        ),

                        const Spacer(),

                        Container(

                          padding: const EdgeInsets.symmetric(

                            horizontal: 10,

                            vertical: 4,

                          ),

                          decoration: BoxDecoration(

                            color: badgeColor,

                            borderRadius: BorderRadius.circular(20),

                          ),

                          child: Text(

                            "${domain.percentage.round()}%",

                            style: TextStyle(

                              color: percentageColor,

                              fontWeight: FontWeight.bold,

                            ),

                          ),

                        ),

                      ],

                    ),

                    const SizedBox(height: 6),

                    ClipRRect(

                      borderRadius: BorderRadius.circular(10),

                      child: LinearProgressIndicator(

                        value: domain.percentage / 100,

                        minHeight: 12,

                        backgroundColor: const Color(0xFFEAF1FB),

                        valueColor: AlwaysStoppedAnimation<Color>(progressColor),

                      ),

                    ),

                    const SizedBox(height: 6),

                    Align(

                      alignment: Alignment.centerLeft,

                      child: Container(

                        padding: const EdgeInsets.symmetric(

                          horizontal: 12,

                          vertical: 6,

                        ),

                        decoration: BoxDecoration(

                          color: badgeColor,

                          borderRadius: BorderRadius.circular(20),

                        ),

                        child: Text(

                          getDomainLevel(domain.percentage),

                          style: TextStyle(

                            color: percentageColor,

                            fontWeight: FontWeight.bold,

                            fontSize: 13,

                          ),

                        ),

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


            Container(

              width: double.infinity,

              padding: const EdgeInsets.all(20),

              decoration: BoxDecoration(

                color: const Color(0xFFF7FAFF),

                borderRadius: BorderRadius.circular(22),

                border: Border.all(

                  color: const Color(0xFFE7EEFA),

                ),

              ),

              child: Column(

                children: [

                  const Text(

                    "PMP Readiness",

                    style: TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                      color: Color(0xFF173B7A),

                    ),

                  ),

                  const SizedBox(height: 18),

                  ClipRRect(

                    borderRadius: BorderRadius.circular(10),

                    child: LinearProgressIndicator(

                      value: readinessScore / 100,

                      minHeight: 12,

                      backgroundColor: const Color(0xFFEAF1FB),

                      valueColor: const AlwaysStoppedAnimation(

                        Color(0xFF2D86FF),

                      ),

                    ),

                  ),

                  const SizedBox(height: 14),

                  Text(

                    "${readinessScore.round()}%",

                    style: const TextStyle(

                      fontSize: 34,

                      fontWeight: FontWeight.bold,

                      color: Color(0xFF173B7A),

                    ),

                  ),

                  const SizedBox(height: 6),

                  const Text(

                    "Estimated exam readiness",

                    style: TextStyle(

                      color: Color(0xFF74829C),

                      fontSize: 14,

                    ),

                  ),

                ],

              ),

            ),

            const SizedBox(height: 18),




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


                    final sortedResults = [...results]
                      ..sort((a, b) => b.date.compareTo(a.date));

                    final result = sortedResults[index];



                return Card(

                  elevation: 0,

                  color: Colors.white,

                  margin: const EdgeInsets.only(bottom: 12),

                  shape: RoundedRectangleBorder(

                    borderRadius: BorderRadius.circular(20),

                    side: const BorderSide(

                      color: Color(0xFFE7EEF8),

                    ),

                  ),

                  child: ListTile(

                    contentPadding: const EdgeInsets.symmetric(

                      horizontal: 20,

                      vertical: 8,

                    ),


                    leading: Container(

                      width: 48,

                      height: 48,

                      decoration: BoxDecoration(

                        color: result.passed

                            ? const Color(0xFFEFFAF3)

                            : const Color(0xFFFFF2F2),

                        shape: BoxShape.circle,

                      ),

                      child: Icon(

                        result.passed

                            ? Icons.check_rounded

                            : Icons.close_rounded,

                        color: result.passed

                            ? const Color(0xFF18B76A)

                            : const Color(0xFFE5484D),

                      ),

                    ),



                    title: Column(

                      crossAxisAlignment: CrossAxisAlignment.start,

                      mainAxisAlignment: MainAxisAlignment.center,

                      children: [

                        Text(

                          "${result.date.day}/${result.date.month}/${result.date.year}",

                          style: const TextStyle(

                            fontSize: 16,

                            fontWeight: FontWeight.bold,

                            color: Color(0xFF173B7A),

                          ),

                        ),

                        const SizedBox(height: 6),

                        Container(

                          padding: const EdgeInsets.symmetric(

                            horizontal: 10,

                            vertical: 4,

                          ),

                          decoration: BoxDecoration(

                            color: result.passed

                                ? const Color(0xFFEFFAF3)

                                : const Color(0xFFFFF2F2),

                            borderRadius: BorderRadius.circular(20),

                          ),

                          child: Text(

                            result.passed ? "PASSED" : "FAILED",

                            style: TextStyle(

                              fontSize: 11,

                              fontWeight: FontWeight.bold,

                              color: result.passed

                                  ? const Color(0xFF18B76A)

                                  : const Color(0xFFE5484D),

                            ),

                          ),

                        ),

                      ],

                    ),



                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          "${result.percentage}%",
                          style: const TextStyle(

                            fontWeight: FontWeight.bold,

                            fontSize: 28,

                            color: Color(0xFF173B7A),

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

        ),

    );

  }





  Widget _infoCard(String title, String value) {

    IconData icon;
    Color iconColor;
    Color backgroundColor;
    Color cardColor;

    switch (title) {

      case "✅ Correct":
        icon = Icons.check_circle;
        iconColor = const Color(0xFF18B76A);
        backgroundColor = const Color(0xFFEFFAF3);
        cardColor = const Color(0xFFEAFBF0);
        break;

      case "❌ Incorrect":
        icon = Icons.cancel;
        iconColor = const Color(0xFFE5484D);
        backgroundColor = const Color(0xFFFFF2F2);
        cardColor = const Color(0xFFFFEFEF);
        break;

      case "🎯 Accuracy":
        icon = Icons.track_changes;
        iconColor = const Color(0xFF7A4DFF);
        backgroundColor = const Color(0xFFF5F0FF);
        cardColor = const Color(0xFFF2ECFF);
        break;

      case "🏆 Best Score":
        icon = Icons.emoji_events_rounded;
        iconColor = const Color(0xFFFF9800);
        backgroundColor = const Color(0xFFFFF7E8);
        cardColor = const Color(0xFFFFF4DF);
        break;

      default:
        icon = Icons.menu_book_rounded;
        iconColor = const Color(0xFF2D86FF);
        backgroundColor = const Color(0xFFEAF4FF);
        cardColor = const Color(0xFFF7FAFF);
    }

    return Container(

      padding: const EdgeInsets.symmetric(
        horizontal: 14,
        vertical: 12,
      ),

      decoration: BoxDecoration(

        color: cardColor,

        borderRadius: BorderRadius.circular(22),

        boxShadow: [

          BoxShadow(

            color: Colors.black.withValues(alpha: 0.05),

            blurRadius: 22,

            spreadRadius: -6,

            offset: const Offset(0, 10),

          ),

        ],

      ),

      child: Column(

        mainAxisAlignment: MainAxisAlignment.center,

        children: [

          Container(

            width: 54,
            height: 54,

            decoration: BoxDecoration(

              color: backgroundColor,

              shape: BoxShape.circle,

            ),

            child: Icon(

              icon,

              color: iconColor,

              size: 28,

            ),

          ),

          const SizedBox(height: 0),

          Text(

            value,

            style: const TextStyle(

              fontSize: 30,

              fontWeight: FontWeight.bold,

              color: Color(0xFF173B7A),

            ),

          ),

          const SizedBox(height: 4),

          Text(

            title
                .replaceAll("✅ ", "")
                .replaceAll("❌ ", "")
                .replaceAll("🎯 ", "")
                .replaceAll("🏆 ", "")
                .replaceAll("📝 ", ""),

            textAlign: TextAlign.center,

            style: const TextStyle(

              fontSize: 14,

              fontWeight: FontWeight.w600,

              color: Color(0xFF74829C),

            ),

          ),

        ],

      ),

    );

  }


}