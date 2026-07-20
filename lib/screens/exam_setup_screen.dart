import 'package:flutter/material.dart';

import 'question_screen.dart';

class ExamSetupScreen extends StatefulWidget {
  const ExamSetupScreen({super.key});

  @override
  State<ExamSetupScreen> createState() =>
      _ExamSetupScreenState();
}


class _ExamSetupScreenState extends State<ExamSetupScreen> {

  int selectedQuestions = 10;

  final List examOptions = [
    10,
    30,
    60,
    120,
    180,
  ];


  int getExamDuration(int questions) {

    switch (questions) {

      case 10:
        return 900;

      case 30:
        return 2700;

      case 60:
        return 5400;

      case 120:
        return 10800;

      case 180:
        return 13800;

      default:
        return 900;

    }

  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: const Text(
          "Exam Setup",
        ),
      ),


      body: Padding(

        padding: const EdgeInsets.all(20),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,


          children: [

            const Text(

              "Select number of questions",

              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),

            ),


            const SizedBox(height: 20),


            ...examOptions.map((number) {


              return RadioListTile<int>(

                title: Text(
                  "$number Questions",
                ),

                value: number,

                groupValue: selectedQuestions,

                onChanged: (value) {

                  setState(() {

                    selectedQuestions = value!;

                  });

                },

              );


            }),


            const Spacer(),


            SizedBox(

              width: double.infinity,

              child: ElevatedButton(

                onPressed: () {


                  Navigator.push(

                    context,

                    MaterialPageRoute(

                      builder: (context) => QuestionScreen(

                        numberOfQuestions: selectedQuestions,

                        examSeconds:
                        getExamDuration(selectedQuestions),

                        isMockExam: true,

                      ),

                    ),

                  );


                },

                child: const Text(
                  "START EXAM",
                ),

              ),

            ),

          ],

        ),

      ),

    );

  }

}