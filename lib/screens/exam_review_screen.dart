import 'package:flutter/material.dart';
import '../models/question.dart';

enum ReviewFilter {
  all,
  answered,
  notAnswered,
  flagged,
}

class ExamReviewScreen extends StatefulWidget {
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
  State<ExamReviewScreen> createState() => _ExamReviewScreenState();
}
class _ExamReviewScreenState extends State<ExamReviewScreen> {
  ReviewFilter _filter = ReviewFilter.all;


  @override
  Widget build(BuildContext context) {

    final answeredCount = widget.userAnswers.length;
    final flaggedCount = widget.flaggedQuestions.length;
    final remainingCount = widget.questions.length - answeredCount;


    List<Question> filteredQuestions = widget.questions;

    switch (_filter) {
      case ReviewFilter.answered:
        filteredQuestions = widget.questions
            .where((q) => widget.userAnswers.containsKey(q.id))
            .toList();
        break;

      case ReviewFilter.notAnswered:
        filteredQuestions = widget.questions
            .where((q) => !widget.userAnswers.containsKey(q.id))
            .toList();
        break;

      case ReviewFilter.flagged:
        filteredQuestions = widget.questions
            .where((q) => widget.flaggedQuestions.contains(q.id))
            .toList();
        break;

      case ReviewFilter.all:
        break;
    }

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
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                FilterChip(
                  selected: _filter == ReviewFilter.all,
                  onSelected: (_) {
                    setState(() {
                      _filter = ReviewFilter.all;
                    });
                  },
                  label: const Text("All"),
                ),
                FilterChip(
                  selected: _filter == ReviewFilter.answered,
                  onSelected: (_) {
                    setState(() {
                      _filter = ReviewFilter.answered;
                    });
                  },
                  label: const Text("Answered"),
                ),
                FilterChip(
                  selected: _filter == ReviewFilter.notAnswered,
                  onSelected: (_) {
                    setState(() {
                      _filter = ReviewFilter.notAnswered;
                    });
                  },
                  label: const Text("Remaining"),
                ),
                FilterChip(
                  selected: _filter == ReviewFilter.flagged,
                  onSelected: (_) {
                    setState(() {
                      _filter = ReviewFilter.flagged;
                    });
                  },
                  label: const Text("🚩 Flagged"),
                ),
              ],
            ),

            const SizedBox(height: 20),
            Expanded(

              child: ListView.builder(

                itemCount: filteredQuestions.length,

                itemBuilder: (context, index) {

                  final question = filteredQuestions[index];

                  final answer = widget.userAnswers[question.id];

                  final isFlagged = widget.flaggedQuestions.contains(question.id);

                  final questionNumber =
                      widget.questions.indexWhere((q) => q.id == question.id) + 1;
                  final originalIndex =
                  widget.questions.indexWhere((q) => q.id == question.id);

                  return Card(
      child: ListTile(
        onTap: () {
          Navigator.pop(context, index);
          Navigator.pop(context, originalIndex);
        },
        leading: CircleAvatar(
          child: Text(
            "$questionNumber",
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

                onPressed: widget.onSubmit,

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