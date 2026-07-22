import 'package:flutter/material.dart';

import '../models/exam_result.dart';
import '../services/history_service.dart';


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
          "Exam History",
        ),

      ),



      body: loading


          ? const Center(

        child: CircularProgressIndicator(),

      )



          : results.isEmpty


          ? const Center(

        child: Text(

          "No exams completed yet",

          style: TextStyle(

            fontSize: 18,

          ),

        ),

      )



          : ListView.builder(


        padding: const EdgeInsets.all(16),


        itemCount: results.length,


        itemBuilder: (context, index) {


          final result = results[index];



          return Card(


            margin: const EdgeInsets.only(bottom: 15),


            child: Padding(


              padding: const EdgeInsets.all(16),


              child: Column(


                crossAxisAlignment:
                CrossAxisAlignment.start,


                children: [



                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        result.passed ? "PASSED ✅" : "FAILED ❌",
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: result.passed ? Colors.green : Colors.red,
                        ),
                      ),
                      Text(
                        "${result.date.day}/${result.date.month}/${result.date.year}",
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),



                  const SizedBox(height: 10),



                  Text(
                    "${result.percentage}%",
                    style: const TextStyle(
                      fontSize: 34,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Text(
                    "Questions: ${result.totalQuestions}",
                  ),


                  Text(

                    "Correct Answers: ${result.correctAnswers}",

                  ),



                  Text(

                    "Incorrect Answers: ${result.incorrectAnswers}",

                  ),






                ],

              ),

            ),

          );


        },

      ),


    );

  }


}