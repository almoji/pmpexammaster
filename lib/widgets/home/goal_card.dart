import 'package:flutter/material.dart';

class GoalCard extends StatelessWidget {

  final int completed;
  final int goal;
  final double accuracy;
  final int studyMinutes;


  const GoalCard({
    super.key,
    required this.completed,
    required this.goal,
    required this.accuracy,
    required this.studyMinutes,
  });



  @override
  Widget build(BuildContext context) {
    final progress = (completed / goal).clamp(0.0, 1.0);

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 35,
            spreadRadius: -6,
            offset: const Offset(0, 16),
          ),
        ],
      ),
      padding: const EdgeInsets.fromLTRB(26, 24, 26, 24),
      child: Column(
        children: [

          /// TOP
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              Container(
                width: 68,
                height: 68,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(22),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFF5CAEFF),
                      Color(0xFF2B82FF),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: const Icon(
                  Icons.track_changes_rounded,
                  color: Colors.white,
                  size: 38,
                ),
              ),

              const SizedBox(width: 18),

              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [

                    Text(
                      "Today's Goal",
                      style: TextStyle(
                        fontSize: 21,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF173B7A),
                      ),
                    ),

                    SizedBox(height: 6),

                    Text(
                      "Complete today's questions and keep your study streak alive.",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.45,
                        color: Color(0xFF6D7B95),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Text(
                    "${(progress * 100).round()}%",
                    style: const TextStyle(
                      color: Color(0xFF2B82FF),
                      fontWeight: FontWeight.bold,
                      fontSize: 32,
                    ),
                  ),

                  const SizedBox(height: 2),

                  Text(
                    "$completed / $goal",
                    style: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 15,
                      color: Color(0xFF173B7A),
                    ),
                  ),

                  const Text(
                    "questions",
                    style: TextStyle(
                      fontSize: 13,
                      color: Color(0xFF8A94A6),
                    ),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 24),

          /// Progress Bar
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: SizedBox(
              height: 12,
              child: LinearProgressIndicator(
                value: progress,
                color: const Color(0xFF2B82FF),
                backgroundColor: const Color(0xFFE7EEF8),
              ),
            ),
          ),

          const SizedBox(height: 22),

          Row(
            children: [

              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: const Color(0xFFEAF4FF),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Icon(
                  Icons.local_fire_department_rounded,
                  color: Colors.orange,
                  size: 22,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$completed questions completed today",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF4B587C),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      "${accuracy.toStringAsFixed(0)}% accuracy • $studyMinutes min",
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8A94A6),
                      ),
                    ),
                  ],
                ),
              ),


            ],
          ),
        ],
      ),
    );
  }
}