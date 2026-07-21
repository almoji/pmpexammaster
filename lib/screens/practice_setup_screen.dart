import 'package:flutter/material.dart';

import '../models/practice_filter.dart';
import 'question_screen.dart';


class PracticeSetupScreen extends StatefulWidget {

  const PracticeSetupScreen({super.key});

  @override
  State<PracticeSetupScreen> createState() => _PracticeSetupScreenState();

}

class _PracticeSetupScreenState extends State<PracticeSetupScreen> {

  int _numberOfQuestions = 10;

  String _practiceMode = "Random Questions";

  String _selectedDomain = "People";

  String _selectedDifficulty = "Easy";

  String _selectedQuestionType = "Multiple Choice";

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Practice Setup",
        ),

      ),


      body: Center(

        child: Column(

          mainAxisAlignment: MainAxisAlignment.center,


          children: [


            const Text(

              "Practice Questions",

              style: TextStyle(

                fontSize: 28,

                fontWeight: FontWeight.bold,

              ),

            ),


            const SizedBox(height: 30),


            const Text(

              "Study mode\nInstant feedback enabled",

              textAlign: TextAlign.center,

              style: TextStyle(

                fontSize: 20,

              ),

            ),

            const SizedBox(height: 30),

            const Text(

              "Practice Mode",

              style: TextStyle(

                fontWeight: FontWeight.bold,

                fontSize: 18,

              ),

            ),

            const SizedBox(height: 10),

            SizedBox(

              width: 220,

              child: DropdownButton<String>(

                value: _practiceMode,

                isExpanded: true,

                items: const [

                  DropdownMenuItem(
                    value: "Random Questions",
                    child: Text("Random Questions"),
                  ),

                  DropdownMenuItem(
                    value: "By Domain",
                    child: Text("By Domain"),
                  ),

                  DropdownMenuItem(
                    value: "By Difficulty",
                    child: Text("By Difficulty"),
                  ),

                  DropdownMenuItem(
                    value: "By Question Type",
                    child: Text("By Question Type"),
                  ),

                  DropdownMenuItem(
                    value: "Incorrect Questions",
                    child: Text("Incorrect Questions ⭐"),
                  ),

                  DropdownMenuItem(
                    value: "Favorite Questions",
                    child: Text("Favorite Questions ❤️"),
                  ),

                ],

                onChanged: (value) {

                  setState(() {

                    _practiceMode = value!;

                  });

                },

              ),

            ),

            const SizedBox(height: 30),

            if (_practiceMode == "By Domain") ...[

              const Text(
                "Domain",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: 220,
                child: DropdownButton<String>(
                  value: _selectedDomain,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: "People",
                      child: Text("People"),
                    ),
                    DropdownMenuItem(
                      value: "Process",
                      child: Text("Process"),
                    ),
                    DropdownMenuItem(
                      value: "Business Environment",
                      child: Text("Business Environment"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedDomain = value!;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

            ],

            if (_practiceMode == "By Difficulty") ...[

              const Text(
                "Difficulty",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: 220,
                child: DropdownButton<String>(
                  value: _selectedDifficulty,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                      value: "Easy",
                      child: Text("Easy"),
                    ),
                    DropdownMenuItem(
                      value: "Moderate",
                      child: Text("Moderate"),
                    ),
                    DropdownMenuItem(
                      value: "Difficult",
                      child: Text("Difficult"),
                    ),
                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedDifficulty = value!;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

            ],

            if (_practiceMode == "By Question Type") ...[

              const Text(
                "Question Type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

              SizedBox(
                width: 220,
                child: DropdownButton<String>(
                  value: _selectedQuestionType,
                  isExpanded: true,
                  items: const [

                    DropdownMenuItem(
                      value: "Multiple Choice",
                      child: Text("Multiple Choice"),
                    ),

                    DropdownMenuItem(
                      value: "Multiple Response",
                      child: Text("Multiple Response"),
                    ),

                  ],
                  onChanged: (value) {
                    setState(() {
                      _selectedQuestionType = value!;
                    });
                  },
                ),
              ),

              const SizedBox(height: 30),

            ],

            const Text(

              "Number of questions",

              style: TextStyle(

                fontWeight: FontWeight.bold,

                fontSize: 18,

              ),

            ),

            const SizedBox(height: 10),

            SizedBox(

              width: 220,

              child: DropdownButton<int>(

                value: _numberOfQuestions,

                isExpanded: true,

                items: const [

                  DropdownMenuItem(

                    value: 10,

                    child: Text("10 Questions"),

                  ),

                  DropdownMenuItem(

                    value: 20,

                    child: Text("20 Questions"),

                  ),

                  DropdownMenuItem(

                    value: 50,

                    child: Text("50 Questions"),

                  ),

                  DropdownMenuItem(

                    value: 1000,

                    child: Text("All Available Questions"),

                  ),

                ],

                onChanged: (value) {

                  setState(() {

                    _numberOfQuestions = value!;

                  });

                },

              ),

            ),

            const SizedBox(height: 40),


            ElevatedButton(

              onPressed: () {


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) => QuestionScreen(

                      numberOfQuestions: _numberOfQuestions,

                      examSeconds: 3600,

                      isMockExam: false,

                      practiceFilter: PracticeFilter(

                        mode: _practiceMode,

                        domain: _selectedDomain,

                        difficulty: _selectedDifficulty,

                        questionType: _selectedQuestionType,

                      ),

                    ),

                  ),

                );


              },


              child: const Text(

                "START PRACTICE",

              ),

            ),


          ],

        ),

      ),

    );

  }

}