import 'package:flutter/material.dart';
import 'question_screen.dart';

class MockExamSetupScreen extends StatelessWidget {

  const MockExamSetupScreen({super.key});


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Mock Exam Setup",
        ),
      ),


      body: Center(

        child: Column(

          mainAxisAlignment:
          MainAxisAlignment.center,


          children: [


            const Text(

              "PMP Mock Exam",

              style: TextStyle(

                fontSize: 28,

                fontWeight: FontWeight.bold,

              ),

            ),


            const SizedBox(height: 30),


            const Text(

              "180 Questions\n230 Minutes",

              textAlign: TextAlign.center,

              style: TextStyle(

                fontSize: 22,

              ),

            ),


            const SizedBox(height: 40),


            ElevatedButton(

              onPressed: () {

                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) =>
                    const QuestionScreen(

                      numberOfQuestions: 5,

                      examSeconds: 600,

                      isMockExam: true,

                    ),

                  ),

                );

              },

              child: const Text(

                "START MOCK EXAM",

              ),

            ),

          ],

        ),

      ),

    );

  }

}