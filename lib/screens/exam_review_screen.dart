import 'package:flutter/material.dart';
import '../models/question.dart';

class ExamReviewScreen extends StatelessWidget {
  final List<Question> questions;
  final Map<int, Set<String>> userAnswers;
  final Set<int> flaggedQuestions;
  final VoidCallback onSubmit;

  const ExamReviewScreen({
    super.key,
    required this.questions,
    required this.userAnswers,
    required this.flaggedQuestions,
    required this.onSubmit,
  });


  @override
  Widget build(BuildContext context) {

    final answeredCount = userAnswers.length;
    final flaggedCount = flaggedQuestions.length;
    final remainingCount = questions.length - answeredCount;

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

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    Text(
                      "$answeredCount",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("Answered"),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "$flaggedCount",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("Flagged"),
                  ],
                ),
                Column(
                  children: [
                    Text(
                      "$remainingCount",
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Text("Remaining"),
                  ],
                ),
              ],
            ),

            const SizedBox(height: 20),

            Expanded(

              child: ListView.builder(

                itemCount: questions.length,

                itemBuilder: (context, index) {


    final question = questions[index];
    final answer = userAnswers[question.id];
    final isFlagged = flaggedQuestions.contains(question.id);


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
          isFlagged
              ? "Flagged"
              : (answer == null ? "Not Answered" : "Answered"),
        ),
        trailing: Icon(
          isFlagged
              ? Icons.flag
              : (answer == null
              ? Icons.radio_button_unchecked
              : Icons.check_circle),
          color: isFlagged
              ? Colors.orange
              : (answer == null
              ? Theme.of(context).colorScheme.error
              : Theme.of(context).colorScheme.primary),
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