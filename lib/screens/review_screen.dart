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
      backgroundColor: const Color(0xFFF6F9FE),

      appBar: AppBar(

        title: const Text(

          "Review Incorrect Answers",

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
            child: SafeArea(
              child: incorrectQuestions.isEmpty

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


          return Container(

            margin: const EdgeInsets.only(bottom: 20),

            padding: const EdgeInsets.all(20),

            decoration: BoxDecoration(

              color: Colors.white,

              borderRadius: BorderRadius.circular(28),

              boxShadow: [

                BoxShadow(

                  color: Colors.black.withValues(alpha: 0.05),

                  blurRadius: 30,

                  spreadRadius: -8,

                  offset: const Offset(0, 14),

                ),

              ],

            ),

            child: Column(

                crossAxisAlignment:
                CrossAxisAlignment.start,


                children: [


                  Row(
                    children: [

                      Expanded(
                        child: Text(
                          "Question ${index + 1} of ${incorrectQuestions.length}",
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF173B7A),
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFFFF2F2),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: const Text(
                          "Incorrect",
                          style: TextStyle(
                            color: Color(0xFFE5484D),
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 14),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEAF4FF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          question.domain,
                          style: const TextStyle(
                            color: Color(0xFF2D86FF),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFEFFAF3),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          question.difficulty,
                          style: const TextStyle(
                            color: Color(0xFF18B76A),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF4EDFF),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          question.type,
                          style: const TextStyle(
                            color: Color(0xFF8B5CF6),
                            fontWeight: FontWeight.w600,
                            fontSize: 13,
                          ),
                        ),
                      ),

                    ],
                  ),

                  const SizedBox(height: 18),

                  Text(
                    question.question,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF173B7A),
                      height: 1.55,
                    ),
                  ),

                  const SizedBox(height: 24),



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



                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFF8FBFF),
                      borderRadius: BorderRadius.circular(18),
                      border: Border.all(
                        color: const Color(0xFFE6EEF8),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        const Row(
                          children: [

                            Icon(
                              Icons.lightbulb_rounded,
                              color: Color(0xFF2D86FF),
                              size: 22,
                            ),

                            SizedBox(width: 8),

                            Text(
                              "Explanation",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF173B7A),
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 12),

                        Text(
                          question.explanation,
                          style: const TextStyle(
                            fontSize: 15,
                            height: 1.6,
                            color: Color(0xFF4B5565),
                          ),
                        ),

                      ],
                    ),
                  ),


                ],

            ),

          );

        },

              ), // ListView.builder

            ), // SafeArea

        ), // Container

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
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 16,
      ),
      decoration: BoxDecoration(

        color: background ??
            Colors.white,

        borderRadius: BorderRadius.circular(18),

        border: Border.all(

          color: correct
              ? const Color(0xFF18B76A)
              : selected
              ? const Color(0xFFE5484D)
              : const Color(0xFFE6EEF8),

          width: 1.5,

        ),

      ),

      child: Row(

        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Container(

            width: 28,
            height: 28,

            decoration: BoxDecoration(

              color: correct
                  ? const Color(0xFF18B76A)
                  : selected
                  ? const Color(0xFFE5484D)
                  : const Color(0xFFEAF4FF),

              shape: BoxShape.circle,

            ),

            child: Center(

              child: Text(

                letter,

                style: TextStyle(

                  color: correct || selected
                      ? Colors.white
                      : const Color(0xFF2D86FF),

                  fontWeight: FontWeight.bold,

                ),

              ),

            ),

          ),

          const SizedBox(width: 14),

          Expanded(

            child: Column(

              crossAxisAlignment: CrossAxisAlignment.start,

              children: [

                if (correct)

                  const Padding(

                    padding: EdgeInsets.only(bottom: 6),

                    child: Row(

                      children: [

                        Icon(
                          Icons.check_circle,
                          color: Colors.white,
                          size: 16,
                        ),

                        SizedBox(width: 6),

                        Text(
                          "Correct Answer",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),

                      ],

                    ),

                  ),

                if (selected && !correct)

                  const Padding(

                    padding: EdgeInsets.only(bottom: 6),

                    child: Row(

                      children: [

                        Icon(
                          Icons.cancel,
                          color: Colors.white,
                          size: 16,
                        ),

                        SizedBox(width: 6),

                        Text(
                          "Your Answer",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 13,
                          ),
                        ),

                      ],

                    ),

                  ),

                Text(

                  answer,

                  style: TextStyle(

                    fontSize: 15,

                    height: 1.5,

                    color: correct || selected
                        ? Colors.white
                        : const Color(0xFF173B7A),

                  ),

                ),

              ],

            ),

          ),

        ],

      ),

    );

  }

}