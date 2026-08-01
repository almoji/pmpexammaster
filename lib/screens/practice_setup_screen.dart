import 'package:flutter/material.dart';

import '../models/practice_filter.dart';
import '../services/question_data_service.dart';
import 'question_screen.dart';

import '../widgets/practice_setup/practice_mode_card.dart';
import '../widgets/practice_setup/practice_header.dart';
import '../widgets/practice_setup/practice_question_card.dart';
import '../widgets/practice_setup/practice_summary_card.dart';
import '../widgets/practice_setup/practice_start_button.dart';
import '../widgets/practice_setup/practice_option_button.dart';
import '../widgets/app_dropdown.dart';
import '../widgets/ads/banner_ad_widget.dart';


class PracticeSetupScreen extends StatefulWidget {

  final String? initialDomain;

  const PracticeSetupScreen({
    super.key,
    this.initialDomain,
  });

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

  late String _selectedDomain;

  String _selectedDifficulty = "Easy";

  String _selectedQuestionType = "Multiple Choice";

  @override
  void initState() {
    super.initState();

    _selectedDomain = widget.initialDomain ?? "People";

    if (widget.initialDomain != null) {
      _practiceMode = "By Domain";
    }

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

        Row(
          children: [

            Icon(
              title == "Quick Practice"
                  ? Icons.flash_on_rounded
                  : title == "Deep Study"
                  ? Icons.psychology_rounded
                  : Icons.flag_rounded,
              color: const Color(0xFF2D86FF),
              size: 20,
            ),

            const SizedBox(width:14),

            Text(
              title,
              style: const TextStyle(
                fontSize:17,
                fontWeight: FontWeight.bold,
                color: Color(0xFF173B7A),
              ),
            ),

          ],
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 42,
          child: Row(
            children: sizes.map((size) {
              return Padding(
                padding: const EdgeInsets.only(right: 10),
                child: PracticeOptionButton(
                  text: "$size",
                  width: 82,
                  selected: _numberOfQuestions == size,
                  onTap: () {
                    setState(() {
                      _numberOfQuestions = size;
                    });
                  },
                ),
              );
            }).toList(),
          ),
        ),

        const SizedBox(height: 16),

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
            padding: const EdgeInsets.all(22),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  const PracticeHeader(),

                  const SizedBox(height:10),

                  PracticeModeCard(
                    value: _practiceMode,
                    onChanged: (value){
                      setState(() {
                        _practiceMode=value;
                      });
                    },
                  ),

                  const SizedBox(height:10),

                  if (_practiceMode == "By Domain") ...[

              const Text(
                "Domain",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 10),

                    AppDropdown<String>(
                      value: _selectedDomain,

                      onChanged: (value) {
                        setState(() {
                          _selectedDomain = value;
                        });
                      },

                      entries: const [
                        DropdownMenuEntry(
                          value: "People",
                          label: "People",
                        ),
                        DropdownMenuEntry(
                          value: "Process",
                          label: "Process",
                        ),
                        DropdownMenuEntry(
                          value: "Business Environment",
                          label: "Business Environment",
                        ),
                      ],
                    ),

              const SizedBox(height: 10),

            ],

            if (_practiceMode == "By Difficulty") ...[

              const Text(
                "Difficulty",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 16),

              AppDropdown<String>(
                value: _selectedDifficulty,

                onChanged: (value) {
                  setState(() {
                    _selectedDifficulty = value;
                  });
                },

                entries: const [
                  DropdownMenuEntry(
                    value: "Easy",
                    label: "Easy",
                  ),
                  DropdownMenuEntry(
                    value: "Moderate",
                    label: "Moderate",
                  ),
                  DropdownMenuEntry(
                    value: "Difficult",
                    label: "Difficult",
                  ),
                ],
              ),

              const SizedBox(height: 16),

            ],

            if (_practiceMode == "By Question Type") ...[

              const Text(
                "Question Type",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),

              const SizedBox(height: 16),

              AppDropdown<String>(
                value: _selectedQuestionType,

                onChanged: (value) {
                  setState(() {
                    _selectedQuestionType = value;
                  });
                },

                entries: const [
                  DropdownMenuEntry(
                    value: "Multiple Choice",
                    label: "Multiple Choice",
                  ),
                  DropdownMenuEntry(
                    value: "Multiple Response",
                    label: "Multiple Response",
                  ),
                ],
              ),

              const SizedBox(height: 10),

            ],

                  PracticeQuestionCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [


                        _buildPracticeGroup(
                          title: "Quick Practice",
                          sizes: _practiceGroups["Quick Practice"]!,
                        ),


                        _buildPracticeGroup(
                          title: "Deep Study",
                          sizes: _practiceGroups["Deep Study"]!,
                        ),

                        _buildPracticeGroup(
                          title: "Marathon",
                          sizes: _practiceGroups["Marathon"]!,
                        ),

                        Row(
                          children: [

                            const Icon(
                              Icons.auto_stories_rounded,
                              color: Color(0xFF2D86FF),
                              size: 20,
                            ),

                            const SizedBox(width: 8),

                            const Text(
                              "Complete Question Bank",
                              style: TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF173B7A),
                              ),
                            ),

                          ],
                        ),

                        const SizedBox(height: 16),

                        PracticeOptionButton(
                          text: "ALL ($_totalQuestions)",
                          width: 150,
                          selected: _numberOfQuestions == _totalQuestions,
                          onTap: () {
                            setState(() {
                              _numberOfQuestions = _totalQuestions;
                            });
                          },
                        ),

                      ],
                    ),
                  ),


            const SizedBox(height: 10),

                  PracticeSummaryCard(
                    questions: _numberOfQuestions,
                    time: _numberOfQuestions == _totalQuestions
                        ? "∞"
                        : _estimatedStudyTime(),
                    goal: _studyGoal(),
                  ),

                  const SizedBox(height: 30),

                  PracticeStartButton(
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
                  ),

                  const SizedBox(height: 24),

                  const BannerAdWidget(),


              ],
            ),
          ),
        ),
    );

  }

}