import 'package:flutter/material.dart';

class ExamReviewScreen extends StatelessWidget {

  final int totalQuestions;

  final Map<int, String> userAnswers;

  final VoidCallback onSubmit;

  const ExamReviewScreen({

    super.key,

    required this.totalQuestions,

    required this.userAnswers,

    required this.onSubmit,

  });


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Review Exam",
        ),

      ),


      body: Padding(

        padding: const EdgeInsets.all(16),

        child: Column(

          crossAxisAlignment: CrossAxisAlignment.start,

          children: [


            Text(

              "Answered: ${userAnswers.length} / $totalQuestions",

              style: const TextStyle(

                fontSize: 22,

                fontWeight: FontWeight.bold,

              ),

            ),


            const SizedBox(height: 20),


            Expanded(

              child: ListView.builder(

                itemCount: totalQuestions,

                itemBuilder: (context, index) {


                  final answer =
                  userAnswers[index + 1];


                  return Card(

                    child: ListTile(

                      leading: CircleAvatar(

                        child: Text(
                          "${index + 1}",
                        ),

                      ),


                      title: Text(

                        answer == null

                            ? "Not answered"

                            : "Answer: $answer",

                      ),

                    ),

                  );


                },

              ),

            ),


            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {

                  Navigator.pop(context);

                },

                child: const Text(

                  "BACK TO EXAM",

                ),

              ),

            ),


            const SizedBox(height: 15),


            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: onSubmit,

                child: const Text(

                  "SUBMIT EXAM",

                ),

              ),

            ),


          ],


        ),

      ),

    );

  }

}