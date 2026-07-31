import 'package:flutter/material.dart';

import '../../models/exam_result.dart';
import '../../services/history_service.dart';
import '../../services/practice_history_service.dart';

class RecentActivity extends StatefulWidget {
  const RecentActivity({super.key});

  @override
  State<RecentActivity> createState() => _RecentActivityState();
}

class _RecentActivityState extends State<RecentActivity> {

  final HistoryService _historyService = HistoryService();
  final PracticeHistoryService _practiceHistoryService =
  PracticeHistoryService();

  List<ExamResult> _practice = [];
  List<ExamResult> _mockExams = [];

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<void> _loadData() async {

    _practice =
    await _practiceHistoryService.getResults();

    _mockExams =
    await _historyService.getResults();

    if (mounted) {
      setState(() {});
    }
  }

  List<Widget> _buildRecentActivities() {
    final activities = <Map<String, dynamic>>[];

    for (final result in _practice) {
      activities.add({
        'result': result,
        'isMock': false,
      });
    }

    for (final result in _mockExams) {
      activities.add({
        'result': result,
        'isMock': true,
      });
    }

    activities.sort((a, b) {
      final ExamResult first = a['result'];
      final ExamResult second = b['result'];

      return second.date.compareTo(first.date);
    });

    final recent = activities.take(3).toList();

    if (recent.isEmpty) {
      return const [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: 24),
            child: Text(
              "No recent activity",
              style: TextStyle(
                color: Color(0xFF74829C),
              ),
            ),
          ),
        ),
      ];
    }

    final widgets = <Widget>[];

    for (int i = 0; i < recent.length; i++) {
      final result = recent[i]['result'] as ExamResult;
      final isMock = recent[i]['isMock'] as bool;

      widgets.add(
        _ActivityItem(
          color: isMock
              ? const Color(0xFF26A65B)
              : const Color(0xFF2D86FF),

          icon: isMock
              ? Icons.fact_check_rounded
              : Icons.menu_book_rounded,
          title: isMock ? "Mock Exam" : "Practice",
          subtitle:
          "${result.correctAnswers}/${result.totalQuestions} correct • ${result.percentage}%",
          time:
          "${result.date.day}/${result.date.month}/${result.date.year}",
        ),
      );

      if (i < recent.length - 1) {
        widgets.add(const Divider(height: 28));
      }
    }

    return widgets;
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
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
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          const Text(
            "Recent Activity",
            style: TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
              color: Color(0xFF173B7A),
            ),
          ),
          const SizedBox(height: 18),

          ..._buildRecentActivities(),
        ],
      ),
    );
  }
}

class _ActivityItem extends StatelessWidget {
  final Color color;
  final IconData icon;
  final String title;
  final String subtitle;
  final String time;

  const _ActivityItem({
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: () {},
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 6),
        child: Row(
          children: [

            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(18),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),

            const SizedBox(width: 16),

            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF173B7A),
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    subtitle,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF74829C),
                      height: 1.35,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(width: 12),

            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 5,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF4F7FB),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    time,
                    style: const TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF8A94A6),
                    ),
                  ),
                ),

                const SizedBox(height: 10),


              ],
            ),
          ],
        ),
      ),
    );
  }
}