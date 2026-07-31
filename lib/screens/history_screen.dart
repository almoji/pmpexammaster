import 'package:flutter/material.dart';

import '../models/exam_result.dart';
import '../services/history_service.dart';
import 'exam_detail_screen.dart';


class HistoryScreen extends StatefulWidget {

  const HistoryScreen({super.key});


  @override
  State<HistoryScreen> createState() => _HistoryScreenState();

}


class _HistoryScreenState extends State<HistoryScreen> {


  final HistoryService _historyService = HistoryService();


  List<ExamResult> results = [];


  bool loading = true;



  @override
  void initState() {

    super.initState();

    loadHistory();

  }



  Future<void> loadHistory() async {


    final data = await _historyService.getResults();


    setState(() {

      results = data;

      loading = false;

    });


  }



  @override
  Widget build(BuildContext context) {


    return Scaffold(


      appBar: AppBar(

        title: const Text(
          "Practice History",
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

        child: CircularProgressIndicator(),

      )



          : results.isEmpty


          ? const Center(

        child: Text(

          "No exams completed yet",

          style: TextStyle(

            fontSize: 16,

          ),

        ),

      )



          : ListView.builder(


        padding: const EdgeInsets.all(16),


        itemCount: results.length,


        itemBuilder: (context, index) {


          final result = results[index];



          return Card(

            elevation: 0,

            margin: const EdgeInsets.only(bottom: 18),

            color: Colors.white,

            shape: RoundedRectangleBorder(

              borderRadius: BorderRadius.circular(24),

              side: const BorderSide(

                color: Color(0xFFE7EEF8),

              ),

            ),

              child: InkWell(

                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ExamDetailScreen(
                        result: result,
                      ),
                    ),
                  );
                },

                child: Padding(


              padding: const EdgeInsets.all(16),


              child: Column(


                crossAxisAlignment:
                CrossAxisAlignment.start,


                children: [



                  Row(

                    mainAxisAlignment: MainAxisAlignment.spaceBetween,

                    children: [

                      Container(

                        padding: const EdgeInsets.symmetric(

                          horizontal: 14,

                          vertical: 8,

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

                            fontWeight: FontWeight.bold,

                            color: result.passed

                                ? const Color(0xFF18B76A)

                                : const Color(0xFFE5484D),

                          ),

                        ),

                      ),

                      Row(

                        children: [

                          const Icon(

                            Icons.calendar_today_rounded,

                            size: 16,

                            color: Color(0xFF74829C),

                          ),

                          const SizedBox(width: 6),

                          Text(

                            "${result.date.day}/${result.date.month}/${result.date.year}",

                            style: const TextStyle(

                              color: Color(0xFF74829C),

                              fontWeight: FontWeight.w600,

                            ),

                          ),

                        ],

                      ),

                    ],

                  ),



                  const SizedBox(height: 10),



                  Row(

                    crossAxisAlignment: CrossAxisAlignment.center,

                    children: [

                      Expanded(

                        child: Text(

                          "${result.percentage}%",

                          style: const TextStyle(

                            fontSize: 54,

                            fontWeight: FontWeight.bold,

                            color: Color(0xFF173B7A),

                            height: 1,

                          ),

                        ),

                      ),

                      Container(

                        width: 74,

                        height: 74,

                        decoration: BoxDecoration(

                          color: result.passed
                              ? const Color(0xFFEFFAF3)
                              : const Color(0xFFFFF2F2),

                          shape: BoxShape.circle,

                        ),

                        child: Icon(

                          result.passed
                              ? Icons.emoji_events_rounded
                              : Icons.flag_rounded,

                          size: 38,

                          color: result.passed
                              ? const Color(0xFF18B76A)
                              : const Color(0xFFE5484D),

                        ),

                      ),

                    ],

                  ),



                  Divider(

                    color: Color(0xFFE7EEF8),

                    thickness: 1,

                  ),



                  Divider(

                    color: Color(0xFFE7EEF8),
                    height: 5,
                    thickness: 1,

                  ),


                  _historyItem(

                    Icons.help_outline_rounded,

                    "Questions",

                    result.totalQuestions.toString(),

                    const Color(0xFF2D86FF),

                  ),



                  _historyItem(

                    Icons.check_circle_outline_rounded,

                    "Correct Answers",

                    result.correctAnswers.toString(),

                    const Color(0xFF18B76A),

                  ),



                  _historyItem(

                    Icons.cancel_outlined,

                    "Incorrect Answers",

                    result.incorrectAnswers.toString(),

                    const Color(0xFFE5484D),

                  ),






                ],

              ), // Column

                ), // Padding

              ), // InkWell

          ); // Card


        },

          ),

        ),

    );

  }

  Widget _historyItem(

      IconData icon,

      String title,

      String value,

      Color color,

      ) {

    return Row(

      children: [

        Container(

          width: 30,

          height: 30,

          decoration: BoxDecoration(

            color: color.withValues(alpha: 0.10),

            shape: BoxShape.circle,

          ),

          child: Icon(

            icon,

            color: color,

            size: 16,

          ),

        ),

        const SizedBox(width: 14),

        Expanded(

          child: Text(

            title,

            style: const TextStyle(

              fontSize: 15,

              fontWeight: FontWeight.w600,

              color: Color(0xFF173B7A),

            ),

          ),

        ),

        Text(

          value,

          style: const TextStyle(

            fontSize: 16,

            fontWeight: FontWeight.bold,

            color: Color(0xFF173B7A),

          ),

        ),

      ],

    );

  }

}