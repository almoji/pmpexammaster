import 'package:flutter/material.dart';
import '../models/question.dart';

class ExamReviewScreen extends StatelessWidget {

  final List<Question> questions;

  final Map<int, Set<String>> userAnswers;

  final VoidCallback onSubmit;

  const ExamReviewScreen({

    super.key,

    required this.questions,

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
              "Answered: ${userAnswers.length} / ${questions.length}",
              style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 20),

            Expanded(

              child: ListView.builder(

                itemCount: questions.length,

                itemBuilder: (context, index) {


    final question = questions[index];
    final answer = userAnswers[question.id];


    return Card(
      child: ListTile(
        onTap: () {
          Navigator.pop(context, index);
        },
        leading: CircleAvatar(
          child: Text(
            "${index + 1}",
          ),
        ),
        title: Text(
          answer == null ? "Not Answered" : "Answered",
        ),
        trailing: Icon(
          answer == null
              ? Icons.radio_button_unchecked
              : Icons.check_circle,
          color: answer == null
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary,
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