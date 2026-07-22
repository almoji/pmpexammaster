import 'package:flutter/material.dart';

import '../models/question.dart';


class ReviewScreen extends StatelessWidget {

  final List<Question> incorrectQuestions;


  const ReviewScreen({

    super.key,

    required this.incorrectQuestions,

  });


  @override
  Widget build(BuildContext context) {


    return Scaffold(

      appBar: AppBar(

        title: const Text(

          "Review Incorrect Answers",

        ),

      ),


      body: incorrectQuestions.isEmpty

          ? const Center(

        child: Text(

          "No incorrect answers 🎉",

          style: TextStyle(

            fontSize: 20,

          ),

        ),

      )


          : ListView.builder(

        padding: const EdgeInsets.all(16),

        itemCount: incorrectQuestions.length,


        itemBuilder: (context, index) {


          final question = incorrectQuestions[index];


          return Card(

            margin: const EdgeInsets.only(bottom: 20),


            child: Padding(

              padding: const EdgeInsets.all(16),


              child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,


                children: [


                  Text(
                    "Question ${index + 1}",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: Text(question.domain),
                      ),
                      Chip(
                        label: Text(question.difficulty),
                      ),
                      Chip(
                        label: Text(question.type),
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),



                  const SizedBox(height: 10),



                  Text(

                    question.question,

                    style: const TextStyle(

                      fontSize: 18,

                      fontWeight: FontWeight.bold,

                    ),

                  ),



                  const SizedBox(height: 20),



                  buildAnswer(

                    "A",

                    question.optionA,

                    question,

                  ),


                  buildAnswer(

                    "B",

                    question.optionB,

                    question,

                  ),


                  buildAnswer(

                    "C",

                    question.optionC,

                    question,

                  ),


                  buildAnswer(

                    "D",

                    question.optionD,

                    question,

                  ),



                  const SizedBox(height: 20),



                  const Text(

                    "Explanation:",

                    style: TextStyle(

                      fontWeight: FontWeight.bold,

                    ),

                  ),



                  const SizedBox(height: 5),



                  Text(

                    question.explanation,

                  ),


                ],

              ),

            ),

          );

        },

      ),

    );

  }



  Widget buildAnswer(

      String letter,

      String answer,

      Question question,

      ) {


    bool correct =

        question.correctAnswer
            .trim()
            .toUpperCase() == letter;


    bool selected =

        question.userAnswer
            ?.trim()
            .toUpperCase() == letter;



    Color? background;


    if (correct) {

      background = Colors.green;

    }


    if (selected && !correct) {

      background = Colors.red;

    }



    return Container(

      width: double.infinity,

      margin: const EdgeInsets.only(bottom: 8),


      padding: const EdgeInsets.all(12),


      decoration: BoxDecoration(

        color: background,

        borderRadius: BorderRadius.circular(8),

      ),


      child: Text(

        "$letter) $answer",

        style: TextStyle(

          color: background != null

              ? Colors.white

              : Colors.black,

        ),

      ),

    );

  }

}