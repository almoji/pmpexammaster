import 'package:flutter/material.dart';

import '../models/practice_filter.dart';
import '../services/question_data_service.dart';
import 'question_screen.dart';

import '../theme/app_text_styles.dart';


class PracticeSetupScreen extends StatefulWidget {

  const PracticeSetupScreen({super.key});

  @override
  State<PracticeSetupScreen> createState() => _PracticeSetupScreenState();

}

class _PracticeSetupScreenState extends State<PracticeSetupScreen> {

  int _numberOfQuestions = 10;

  int _totalQuestions = 0;


  static const Map<String, List<int>> _practiceGroups = {
    "Quick Practice": [10, 20, 50],
    "Deep Study": [100, 200, 400],
    "Marathon": [800],
  };

  String _practiceMode = "Random Questions";

  String _selectedDomain = "People";

  String _selectedDifficulty = "Easy";

  String _selectedQuestionType = "Multiple Choice";

  @override
  void initState() {
    super.initState();
    _loadQuestionCount();
  }

  Future<void> _loadQuestionCount() async {
    final count = await QuestionDataService().getQuestionCount();

    setState(() {
      _totalQuestions = count;
    });
  }

  String _estimatedStudyTime() {
    const int secondsPerQuestion = 90;

    final totalMinutes =
    (_numberOfQuestions * secondsPerQuestion / 60).round();

    if (totalMinutes < 60) {
      return "$totalMinutes min";
    }

    final hours = totalMinutes ~/ 60;
    final minutes = totalMinutes % 60;

    if (minutes == 0) {
      return "$hours h";
    }

    return "$hours h $minutes min";
  }

  int _practiceSeconds() {
    // ALL Questions = sin límite de tiempo
    if (_numberOfQuestions == _totalQuestions) {
      return 0;
    }

    // 90 segundos por pregunta
    return _numberOfQuestions * 90;
  }

  String _studyGoal() {
    if (_numberOfQuestions <= 20) {
      return "Coffee Break";
    }

    if (_numberOfQuestions <= 50) {
      return "Quick Practice";
    }

    if (_numberOfQuestions <= 200) {
      return "Focused Learning";
    }

    if (_numberOfQuestions <= 800) {
      return "Deep Study";
    }

    return "Complete Question Bank";
  }

  Widget _buildPracticeGroup({
    required String title,
    required List<int> sizes,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),

        const SizedBox(height: 8),

        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: sizes.map((size) {

            return ChoiceChip(
              label: Text("$size"),
              selected: _numberOfQuestions == size,
              onSelected: (_) {
                setState(() {
                  _numberOfQuestions = size;
                });
              },
            );

          }).toList(),
        ),

        const SizedBox(height: 20),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(

        title: const Text(
          "Practice Setup",
        ),

      ),


        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
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
                  style: AppTextStyles.sectionHeading,
                ),

            const SizedBox(height: 10),

            SizedBox(

              width: 220,

              child: DropdownButton<String>(

                value: _practiceMode,

                isExpanded: true,

                items: [

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
              "Number of Questions",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),

            const SizedBox(height: 20),

            _buildPracticeGroup(
              title: "Quick Practice",
              sizes: _practiceGroups["Quick Practice"]!,
            ),
            const SizedBox(height: 20),

            _buildPracticeGroup(
              title: "Deep Study",
              sizes: _practiceGroups["Deep Study"]!,
            ),

            _buildPracticeGroup(
              title: "Marathon",
              sizes: _practiceGroups["Marathon"]!,
            ),

              Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Complete Question Bank",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                  ),
                ),
              ),

              const SizedBox(height: 8),

              ChoiceChip(
                label: Text("ALL ($_totalQuestions)"),
                selected: _numberOfQuestions == _totalQuestions,
                onSelected: (_) {
                  setState(() {
                    _numberOfQuestions = _totalQuestions;
                  });
                },
              ),

            const SizedBox(height: 40),

            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [

                    const Row(
                      children: [
                        Icon(Icons.menu_book),
                        SizedBox(width: 8),
                        Text(
                          "Study Session",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Questions"),
                        Text(
                          "$_numberOfQuestions",
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Estimated Time"),
                        Text(
                          _numberOfQuestions == _totalQuestions
                              ? "No Time Limit"
                              : _estimatedStudyTime(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                    const SizedBox(height: 8),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("Goal"),
                        Text(
                          _studyGoal(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),

                  ],
                ),
              ),
            ),

            const SizedBox(height: 30),

            ElevatedButton(

              onPressed: () {


                Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (context) => QuestionScreen(

                      numberOfQuestions: _numberOfQuestions,

                      examSeconds: _practiceSeconds(),

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
        ),
    );

  }

}